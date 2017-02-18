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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <pthread.h>
#include <semaphore.h>

#include "debug.h"
#include "parser.h"
#include "queue.h"
#include "server.h"


TTS_STATE_T tts_state;
Queue tts_queue;

/* mutex protecting the queue */
pthread_mutex_t queue_guard_mutex;

/* semaphore signalled when the dispatch function is received from emacspeak */
sem_t dispatch_semaphore;

/* log file descriptor */
int logfd;


/*
*
* These are internally used functions, IOW not called from the parser.
*
*/

int input_for_lexer(char *buf, int *bytes_read, int max_bytes)
{
	*bytes_read = read(0, (void*)buf, max_bytes);
	return 0;
} /* end input_for_lexer */



void free_queue_entry(void *data)
{
	TTS_QUEUE_ENTRY_T *qe = (TTS_QUEUE_ENTRY_T*)data;
	free((char*)qe->speech);
	free(qe);
	return;
} /* free_queue_entry */

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

	erc = espeak_Synth(qe->speech, qe->length+1, 0, POS_CHARACTER, 0, espeakPHONEMES, NULL, NULL);

	/* not sure yet about these free() calls here */
	free(qe->speech);
	free(element);
	return 0;
} /* send_speech */


int empty_queue(void)
{
	queue_destroy(&tts_queue);
	queue_init(&tts_queue, free_queue_entry);
	return 0;
} /* empty_queue */


