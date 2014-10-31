#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <math.h>

#include "bcm_host.h"
#include "ilctts_lib.h"
#include "utils.h"

#define M 10

#define N (1<<M)
       

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
	printf("Size of ringbuffer: %d\n", st->ringbuffer->length);

	omx_err = ilctts_delete(st);
	if (omx_err != OMX_ErrorNone) {
		printf("Failed to delete component\n");
		return 1;
	}

	ilctts_finalize();

	return 0;

} // end main


