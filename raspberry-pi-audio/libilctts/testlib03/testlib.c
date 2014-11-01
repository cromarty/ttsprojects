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

int synth_callback(short *wav, int numsamples, espeak_EVENT *events) {
	TTSRENDER_STATE_T *st = (TTSRENDER_STATE_T*)events->user_data;
	int byteswritten;

	if (numsamples) {
		printf("Waiting for ringbuffer empty semaphore in espeak callback\n");
		sem_wait(&st->ringbuffer_empty_sema);
		printf("Trying to lock ringbuffer mutex in espeak callback\n");
		pthread_mutex_lock(&st->ringbuffer_mutex);
		printf("RB Free space before write: %d\n", ringbuffer_freespace(st->ringbuffer));
		printf("Bytes to write: %d\n", numsamples<<1);
		byteswritten = ringbuffer_write(st->ringbuffer, (void*)wav, numsamples<<1);
		printf("RB Bytes written: %d\n", byteswritten);
		printf("Unlocking ring buffer mutex in espeak callback\n");
		pthread_mutex_unlock(&st->ringbuffer_mutex);
		printf("Post ringbuffer data semaphore\n");
		sem_post(&st->ringbuffer_data_sema);
	}
	return 0;
} // end Synth_callback


// the real producer is the synth callback above.
int producer(TTSRENDER_STATE_T *st) {
	int sample_rate;
	int flags = espeakSSML | espeakCHARS_UTF8;
	char text[] = "Now is the time for every good man to come to the aid of the party";
	int bytes = strlen(text)+1;
	int res;
	sample_rate = espeak_Initialize(AUDIO_OUTPUT_RETRIEVAL, 200, NULL, 0);
	printf("About to set the synth callback\n");
	espeak_SetSynthCallback(synth_callback);
	printf("About to call espeak_Synth\n");
	sem_post(&st->ringbuffer_empty_sema);
	res = espeak_Synth(text, bytes, 0, POS_CHARACTER, 0, flags, NULL, st);
	printf("After call to espeak_Synth\n");
	sleep(10);

	return 0;
} // end producer


int main(int argc, char **argv) {
	OMX_ERRORTYPE omx_err;
	OMX_STATETYPE state;
	TTSRENDER_STATE_T *st;
	int32_t ret;
	char debug_str[128];
	int chunks = 0;


	ret = ilctts_initialize();
	if (ret < 0) { 
		printf("Failed to initialise OMX\n");
		return 1;
	} else {
		printf("Initialised OMX ok\n");
	}

	omx_err = ilctts_create(&st, 22050, 1, 16, 5, N, 1024*16);
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
		printf("Got state: %s\n", debug_str);
	}

	// processing code in here
ret = ilctts_start_ringbuffer_consumer_thread(st);
if (ret != 0)
		printf("Some kind of failure creating thread\n");

ret = producer(st);


	omx_err = ilctts_delete(st);
	if (omx_err != OMX_ErrorNone) {
		printf("Failed to delete component\n");
		return 1;
	}

	ilctts_finalize();

	return 0;

} // end main


