/*
*
* Copyright (C) 2017 Mike Ray <mike.ray@btinternet.com>
*
* This is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2, or (at your option)
* any later version.
*
* This software is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this package; see the file COPYING.  If not, write to
* the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301, USA.
*
*--code--*/

#include "config.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <pthread.h>
#include <semaphore.h>

#include <ilctts/ilctts_lib.h>

#include "debug.h"
#include "parser.h"
#include "queue.h"
#include "server.h"
#include "pcregex.h"

int yydebug;


TTS_STATE_T tts_state;
Queue tts_queue;

/* mutex protecting the queue */
pthread_mutex_t queue_guard_mutex;

/* semaphore signalled when the dispatch function is received from emacspeak */
sem_t dispatch_semaphore;

/* log file descriptor */
int logfd;



TTSRENDER_STATE_T *st;

volatile int stop_requested = 0;


/*
*
* These are internally used functions, IOW not called from the parser.
*
*/


int synth_callback(short *wav, int numsamples, espeak_EVENT *events) {
	TTSRENDER_STATE_T *tts = (TTSRENDER_STATE_T*)events->user_data;
	int written;

	if (stop_requested) {
		stop_requested = 0;
		return 1;
	}

	if (numsamples) {
		ilctts_wait_space(tts);
		ilctts_lock_ringbuffer(tts);

		written = ilctts_pcm_write(tts, (void*)wav, numsamples);

		ilctts_unlock_ringbuffer(tts);
		ilctts_post_data(tts);
	}

	while(events->type != espeakEVENT_LIST_TERMINATED) {
		events++;
	}

	return 0;
} // end Synth_callback

/* called each time the lexer needs stuff to lex */
int input_for_lexer(char *buf, int *bytes_read, int max_bytes)
{
	*bytes_read = read(0, (void*)buf, max_bytes);
	return 0;
} /* end input_for_lexer */


/* passed to queue_init as a function pointer and called when the queue is destroyed */
void free_queue_entry(void *data)
{
	TTS_QUEUE_ENTRY_T *qe = (TTS_QUEUE_ENTRY_T*)data;
	free((char*)qe->speech);
	free(qe);
	return;
} /* free_queue_entry */

/*
* queue a chunk of speech.
* Guarded by queue_guard_mutex in tts_q
*/
int queue_speech(int entry_type, char *speech)
{
	TTS_QUEUE_ENTRY_T *qe;

   	if ((qe = (TTS_QUEUE_ENTRY_T *)malloc(sizeof(TTS_QUEUE_ENTRY_T))) == NULL)
		return -1;

	if ((qe->speech = (char *)malloc(strlen(speech)+1)) == NULL)
		return -1;

	qe->type = entry_type;
	qe->length = strlen(speech);
	sprintf(qe->speech, speech);

	if (queue_push(&tts_queue, qe) != 0)
		return -1;

	free(speech);
	return 0;
} /* queue_speech */

/*
* Dispatch one chunk of speech to espeak.
* Guarded by queue_guard_mutex in the dispatch thread
*/
int send_speech(void)
{
	espeak_ERROR erc;
	TTS_QUEUE_ENTRY_T *qe;
	ListElmt *element;

	if (queue_size(&tts_queue) < 1)
		return -1;

	if ( (element = malloc(sizeof(ListElmt))) == NULL)
		return -1;

	queue_pop(&tts_queue, (void*)element);
	qe = (TTS_QUEUE_ENTRY_T*)list_data(element);

	erc = espeak_Synth(qe->speech, qe->length+1, 0, POS_CHARACTER, 0, SYNTH_FLAGS, NULL, st);

	free(qe->speech);
	free(element);
	return 0;
} /* send_speech */


/* Empty the queue by destroying and re-initialising it */
int empty_queue(void)
{
	queue_destroy(&tts_queue);
	queue_init(&tts_queue, free_queue_entry);
	return 0;
} /* empty_queue */

/*
* This is the dispatch thread which is started at process start and keeps
* running all the time.
*/
void *dispatch_thread(void *arg)
{
	TTS_QUEUE_ENTRY_T *qe;
	char *speech;
	//debug_log(logfd, "Started dispatch thread\n");
	while(1) {
		/* wait for dispatch command from emacspeak */
		sem_wait(&dispatch_semaphore);
		while(queue_size(&tts_queue) > 0) {
			pthread_mutex_lock(&queue_guard_mutex);
			/* Is queue size still > 0 after getting mutex lock? */
			if (queue_size(&tts_queue) > 0)
				send_speech();

			pthread_mutex_unlock(&queue_guard_mutex);
		}
	}

	return NULL;
} /* dispatch_thread */


/*
*
* Below this point are functions called from the parser
*
*/


void tts_version(void)
{
	tts_say(PACKAGE_STRING);
	//debug_log(logfd, "Called tts_version\n");
	return;
} /* end tts_version */

