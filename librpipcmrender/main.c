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


void print_state(AUDIO_COMPONENT_T *component) {
	char state_str[32];
	omx_state_string(component, state_str);
	debug_log(stdout, "MAIN: Component state: %s\n", state_str);
	return;
} // end print_state


int main() {
	OMX_ERRORTYPE omx_err;
	AUDIO_COMPONENT_T component;
	char error_str[64];

	bcm_host_init();

	omx_err = OMX_Init();
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout,"Failed OMX_Init\n");
		return 1;
	}

	omx_err = omx_init_pcm_render_component(&component, "OMX.broadcom.audio_render", 3, 2048);
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout,"Failed in omx_init_pcm_render_component\n");
		return omx_err;
	}

debug_log(stdout, "MAIN: After init audio component\n");

	print_state(&component);

	omx_err = omx_set_pcm_parameters(&component, 22050, 1, 16, "local");
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout,"MAIN: Failed to set pcm parameters\n");
		return 1;
	}

print_state(&component);

	omx_err = omx_alloc_buffers(&component);
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout,"MAIN: Failed to allocate buffers\n");
		return 1;
	}

print_state(&component);

	debug_log(stdout, "MAIN: Size of buffer list after allocation: %d\n", list_size(&component.buffer_list));
	debug_log(stdout, "MAIN: Size of free buffer queue after allocation: %d\n", queue_size(&component.free_buffer_queue));

	omx_err = omx_set_volume(&component, 100);
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout,"MAIN: Failed to set volume\n");
		return 1;
	}

	print_state(&component);

	omx_err = omx_set_state(&component, OMX_StateIdle, 3000);
	if (omx_err != OMX_ErrorNone) {
		omx_errortype_string(omx_err, error_str);
		debug_log(stdout, "MAIN: Failed in omx_set_state called to transition to idle in main. Error string: %s\n", error_str);
		return 1;
	}

	print_state(&component);

	omx_free_pcm_render_component(&component);

	debug_log(stdout, "MAIN: Size of buffer list: %d\n", list_size(&component.buffer_list));
	debug_log(stdout, "MAIN: Size of free buffer queue: %d\n", queue_size(&component.free_buffer_queue));
	debug_log(stdout, "MAIN: Size of comand complete event queue: %d\n", queue_size(&component.command_complete_event_queue));
	debug_log(stdout, "MAIN: Size of other event queue: %d\n", queue_size(&component.other_event_queue));
	return 0;
}

