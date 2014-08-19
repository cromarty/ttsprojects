#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>

#include "bcm_host.h"
#include "ilclient.h"

#include "ilctts_lib.h"



int main() {
	OMX_ERRORTYPE omx_err;
	OMX_STATETYPE state;
	TTSRENDER_STATE_T *st;
	int32_t ret;

	bcm_host_init();

	omx_err = OMX_Init();
	if (omx_err != OMX_ErrorNone) {
	printf("Failed to initialise OMX\n");
		return 1;
	}

	omx_err = ilctts_create(&st, 22050, 1, 16, 5, 2048);
	if (omx_err != OMX_ErrorNone) {
		printf("Failed to create component\n");
		return 1;
	} else {
		printf("Component created successfully\n");
	}

	ret = ilctts_set_dest(st, "local");
	if (ret < 0) {
		printf("Failed to set audio destination\n");
		return 1;
	} else {
		printf("set the audio destination ok\n");
	}

	ret = ilctts_get_state(st, &state);
	if (ret < 0) {
		printf("Bugger\n");
		return 1;
	} else {
		printf("Got the state: %d\n", state);
		switch(state) {
			case OMX_StateLoaded:
				printf("OMX_Loaded\n");
				break;
			case OMX_StateIdle:
				printf("OMX_StateIdle\n");
				break;
			case OMX_StateExecuting:
				printf("OMX_StateExecuting\n");
				break;
			default:
				printf("Dont't know the state\n");
	}

	ret = ilctts_set_volume(st, 100);
	if (ret < 0)
		printf("Failed to set volume\n");
	else
		printf("SUccessfully set volume\n");

	omx_err = ilctts_delete(st);
	if (omx_err != OMX_ErrorNone) {
		printf("Failed to delete component\n");
		return 1;
	}

	return 0;

} // end main


