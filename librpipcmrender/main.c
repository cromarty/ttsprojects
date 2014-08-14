#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <malloc.h>
#include <time.h>
#include <bcm_host.h>
#include <interface/vcos/vcos_semaphore.h>
#include <interface/vmcs_host/vchost.h>
#include <IL/OMX_Component.h>
#include <IL/OMX_Audio.h>
#include <IL/OMX_Broadcom.h>
#include <pthread.h>

#include "rpipcmrender.h"
#include "debug.h"


int main() {
	OMX_ERRORTYPE omx_err;
	OMX_COMPONENT_T component;
	bcm_host_init();

	omx_err = OMX_Init();
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout,"Failed OMX_Init\n");
		return omx_err;
	}

	omx_err = omx_init_audio_render_component(&component, "OMX.broadcom.audio_render");
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout,"Failed in omx_init_audio_render_component\n");
		return omx_err;
	}
debug_log(stdout, "After init audio component\n");

	omx_err = omx_set_pcm_parameters(&component, 22050, 1, 16, "local");
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout,"Failed to set pcm parameters\n");
		return omx_err;
	}

	omx_err = omx_alloc_buffers(&component);
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout,"Failed to allocate buffers\n");
		return omx_err;
	}

	omx_err = omx_set_volume(&component, 100);
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout,"Failed to set volume\n");
		return omx_err;
	}
	//omx_free_buffers(&component, 100);

	return 0;
}