void tts_say(char *text)
{
	int rc;
	espeak_ERROR erc;
	char *newtext = calloc(1,strlen(text));
	/* remove all occurrences of [*] from the speech string */
	//debug_log(logfd, "Called tts_say: %s\n", text);
	clean_string(text, newtext, "\\[\\*\\]", " ");
	pthread_mutex_lock(&queue_guard_mutex);
	ilctts_stop_request(st);
	erc = espeak_Cancel();
	//debug_log(logfd, "In tts_say espeak_Cancel returned %d\n", erc);
	rc = empty_queue();
	stop_requested = 0;
	erc = espeak_Synth(newtext, strlen(newtext)+1, 0, POS_CHARACTER, 0, SYNTH_FLAGS, NULL, st);
	//debug_log(logfd,"In tts_say espeak_Synth returned %d\n", erc);
	pthread_mutex_unlock(&queue_guard_mutex);
	return;
} /* end tts_say */

void tts_l(const char ch)
{
	/* neither espeak_Char nor espeak_Key honour the setting of split_caps (say 'capital') if it is OFF, so use synth */
	char pair[2];
	pair[0] =ch;
	pair[1] = 0;
	espeak_ERROR erc;
	//debug_log(logfd,"Called tts_l\n");
	ilctts_stop_request(st);
	erc = espeak_Cancel();
	//debug_log(logfd, "In tts_l espeak_Cancel returned: %d\n", erc);
	stop_requested = 0;
	erc = espeak_Synth(pair, 2, 0, POS_CHARACTER, 0, 0, NULL, st);
		//debug_log(logfd, "In tts_l espeak_Synth returned: %d\n", erc);
	return;
} /* end tts_l */

void tts_d(void)
{
	/* post semaphore to start queue processing */
	sem_post(&dispatch_semaphore);
	stop_requested = 0;
	return;
} /* end tts_d */

void tts_pause(void)
{
	ilctts_pause(st);
	//debug_log(logfd, "Called tts_pause\n");
	return;
} /* end tts_pause */

void tts_resume(void)
{
	ilctts_resume(st);
	//debug_log(logfd, "Called tts_resume\n");
	return;
} /* end tts_resume */

void tts_s(void)
{
	int rc;
	ilctts_stop_request(st);
	stop_requested = 1;
	rc = espeak_Cancel();
	pthread_mutex_lock(&queue_guard_mutex);
	/* flush the queue */
	empty_queue();
	pthread_mutex_unlock(&queue_guard_mutex);
	return;
} /* end tts_s */

void tts_q(char *speech)
{
	//debug_log(logfd, "Called tts_q to queue: %s\n", speech);
	pthread_mutex_lock(&queue_guard_mutex);
	queue_speech(1, speech);
	pthread_mutex_unlock(&queue_guard_mutex);
	return;
} /* end tts_q */

void tts_c(char *code)
{
	//debug_log(logfd, "Called tts_c: %s\n", code);
	pthread_mutex_lock(&queue_guard_mutex);
	queue_speech(2, code);
	pthread_mutex_unlock(&queue_guard_mutex);
	return;
} /* end tts_c */

void tts_a(const char *filename)
{
	char buffer[255];
	//debug_log(logfd, "Called tts_a: %s\n", filename);
	sprintf(buffer, "play -q %s", filename);
	//debug_log(logfd, "In tts_a, play command: %s\n", buffer);
	system_(buffer);
	return;
} /* end tts_a */

void tts_b(int pitch, int duration)
{
	char buffer[64];
	sprintf(buffer, "beep -f %d -l %d", pitch, duration);
	system_(buffer);
	//debug_log(logfd, "In tts_b, beep command: %s\n", buffer);
	return;
} /* end tts_b */

void tts_t(int pitch, int duration)
{
	double secs = duration / 1000.0;
	char buffer[64];
	sprintf(buffer, "play -qn synth %f sin %d", secs, pitch);
	system_(buffer);
	//debug_log(logfd, "In tts_t, play command: %s\n", buffer);
	return;
} /* end tts_t */

void tts_sh(int duration_milliseconds)
{
	/* not implemented yet */
	//debug_log(logfd, "Called tts_sh\n");
	return;
} /* end tts_sh */

void tts_reset(void)
{
	/* not implemented yet */
	//debug_log(logfd, "Called tts_reset\n");
	return;
} /* end tts_reset */

void tts_set_punctuations(int punct_level)
{
	espeak_ERROR erc;
	//debug_log(logfd, "Called tts_set_punctuations: %d\n", punct_level);
	erc = espeak_SetParameter(espeakPUNCTUATION, punct_level, 0);
	//debug_log(logfd, "In tts_set_punctuations espeak_SetParameter returned: %d\n", erc);
	return;
} /* end tts_set_punctuations */

void tts_set_speech_rate(int speech_rate)
{
	espeak_ERROR erc;
	//debug_log(logfd, "Called tts_set_speech_rate: %d\n", speech_rate);
	tts_state.speech_rate = speech_rate;
	erc = espeak_SetParameter(espeakRATE, speech_rate, 0);
	//debug_log(logfd, "In tts_set_speech_rate espeak_SetParameter returned: %d\n", erc);
	return;
} /* end tts_set_speech_rate */

