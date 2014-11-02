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
	int written;

	if (numsamples) {
		sem_wait(&st->ringbuffer_empty_sema);
		pthread_mutex_lock(&st->ringbuffer_mutex);
printf("CB> numsamples: %d, to write: %d, free space: %d, head: %d, tail %d\n",
numsamples,
numsamples<<1,
ringbuffer_freespace(st->ringbuffer),
st->ringbuffer->head,
st->ringbuffer->tail);

		written = ringbuffer_write(st->ringbuffer, (void*)wav, numsamples<<1);
printf("CB> Wrote %d, used space: %d, free space: %d, head: %d, tail: %d\n", 
written,
ringbuffer_used_space(st->ringbuffer),
ringbuffer_freespace(st->ringbuffer),
st->ringbuffer->head,
st->ringbuffer->tail
);

		pthread_mutex_unlock(&st->ringbuffer_mutex);
		sem_post(&st->ringbuffer_data_sema);
	}
	return 0;
} // end Synth_callback


// the real producer is the synth callback above.
int producer(TTSRENDER_STATE_T *st) {
	int sample_rate;
	int flags = espeakSSML | espeakCHARS_UTF8;
	char buf[BUF_LEN];
int bytesread;
	int res;
	sample_rate = espeak_Initialize(AUDIO_OUTPUT_RETRIEVAL, 200, NULL, 0);

	espeak_SetSynthCallback(synth_callback);

	sem_post(&st->ringbuffer_empty_sema);
while( ! feof(stdin)) {
	bytesread = fread(buf, 1, BUF_LEN, stdin);
	res = espeak_Synth(buf, bytesread, 0, POS_CHARACTER, 0, flags, NULL, st);
}

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


