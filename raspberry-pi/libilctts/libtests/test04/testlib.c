#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <math.h>
#include <espeak/speak_lib.h>

#include "bcm_host.h"
#include "ilctts_lib.h"
#include "utils.h"

#define M 10
#define N (1<<M)
#define BUF_LEN 100

sem_t sema;

int synth_callback(short *wav, int numsamples, espeak_EVENT *events) {
	TTSRENDER_STATE_T *st = (TTSRENDER_STATE_T*)events->user_data;
	int written;

	if (numsamples) {
		sem_wait(&st->ringbuffer_empty_sema);

		written = ringbuffer_write(st->ringbuffer, (void*)wav, numsamples<<1);

		pthread_mutex_unlock(&st->ringbuffer_mutex);
		sem_post(&st->ringbuffer_data_sema);
	}

	while(events->type != espeakEVENT_LIST_TERMINATED) {
		if (events->type == espeakEVENT_MSG_TERMINATED)
			sem_post(&sema);

		events++;
	}


	return 0;
} // end Synth_callback


// the real producer is the synth callback above.
int producer(TTSRENDER_STATE_T *st, int wpm) {
	int sample_rate;
	int flags = espeakSSML | espeakCHARS_UTF8;
	//char *buf = malloc(BUF_LEN); 
char buf[BUF_LEN];
int bytesread;
	int res;

	sem_init(&sema, 0, 1);

	sample_rate = espeak_Initialize(AUDIO_OUTPUT_RETRIEVAL, 200, NULL, 0);

	espeak_SetSynthCallback(synth_callback);
espeak_SetParameter(espeakRATE, wpm, 0);
	sem_post(&st->ringbuffer_empty_sema);

	while ( fgets (buf, BUF_LEN, stdin) != NULL) {
		res = espeak_Synth(buf, strlen(buf)+1, 0, POS_CHARACTER, 0, flags, NULL, st);
		sem_wait(&sema);
	}
sem_wait(&sema);
	sem_destroy(&sema);
	return 0;
} // end producer


int main(int argc, char **argv) {
	OMX_ERRORTYPE omx_err;
	OMX_STATETYPE state;
	TTSRENDER_STATE_T *st;
	int32_t ret;
	char debug_str[128];
	int chunks = 0;
int wpm;

	if (argc != 2) {
		printf("Usage: testlib <wpm>\n");
		return 1;
}
wpm = atoi(argv[1]);
	ret = ilctts_initialize();
	if (ret < 0) { 
		printf("Failed to initialise OMX\n");
		return 1;
	}

	omx_err = ilctts_create(
		&st,			// the tts state object
		22050,			// sampling rate
		1,			// number of channels
		16,			// bit depth
		5,			// number of IL client buffers
	N,				// size of each IL client buffer
		1024*16			// size of ring buffer
	);
	if (omx_err != OMX_ErrorNone) {
		printf("Failed to create component\n");
		return 1;
	}

	ret = ilctts_set_dest(st, "local");
	if (ret < 0) {
		printf("Failed to set audio destination\n");
		return 1;
	}

	ret = ilctts_get_state(st, &state);
	if (ret < 0) {
		printf("Failed to get state\n");
	}

ret = ilctts_start_ringbuffer_consumer_thread(st);
if (ret != 0) {
		printf("Some kind of failure creating thread\n");
		return 1;
	}

ret = producer(st, wpm);

	omx_err = ilctts_delete(st);
	if (omx_err != OMX_ErrorNone) {
		printf("Failed to delete component\n");
		return 1;
	}

	ilctts_finalize();

	return 0;

} // end main


