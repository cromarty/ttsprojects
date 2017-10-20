#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <math.h>
#include <pipcmrender/pipcmrender_lib.h>
#include <pipcmrender/utils.h>

#include "bcm_host.h"

#define M 6

#define N (1<<M)
       

int32_t consume_file(PCMRENDER_STATE_T *st, const char *filename, int *chunks) {
	FILE *fp;
	short fbuf[N>>1];

uint8_t *buf;
	int bytesread, totalbytesread = 0;
	memset(fbuf, 0, N);

	printf("Consuming file %s in chunks of %d bytes\n", filename, N);	
	fp = fopen(filename, "r");
	if (fp == NULL)
		return -1;

	bytesread = fread(fbuf, 2, N>>1, fp);
if ( ! bytesread) {
		printf("Failed to read the first chunk\n");
		fclose(fp);
		return -1;
	}

	while( ! feof(fp) ) {
		if (bytesread) {
			*chunks += 1;
			totalbytesread += bytesread;
		} else {
			break;
		}
        
		buf = pipcmrender_get_buffer(st);
		while(buf == NULL) {
			pthread_mutex_lock(&st->free_buffer_mutex);
			pthread_cond_wait(&st->free_buffer_cv, &st->free_buffer_mutex);
			buf = pipcmrender_get_buffer(st);
			pthread_mutex_unlock(&st->free_buffer_mutex);
		}// end while

		memcpy(buf, fbuf, bytesread<<1);		
		pipcmrender_send_audio(st, buf, bytesread<<1);
		bytesread = fread(fbuf, 2, N>>1, fp);

	}

	fclose(fp);
	printf("Read %d chunks of data, total of %d\n", *chunks, totalbytesread);
	return 0;
} // end consume_file



int main(int argc, char **argv) {
	OMX_ERRORTYPE omx_err;
	OMX_STATETYPE state;
	PCMRENDER_STATE_T *st;
	int32_t ret;
	char debug_str[128];
	int chunks = 0;

	if (argc != 2) {
		printf("Usage: testcore <raw-pcm-file>\n");
		return 1;
	}

	ret = pipcmrender_initialize();
	if (ret < 0) { 
		printf("Failed to initialise OMX\n");
		return 1;
	} else {
		printf("Initialised OMX ok\n");
	}

	omx_err = pipcmrender_create(&st, 22050, 1, 16, 2, 50, 0);
	if (omx_err != OMX_ErrorNone) {
		printf("Failed to create component\n");
		return 1;
	}

	ret = pipcmrender_set_dest(st, "local");
	if (ret < 0) {
		printf("Failed to set audio destination\n");
		return 1;
	}

	ret = pipcmrender_get_state(st, &state);
	if (ret < 0) {
		printf("Failed to get state\n");
		printf("Got state: %s\n", debug_str);
	}

	ret = consume_file(st, argv[1], &chunks);
	if (ret < 0)
		printf("There was some kind of error in consume_file\n");

	omx_err = pipcmrender_delete(st);
	if (omx_err != OMX_ErrorNone) {
		printf("Failed to delete component\n");
		return 1;
	}
	pipcmrender_finalize();

	return 0;

} // end main


