#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <math.h>

#include "bcm_host.h"
#include "ilctts_lib.h"
#include "utils.h"


//#include <espeak/speak_lib.h>

#define M 10
#define N (1<<M)


int producer(TTSRENDER_STATE_T *st) {
	int sample_rate;
	int bytesread, byteswritten;
	uint8_t *buf = malloc(N);

	FILE *fp;

	//sample_rate = espeak_Initialize(AUDIO_OUTPUT_RETRIEVAL, 200, NULL, 0);
	fp = fopen("softrains.raw", "r");
	if (fp == NULL)
		return -1;

	bytesread = fread(buf, 2, N>>1, fp);
	sem_post(&st->ringbuffer_empty_sema);
	while(!feof(fp)) {
		//printf("Read %d bytes from file\n", bytesread);
		//printf("Waiting for empty semaphore\n");
		sem_wait(&st->ringbuffer_empty_sema);
		//printf("Empty semaphore signalled\n");
		pthread_mutex_lock(&st->ringbuffer_mutex);
		//printf("ringbuffer_mutex locked\n");
		byteswritten = ringbuffer_write(st->ringbuffer, buf, bytesread<<1);
		//printf("%d bytes written to ring buffer\n", byteswritten);
		pthread_mutex_unlock(&st->ringbuffer_mutex);
		//printf("ringbuffer_mutex unlocked\n");
		sem_post(&st->ringbuffer_data_sema);
		bytesread = fread(buf, 2, N>>1, fp);
	} // end while(!feof(fp))
	fclose(fp);

	return 0;
} // end producer

       

int main(int argc, char **argv) {
	OMX_ERRORTYPE omx_err;
	OMX_STATETYPE state;
	TTSRENDER_STATE_T *st;
	int32_t ret;
	char debug_str[128];
	int chunks = 0;
/*
	if (argc != 2) {
		printf("Usage: testcore <raw-pcm-file>\n");
		return 1;
	}
*/

	ret = ilctts_initialize();
	if (ret < 0) { 
		printf("Failed to initialise OMX\n");
		return 1;
	} else {
		printf("Initialised OMX ok\n");
	}

	omx_err = ilctts_create(&st, 22050, 1, 16, 2, 50, 0, 1024*16);
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


