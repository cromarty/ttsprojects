#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>

//#include <espeak/speak_lib.h>

#include "server.h"
#include "espeak.h"

#include "parser.h"

TTS_STATE_T tts_state;
Queue tts_queue;

/* mutex protecting the queue */
pthread_mutex_t queue_guard_mutex;

/* semaphore signalled when the dispatch function is received from emacspeak */
sem_t dispatch_semaphore;

void tts_version(void)
{
	printf("Called tts_version\n");
	return;
} /* end tts_version */

void tts_say(char *text)
{
	int res;
	pthread_mutex_lock(&queue_guard_mutex);
	res = espeak_Cancel();
	res = empty_queue(&tts_queue);
	res = espeak_Synth(text, strlen(text)+1, 0, POS_CHARACTER, 0, espeakPHONEMES, NULL, NULL);
	pthread_mutex_unlock(&queue_guard_mutex);
	return;
} /* end tts_say */

void tts_l(const char ch)
{
	printf("Called tts_l: %d\n", ch);
	return;
} /* end tts_l */

void tts_d(void)
{
	printf("Called tts_d function\n");
	sem_post(&dispatch_semaphore);
	return;
} /* end tts_d */

void tts_pause(void)
{
	printf("Called tts_pause\n");
	return;
} /* end tts_pause */

void tts_resume(void)
{
	printf("Called tts_resume\n");
	return;
} /* end tts_resume */

void tts_s(void)
{
	int res;
	pthread_mutex_lock(&queue_guard_mutex);
	res = espeak_Cancel();
	empty_queue(&tts_queue);
	pthread_mutex_unlock(&queue_guard_mutex);
	return;
} /* end tts_s */

void tts_q(char *speech)
{
	pthread_mutex_lock(&queue_guard_mutex);
	queue_speech(&tts_queue, 1, speech);
	pthread_mutex_unlock(&queue_guard_mutex);
	free(speech);
	return;
} /* end tts_q */

void tts_c(const char *code)
{
	pthread_mutex_lock(&queue_guard_mutex);
	queue_speech(&tts_queue, 2, code);
	pthread_mutex_unlock(&queue_guard_mutex);
	return;
} /* end tts_c */

void tts_a(const char *filename)
{
	printf("Called tts_a: %s\n", filename);
	return;
} /* end tts_a */

void tts_t(int pitch, int duration)
{
	printf("Called tts_t function: %d %d\n", pitch, duration);
	return;
} /* end tts_t */

void tts_sh(int duration_milliseconds)
{
	printf("Called tts_sh: %d\n", duration_milliseconds);
	return;
} /* end tts_sh */

void tts_reset(void)
{
	printf("Called tts_reset\n");
	return;
} /* end tts_reset */

void tts_set_punctuations(int punct_level)
{
	printf("Called set punct level: %d\n", punct_level);
	return;
} /* end tts_set_punctuations */

void tts_set_speech_rate(int speech_rate)
{
	tts_state.speech_rate = speech_rate;
	printf("Called tts_set_speech_rate: %d\n", speech_rate);
	return;
} /* end tts_set_speech_rate */

void tts_set_character_scale(double character_scale)
{
	tts_state.character_scale = character_scale;
	printf("Called tts_set_character_scale: %f\n", character_scale);
	return;
} /* end tts_set_character_scale */

void tts_split_caps(int split_caps)
{
	tts_state.split_caps = split_caps;
	printf("Called tts_split_caps: %d\n", split_caps);
	return;
} /* end tts_split_caps */

void tts_capitalize(int capitalize)
{
	tts_state.capitalize = capitalize;
	printf("Called tts_capitalize: %d\n", capitalize);
	return;
} /* end tts_capitalize */

void tts_allcaps_beep(int allcaps_beep)
{
	tts_state.caps_beep = allcaps_beep;
	printf("Called tts_allcaps_beep: %d\n", allcaps_beep);
	return;
} /* end tts_allcaps_beep */



void tts_sync_state(
	int punct_level,
	int pitch_rise,
	int caps_beep,
	int split_caps,
	int speech_rate)
{
	tts_state.punct_level = punct_level;
	tts_state.pitch_rise = pitch_rise;
	tts_state.caps_beep = caps_beep;
	tts_state.split_caps = split_caps;
	tts_state.speech_rate = speech_rate;

	printf("Called tts_sync_state: %d %d %d %d %d\n", punct_level, pitch_rise, caps_beep, split_caps, speech_rate);

	return;
} /* end tts_sync_state */


int tts_initialize(void)
{
	int result;
	pthread_t qthr;

	result = sem_init(&dispatch_semaphore, 0, 0);
	if (result < 0) {
		return 1;
	}
	result = pthread_mutex_init(&queue_guard_mutex, NULL);
	if (result < 0) {
		return 1;
	}

	queue_init(&tts_queue, free_queue_entry);

result = pthread_create(&qthr, NULL, dispatch_thread, (void*)&tts_queue);


	return espeak_Initialize(AUDIO_OUTPUT_PLAYBACK, 50, NULL, 0);

} /* end tts_initialize */

int tts_terminate(void)
{
	espeak_Terminate();
	return 0;
} /* end tts_terminate */

