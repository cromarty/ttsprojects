#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <math.h>

#include "bcm_host.h"
#include "ilclient.h"

#include "ilctts_lib.h"
#include "utils.h"

#define M 10
//#define N (st->buffer_size)
#define N (1<<M)

int32_t consume_file(TTSRENDER_STATE_T *st, const char *filename, int *chunks) {
	FILE *fp;
	uint8_t *buf = (uint8_t*)malloc(N);
	int bytesread, totalbytesread = 0;
	printf("Consuming file %s in chunks of %d bytes\n", filename, N);	
	fp = fopen(filename, "r");
	if (fp == NULL)
		return -1;

		bytesread = fread(buf, 1, N, fp);
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

		buf = ilctts_get_buffer(st);
		while(buf == NULL) {
				pthread_mutex_lock(&st->free_buffer_mutex);
				pthread_cond_wait(&st->free_buffer_cv, &st->free_buffer_mutex);
				buf = ilctts_get_buffer(st);
				pthread_mutex_unlock(&st->free_buffer_mutex);
						}// end while
		
ilctts_play_buffer(st, buf, bytesread);
		bytesread = fread(buf, 1, N, fp);

	}

	fclose(fp);
	printf("Read %d chunks of data, total of %d\n", *chunks, totalbytesread);
	return 0;
} // end consume_file



int main(int argc, char **argv) {
	OMX_ERRORTYPE omx_err;
	OMX_STATETYPE state;
	TTSRENDER_STATE_T *st;
	int32_t ret;
		char debug_str[128];
		int chunks = 0;
		
			if (argc != 2) {
					printf("Usage: testcore <raw-pcm-file>\n");
							return 1;
							}

	ret = ilctts_initialize();
		if (ret < 0) { 
	printf("Failed to initialise OMX\n");
		return 1;
		} else {
				printf("Initialised OMX ok\n");
				}
				

	omx_err = ilctts_create(&st, 22050, 1, 16, 5, 2048);
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

 ret = consume_file(st, argv[1], &chunks);
if (ret < 0)
printf("There was some kind of error in consume_file\n");
		
		
	omx_err = ilctts_delete(st);
	if (omx_err != OMX_ErrorNone) {
	printf("Failed to delete component\n");
		return 1;
		}
	ilctts_finalize();
	
	return 0;

} // end main