void *dispatch_thread(void *arg)
{
	TTS_QUEUE_ENTRY_T *qe;
	char *speech;
	debug_log(logfd, "Started dispatch thread\n");
	while(1) {
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
	/* not implemented yet */
	debug_log(logfd, "Called tts_version\n");
	return;
} /* end tts_version */

void tts_say(char *text)
{
	/* still to improve paranoia checking */
	int rc;
	espeak_ERROR erc;
	pthread_mutex_lock(&queue_guard_mutex);
	erc = espeak_Cancel();
	debug_log(logfd, "In tts_say espeak_Cancel returned %d\n", erc);
	rc = empty_queue();
	erc = espeak_Synth(text, strlen(text)+1, 0, POS_CHARACTER, 0, espeakPHONEMES, NULL, NULL);
	debug_log(logfd,"In tts_say espeak_Synth returned %d\n", erc);
	pthread_mutex_unlock(&queue_guard_mutex);
	return;
} /* end tts_say */

void tts_l(const char ch)
{
	/* still to improve paranoia checking */
	espeak_ERROR erc;
	erc = espeak_Cancel();
	debug_log(logfd, "In tts_l espeak_Cancel returned: %d\n", erc);
	erc = espeak_Char(ch);
	debug_log(logfd, "In tts_l espeak_Char returned: %d\n", erc);
	return;
} /* end tts_l */

void tts_d(void)
{
	debug_log(logfd,"Called tts_d\n");
	/* post semaphore to start queue processing */
	sem_post(&dispatch_semaphore);
	return;
} /* end tts_d */

void tts_pause(void)
{
	/* not implemented yet */
	debug_log(logfd, "Called tts_pause\n");
	return;
} /* end tts_pause */

void tts_resume(void)
{
	/* not implemented yet */
	debug_log(logfd, "Called tts_resume\n");
	return;
} /* end tts_resume */

void tts_s(void)
{
	int rc;
	debug_log(logfd, "Called tts_s\n");
	pthread_mutex_lock(&queue_guard_mutex);
	rc = espeak_Cancel();
	/* flush the queue */
	empty_queue();
	pthread_mutex_unlock(&queue_guard_mutex);
	return;
} /* end tts_s */

void tts_q(char *speech)
{
	debug_log(logfd, "Called tts_q to queue: %s\n", speech);
	pthread_mutex_lock(&queue_guard_mutex);

	queue_speech(1, speech);
	pthread_mutex_unlock(&queue_guard_mutex);
	return;
} /* end tts_q */

void tts_c(char *code)
{
	debug_log(logfd, "Called tts_c: %s\n", code);
	pthread_mutex_lock(&queue_guard_mutex);
	queue_speech(2, code);
	pthread_mutex_unlock(&queue_guard_mutex);
	return;
} /* end tts_c */

void tts_a(const char *filename)
{
	/* not implemented yet */
	debug_log(logfd, "Called tts_a\n");
	return;
} /* end tts_a */

void tts_t(int pitch, int duration)
{
	/* not implemented yet */
	debug_log(logfd, "Called tts_t\n");
	return;
} /* end tts_t */

void tts_sh(int duration_milliseconds)
{
	/* not implemented yet */
	debug_log(logfd, "Called tts_sh\n");
	return;
} /* end tts_sh */

void tts_reset(void)
{
	/* not implemented yet */
	debug_log(logfd, "Called tts_reset\n");
	return;
} /* end tts_reset */

void tts_set_punctuations(int punct_level)
{
	/* not implemented yet */
	debug_log(logfd, "Called tts_set_punctuations\n");
	return;
} /* end tts_set_punctuations */

void tts_set_speech_rate(int speech_rate)
{
	espeak_ERROR erc;
	debug_log(logfd, "Called tts_set_speech_rate: %d\n", speech_rate);
	tts_state.speech_rate = speech_rate;
	erc = espeak_SetParameter(espeakRATE, speech_rate+100, 0);
	debug_log(logfd, "In tts_set_speech_rate espeak_SetParameter returned: %d\n", erc);
	return;
} /* end tts_set_speech_rate */

void tts_set_character_scale(double character_scale)
{
	/* not implemented yet */
	debug_log(logfd, "Called tts_character_scale\n");
	tts_state.character_scale = character_scale;
	return;
} /* end tts_set_character_scale */

void tts_split_caps(int split_caps)
{
	/* speak camel-case, IOW say 'capital' for every capital letter */
	/* still to improve paranoia checking */
	espeak_ERROR erc;
	debug_log(logfd, "Called tts_split_caps: %d\n", split_caps); 
	tts_state.split_caps = split_caps;
	erc = espeak_SetParameter(espeakCAPITALS, (split_caps ? 2 : 0), 0);
	debug_log(logfd, "In tts_split_caps espeak_SetParameter returned: %d\n", erc);
	return;
} /* end tts_split_caps */

void tts_capitalize(int capitalize)
{
	/* indicate capital by pitch */
	/* improve paranoia checking */
	espeak_ERROR erc;
	debug_log(logfd, "Called tts_capitalize: %d\n", capitalize);
	tts_state.capitalize = capitalize;
	erc = espeak_SetParameter(espeakCAPITALS, 3, 0);
	debug_log(logfd, "In tts_capitalize espeak_SetParameter returned: %d\n", erc);
	return;
} /* end tts_capitalize */

void tts_allcaps_beep(int allcaps_beep)
{
	/* high pitched beep for capital letter */
	/* still to improve paranoia checking */
	espeak_ERROR erc;
	tts_state.caps_beep = allcaps_beep;
	debug_log(logfd, "Called tts_allcaps_beep: %d\n", allcaps_beep);
	erc = espeak_SetParameter(espeakCAPITALS, allcaps_beep, 0);
	debug_log(logfd, "In tts_allcaps_beep espeak_SetParameter returned: %d\n", erc);
	return;
} /* end tts_allcaps_beep */


void tts_sync_state(
	int punct_level,
	int pitch_rise,
	int caps_beep,
	int split_caps,
	int speech_rate)
{
	/* not implemented yet */
	tts_state.punct_level = punct_level;
	tts_state.pitch_rise = pitch_rise;
	tts_state.caps_beep = caps_beep;
	tts_state.split_caps = split_caps;
	tts_state.speech_rate = speech_rate;

	debug_log(logfd, "Called tts_sync_state: %d %d %d %d %d\n", punct_level, pitch_rise, caps_beep, split_caps, speech_rate);
	return;
} /* end tts_sync_state */


int tts_initialize(void)
{
	/* still to improve paranoia checking */
	int rc;
	espeak_ERROR erc;
	pthread_t qthr;
	logfd = create_log_file("/tmp/emacsespeakx86-", CPF_CLOEXEC);
	debug_log(logfd, "Called tts_initialize\n");
	fclose(stderr);
	rc = sem_init(&dispatch_semaphore, 0, 0);
	if (rc < 0) {
		debug_log(logfd, "Failed to initialize dispatch_semaphore in tts_initialize\n");
		return 1;
	}

	rc = pthread_mutex_init(&queue_guard_mutex, NULL);
	if (rc < 0) {
		debug_log(logfd, "Failed to initialize queue_guard_mutex in tts_initialize\n");
		return 1;
	}

	queue_init(&tts_queue, free_queue_entry);

rc = pthread_create(&qthr, NULL, dispatch_thread, (void*)&tts_queue);

	erc = espeak_Initialize(AUDIO_OUTPUT_PLAYBACK, 50, NULL, 0);
	debug_log(logfd, "In tts_initialize espeak_Initialize returned: %d\n", erc);
	return erc;
} /* end tts_initialize */

int tts_terminate(void)
{
	/* still to improve paranoia checking */
	espeak_ERROR erc;
	erc = espeak_Terminate();
	return 0;
} /* end tts_terminate */



int main(int argc, char **argv)
{

	if(argc > 1 && !strcmp(argv[1], "-d"))
		yydebug = 1; argc--; argv++;

	int rc = tts_initialize();
	if (rc == -1) {
		debug_log(logfd,"Call to tts_initialize returned error code\n");
		return 1;
	}

	yyparse();

	return 0;

}