void tts_set_character_scale(double character_scale)
{
	/* not implemented yet */
	//debug_log(logfd, "Called tts_character_scale\n");
	tts_state.character_scale = character_scale;
	return;
} /* end tts_set_character_scale */

void tts_split_caps(int split_caps)
{
	/* speak camel-case, IOW say 'capital' for every capital letter */
	espeak_ERROR erc;
	//debug_log(logfd, "Called tts_split_caps: %d\n", split_caps); 
	tts_state.split_caps = split_caps;
	if (split_caps) {
		tts_capitalize(0);
		tts_allcaps_beep(0);
	}
	erc = espeak_SetParameter(espeakCAPITALS, (split_caps ? 2 : 0), 0);
	//debug_log(logfd, "In tts_split_caps espeak_SetParameter returned: %d\n", erc);

	return;
} /* end tts_split_caps */

void tts_capitalize(int capitalize)
{
	/* indicate capital by pitch */
	espeak_ERROR erc;
	//debug_log(logfd, "Called tts_capitalize: %d\n", capitalize);
	tts_state.capitalize = capitalize;
	if (capitalize) {
		tts_allcaps_beep(0);
		tts_split_caps(0);
	}
	erc = espeak_SetParameter(espeakCAPITALS, (capitalize ? 3 : 0), 0);
	//debug_log(logfd, "In tts_capitalize espeak_SetParameter returned: %d\n", erc);
	return;
} /* end tts_capitalize */

void tts_allcaps_beep(int allcaps_beep)
{
	/* high pitched beep for capital letter */
	espeak_ERROR erc;
	tts_state.allcaps_beep = allcaps_beep;
	if (allcaps_beep) {
		tts_capitalize(0);
		tts_split_caps(0);
	}
	//debug_log(logfd, "Called tts_allcaps_beep: %d\n", allcaps_beep);
	erc = espeak_SetParameter(espeakCAPITALS, (allcaps_beep ? 1 : 0), 0);
	//debug_log(logfd, "In tts_allcaps_beep espeak_SetParameter returned: %d\n", erc);
	return;
} /* end tts_allcaps_beep */


void tts_sync_state(
	int punct_level,
	int capitalize,
	int allcaps_beep,
	int split_caps,
	int speech_rate)
{

	tts_set_punctuations(punct_level);
	if (capitalize)
		tts_capitalize(capitalize);
	if (allcaps_beep)
		tts_allcaps_beep(allcaps_beep);
	if (split_caps)
		tts_split_caps(split_caps);

tts_set_speech_rate(speech_rate);
/*
	debug_log(
		logfd, 
		"Called tts_sync_state, punct_level: %d capitalize: %d allcaps_beep: %d split_caps: %d speech_rate: %d\n",
		punct_level,
		capitalize, 
allcaps_beep, 
split_caps,
		speech_rate
	);
*/
	return;
} /* end tts_sync_state */


int tts_initialize(void)
{
	int rc;
	espeak_ERROR erc;
	pthread_t qthr;
	logfd = create_log_file("/tmp/espiespeak-", CPF_CLOEXEC);
	//debug_log(logfd, "Called tts_initialize\n");
	rc = sem_init(&dispatch_semaphore, 0, 0);
	if (rc < 0) {
		//debug_log(logfd, "Failed to initialize dispatch_semaphore in tts_initialize\n");
		return 1;
	}

	rc = pthread_mutex_init(&queue_guard_mutex, NULL);
	if (rc < 0) {
		//debug_log(logfd, "Failed to initialize queue_guard_mutex in tts_initialize\n");
		return 1;
	}

	queue_init(&tts_queue, free_queue_entry);

rc = pthread_create(&qthr, NULL, dispatch_thread, (void*)&tts_queue);

	rc = ilctts_initialize();
	if (rc < 0) {
		return 1;
	}

	rc = ilctts_create(&st, 22050, 1, 16, ILC_BUF_COUNT, BUF_SIZE_MS, 0, (1024*6));
	if (rc < 0) {
		return 1;
	}

	rc = ilctts_set_dest(st, "local");
	if (rc < 0) {
		return 1;
	}

	rc = ilctts_start_ringbuffer_consumer_thread(st);
	if (rc < 0) {
		return 1;
	}

erc = espeak_Initialize(AUDIO_OUTPUT_RETRIEVAL, BUF_SIZE_MS, NULL, 0);
	if (erc != 22050)
		return -1;

	espeak_SetSynthCallback(synth_callback);

	ilctts_post_space(st);

	tts_split_caps(0);

	return erc;
} /* end tts_initialize */

int tts_terminate(void)
{
	espeak_ERROR erc;
	erc = espeak_Terminate();
	return 0;
} /* end tts_terminate */



int main(int argc, char **argv)
{

	/* give argument -d on command-line to switch on bison parser yydebug */
	if(argc > 1 && !strcmp(argv[1], "-d")) {
		yydebug = 1; argc--; argv++;
	} else {
		fclose(stderr);
	}

	int rc = tts_initialize();
	if (rc == -1) {
		//debug_log(logfd,"Call to tts_initialize returned error code\n");
		return 1;
	}

	yyparse();

	return 0;

}




