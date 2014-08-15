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
#include "list.h"
#include "queue.h"
#include "debug.h"

#define OMX_INIT_STRUCTURE(a) \
	memset(&(a), 0, sizeof(a)); \
	(a).nSize = sizeof(a); \
	(a).nVersion.s.nVersionMajor = OMX_VERSION_MAJOR; \
	(a).nVersion.s.nVersionMinor = OMX_VERSION_MINOR; \
	(a).nVersion.s.nRevision = OMX_VERSION_REVISION; \
	(a).nVersion.s.nStep = OMX_VERSION_STEP

#define QUEUE_OTHER_EVENTS 0


static int max(int val1, int val2) {
	return (val1 > val2 ? val1 : val2);
} // end max

static int min(int val1, int val2) {
	return ( val1 < val2 ? val1 : val2 );
} // end min 


static char *error_type_string(OMX_ERRORTYPE omx_err) {
	char *error_string = malloc(64);
	switch(omx_err) {
		case OMX_ErrorNone:
			sprintf(error_string, "%s", "OMX_ErrorNone");
			break;
		case OMX_ErrorInsufficientResources:
			sprintf(error_string, "%s", "OMX_ErrorInsufficientResources");
			break;
		case OMX_ErrorUndefined:
			sprintf(error_string, "%s", "OMX_ErrorUndefined");
			break;
		case OMX_ErrorInvalidComponentName:
			sprintf(error_string, "%s", "OMX_ErrorInvalidComponentName");
			break;
		case OMX_ErrorComponentNotFound:
			sprintf(error_string, "%s", "OMX_ErrorComponentNotFound");
			break;
		case OMX_ErrorInvalidComponent:
			sprintf(error_string, "%s", "OMX_ErrorInvalidComponent");
			break;
		case OMX_ErrorBadParameter:
			sprintf(error_string, "%s", "OMX_ErrorBadParameter");
			break;
		case OMX_ErrorNotImplemented:
			sprintf(error_string, "%s", "OMX_ErrorNotImplemented");
			break;
		case OMX_ErrorUnderflow:
			sprintf(error_string, "%s", "OMX_ErrorUnderflow");
			break;
		case OMX_ErrorOverflow:
			sprintf(error_string, "%s", "OMX_ErrorOverflow");
			break;
		case OMX_ErrorHardware:
			sprintf(error_string, "%s", "OMX_ErrorHardware");
			break;
		case OMX_ErrorInvalidState:
			sprintf(error_string, "%s", "OMX_ErrorInvalidState");
			break;
		case OMX_ErrorStreamCorrupt:
			sprintf(error_string, "%s", "OMX_ErrorStreamCorrupt");
			break;
		case OMX_ErrorPortsNotCompatible:
			sprintf(error_string, "%s", "OMX_ErrorPortsNotCompatible");
			break;
		case OMX_ErrorResourcesLost:
			sprintf(error_string, "%s", "OMX_ErrorResourcesLost");
			break;
		case OMX_ErrorVersionMismatch:
			sprintf(error_string, "%s", "OMX_ErrorVersionMismatch");
			break;
		case OMX_ErrorNotReady:
			sprintf(error_string, "%s", "OMX_ErrorNotReady");
			break;
		case OMX_ErrorTimeout:
			sprintf(error_string, "%s", "OMX_ErrorTimeout");
			break;
		case OMX_ErrorSameState:
			sprintf(error_string, "%s", "OMX_ErrorSameState");
			break;
		case OMX_ErrorResourcesPreempted:
			sprintf(error_string, "%s", "OMX_ErrorResourcesPreempted");
			break;
		case OMX_ErrorPortUnresponsiveDuringDeallocation:
			sprintf(error_string, "%s", "OMX_ErrorPortUnresponsiveDuringDeallocation");
			break;
		case OMX_ErrorPortUnresponsiveDuringStop:
			sprintf(error_string, "%s", "OMX_ErrorPortUnresponsiveDuringStop");
			break;
		case OMX_ErrorIncorrectStateTransition:
			sprintf(error_string, "%s", "OMX_ErrorIncorrectStateTransition");
			break;
		case OMX_ErrorIncorrectStateOperation:
			sprintf(error_string, "%s", "OMX_ErrorIncorrectStateOperation");
			break;
		case OMX_ErrorUnsupportedSetting:
			sprintf(error_string, "%s", "OMX_ErrorUnsupportedSetting");
			break;
		case OMX_ErrorUnsupportedIndex:
			sprintf(error_string, "%s", "OMX_ErrorUnsupportedIndex");
			break;
		case OMX_ErrorBadPortIndex:
			sprintf(error_string, "%s", "OMX_ErrorBadPortIndex");
			break;
		case OMX_ErrorPortUnpopulated:
			sprintf(error_string, "%s", "OMX_ErrorPortUnpopulated");
			break;
		case OMX_ErrorComponentSuspended:
			sprintf(error_string, "%s", "OMX_ErrorComponentSuspended");
			break;
		case OMX_ErrorDynamicResourcesUnavailable:
			sprintf(error_string, "%s", "OMX_ErrorDynamicResourcesUnavailable");
			break;
		case OMX_ErrorMbErrorsInFrame:
			sprintf(error_string, "%s", "OMX_ErrorMbErrorsInFrame");
			break;
		case OMX_ErrorFormatNotDetected:
			sprintf(error_string, "%s", "OMX_ErrorFormatNotDetected");
			break;
		case OMX_ErrorContentPipeOpenFailed:
			sprintf(error_string, "%s", "OMX_ErrorContentPipeOpenFailed");
			break;
		case OMX_ErrorContentPipeCreationFailed:
			sprintf(error_string, "%s", "OMX_ErrorContentPipeCreationFailed");
			break;
		case OMX_ErrorSeperateTablesUsed:
			sprintf(error_string, "%s", "OMX_ErrorSeperateTablesUsed");
			break;
		case OMX_ErrorTunnelingUnsupported:
			sprintf(error_string, "%s", "OMX_ErrorTunnelingUnsupported");
			break;
		case OMX_ErrorKhronosExtensions:
			sprintf(error_string, "%s", "OMX_ErrorKhronosExtensions");
			break;
		case OMX_ErrorVendorStartUnused:
			sprintf(error_string, "%s", "OMX_ErrorVendorStartUnused");
			break;
		case OMX_ErrorDiskFull:
			sprintf(error_string, "%s", "OMX_ErrorDiskFull");
			break;
		case OMX_ErrorMaxFileSize:
			sprintf(error_string, "%s", "OMX_ErrorMaxFileSize");
			break;
		case OMX_ErrorDrmUnauthorised:
			sprintf(error_string, "%s", "OMX_ErrorDrmUnauthorised");
			break;
		case OMX_ErrorDrmExpired:
			sprintf(error_string, "%s", "OMX_ErrorDrmExpired");
			break;
		case OMX_ErrorDrmGeneral:
			sprintf(error_string, "%s", "OMX_ErrorDrmGeneral");
			break;
		case OMX_ErrorMax:
			sprintf(error_string, "%s", "OMX_ErrorMax");
			break;
		default:
			sprintf(error_string, "%s", "Other");
	}
	return error_string;
} // end error_type_string

static void release_buffer_list_entry(void *data) {
	AUDIO_COMPONENT_T *component = (AUDIO_COMPONENT_T*)((OMX_BUFFERHEADERTYPE*)data)->pAppPrivate;
	OMX_BUFFERHEADERTYPE *buf = (OMX_BUFFERHEADERTYPE*)data;
	debug_log(stdout, "Freeing a buffer\n");
	OMX_FreeBuffer(component->handle, component->port, buf);
		return;
} // end release_buffer_list_entry

static void release_event_queue_entry(void *data) {
	return;
} // end release_event_queue_entry

static void release_free_buffer_queue_entry(void *data) {
	return;
} // end release_free_buffer_queue_entry


static uint64_t time_now_microseconds() {
	struct timespec now;
	if (clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &now) == -1)
		return 0;

	return (now.tv_sec * 1000000) + (now.tv_nsec / 1000);
} // end time_now_microseconds



static int get_event(AUDIO_COMPONENT_T *component, struct OMX_EVENT_T *event_, QUEUE_T *event_queue) {
	debug_log(stdout, "In get_event\n");

	pthread_mutex_lock(&component->event_queue_mutex);

	if (queue_is_empty(event_queue)) {
		debug_log(stdout, "Queue is empty at entry to get_event\n");
		pthread_mutex_unlock(&component->event_queue_mutex);
		event_ = NULL;
		return -1;
	}

	debug_log(stdout, "About to dequeue event\n");
	queue_dequeue(event_queue, (void*)event_ );
	debug_log(stdout, "After dequeue event\n");

	if (queue_is_empty(event_queue)) {
		pthread_mutex_unlock(&component->event_queue_mutex);
		return 0;
	}

	pthread_mutex_unlock(&component->event_queue_mutex);
	debug_log(stdout, "About to exit get_event\n");
	return 1; // there are more events in the queue

} // end get_event



static OMX_ERRORTYPE wait_for_command_complete(AUDIO_COMPONENT_T*component, OMX_U32 command, OMX_U32 nData2, uint64_t timeout) {
	int queue_state;
	if (component == NULL)
		return OMX_EventError;

	debug_log(stdout, "In wait_for_command_complete\n");

	uint64_t start_time = time_now_microseconds();

	struct OMX_EVENT_T *event = malloc(sizeof(struct OMX_EVENT_T));
	if (event == NULL)
		return OMX_EventError;

	debug_log(stdout, "Before do loop\n");

	// We can't just exit if the event queue is empty until the timeout is exceeded.
	// This is because the event might arrive in the queue while we're in this loop
	do {
		queue_state = get_event(component, event, &component->command_complete_event_queue);
		if (queue_state > -1) {
			if (event) {
debug_log(stdout, "We have an event in the do loop\n");
return OMX_ErrorNone;
			} // if event
		} // end if get_event
	} while (((time_now_microseconds() - start_time) < timeout) || (event != NULL));

	debug_log(stdout, "After do loop in get_event\n");

	return OMX_ErrorTimeout;
} // end wait_for_command_complete


OMX_ERRORTYPE omx_event_callback(
	OMX_HANDLETYPE hcomponent,
	OMX_PTR app_data,
	OMX_EVENTTYPE event_,
	OMX_U32 data1,
	OMX_U32 data2,
	OMX_PTR event_data)
{

	if (app_data == NULL)
		return OMX_ErrorNone;

	AUDIO_COMPONENT_T *component = (AUDIO_COMPONENT_T *)app_data;
	//const char *event_str;

	struct OMX_EVENT_T *event = malloc(sizeof(struct OMX_EVENT_T));
	if (event == NULL)
		return OMX_ErrorNone;

	event->event = event_;
	event->data1 = data1;
	event->data2 = data2;
	event->event_data = event_data;

	switch (event_) {
		case OMX_EventCmdComplete: 
			queue_enqueue(&component->command_complete_event_queue, (void*)event);
			break;
		default:
			if (QUEUE_OTHER_EVENTS)
				queue_enqueue(&component->other_event_queue, (void*)event);
	}

	return OMX_ErrorNone;
} // end omx_event_callback

OMX_ERRORTYPE omx_empty_buffer_done_callback(
	OMX_HANDLETYPE hcomponent,
	OMX_PTR app_data,
	OMX_BUFFERHEADERTYPE *buffer)
{
	AUDIO_COMPONENT_T *component = (AUDIO_COMPONENT_T *)app_data;
	debug_log(stdout, "Empty buffer done callback\n");
	if (component) {
		//pthread_mutex_lock(&component->inputMutex);

		buffer->nFilledLen = 0;
		buffer->nOffset = 0;

		//pthread_cond_broadcast(&component->inputBufferCond);
		//pthread_mutex_unlock(&component->inputMutex);
	}

	return OMX_ErrorNone;

} // end omx_empty_buffer_done_callback

/*
OMX_ERRORTYPE omx_fill_buffer_done_callback(OMX_HANDLETYPE hcomponent, OMX_PTR app_data, OMX_BUFFERHEADERTYPE* buffer) {
	AUDIO_COMPONENT_T *component = (AUDIO_COMPONENT_T *)app_data;

	if (component) {
		pthread_mutex_lock(&component->inputMutex);
		buffer->nFilledLen      = 0;
		buffer->nOffset         = 0;

		if (component->inputBufferHdr == NULL) {
			component->inputBufferHdr = createSimpleListItem(pBuffer);
			component->inputBufferHdrEnd = component->inputBufferHdr;
		} else {
			addObjectToSimpleList(component->inputBufferHdrEnd, pBuffer);
			component->inputBufferHdrEnd = component->inputBufferHdrEnd->next;
		}

		pthread_cond_broadcast(&component->inputBufferCond);

		pthread_mutex_unlock(&component->inputMutex);
	}

	return OMX_ErrorNone;

} // end omx_fill_buffer_done_callback
*/


OMX_ERRORTYPE omx_enable_port(AUDIO_COMPONENT_T *component, uint64_t wait) {
	OMX_ERRORTYPE omx_err = OMX_ErrorNone;

	OMX_PARAM_PORTDEFINITIONTYPE portdef;
	OMX_INIT_STRUCTURE(portdef);
	portdef.nPortIndex = component->port;

	omx_err = OMX_GetParameter(component->handle, OMX_IndexParamPortDefinition, &portdef);

	if(portdef.bEnabled == OMX_FALSE) {
		omx_err = OMX_SendCommand(component->handle, OMX_CommandPortEnable, component->port, NULL);
		if(omx_err != OMX_ErrorNone)
			return omx_err;

		if(wait) {
			omx_err = wait_for_command_complete(component, OMX_CommandPortEnable, component->port, 1000);
		}
	}

	return omx_err;
} // end omx_enable_port



OMX_ERRORTYPE omx_disable_port(AUDIO_COMPONENT_T *component, uint64_t wait) {
	OMX_ERRORTYPE omx_err = OMX_ErrorNone;
debug_log(stdout, "In omx_disable_port\n");
	OMX_PARAM_PORTDEFINITIONTYPE portdef;
	OMX_INIT_STRUCTURE(portdef);
	portdef.nPortIndex = component->port;
debug_log(stdout, "About to get port definition\n");
	omx_err = OMX_GetParameter(component->handle, OMX_IndexParamPortDefinition, &portdef);
	if (omx_err != OMX_ErrorNone)
		return omx_err;
debug_log(stdout, "After getting port definition\n");
	if(portdef.bEnabled == OMX_TRUE) {
		omx_err = OMX_SendCommand(component->handle, OMX_CommandPortDisable, component->port, NULL);
		if(omx_err != OMX_ErrorNone)
			return omx_err;
debug_log(stdout, "Before wait\n");
		if(wait)
			omx_err = wait_for_command_complete(component, OMX_CommandPortDisable, component->port, 1000);

	}

	return omx_err;
} // end omx_disable_port



OMX_STATETYPE omx_get_state(AUDIO_COMPONENT_T *component) {
	pthread_mutex_lock(&component->comp_mutex);

	OMX_STATETYPE state;

	if(component->handle) {
		OMX_GetState(component->handle, &state);
		pthread_mutex_unlock(&component->comp_mutex);
		return state;
	}

	pthread_mutex_unlock(&component->comp_mutex);

	return (OMX_STATETYPE)0;
} // end omx_get_state




OMX_ERRORTYPE omx_set_state(AUDIO_COMPONENT_T *component, OMX_STATETYPE state, uint64_t timeout) {
	OMX_ERRORTYPE omx_err = OMX_ErrorNone;
	OMX_STATETYPE state_actual = OMX_StateMax;

	if (!component)
		return OMX_ErrorNone;

	if( ! component->handle)
		return OMX_ErrorUndefined;

	state_actual = omx_get_state(component);
	if(state == state_actual)
		return OMX_ErrorNone;

	omx_err = OMX_SendCommand(component->handle, OMX_CommandStateSet, state, NULL);
	if (omx_err != OMX_ErrorNone) {
		if(omx_err == OMX_ErrorSameState) {
			omx_err = OMX_ErrorNone;
		}
		if (timeout) {
			omx_err = wait_for_command_complete(component, OMX_CommandStateSet, state, timeout);
		}
	}

	return omx_err;
} // end omx_set_state


OMX_ERRORTYPE omx_alloc_buffers(AUDIO_COMPONENT_T *component) {
	OMX_ERRORTYPE omx_err = OMX_ErrorNone;
	OMX_PARAM_PORTDEFINITIONTYPE portdef;
	size_t i;

	debug_log(stdout, "Entered omx_alloc_buffers\n");

	if(!component->handle)
		return OMX_ErrorUndefined;

	OMX_INIT_STRUCTURE(portdef);
	portdef.nPortIndex = component->port;

	omx_err = OMX_GetParameter(component->handle, OMX_IndexParamPortDefinition, &portdef);
	if(omx_err != OMX_ErrorNone) {
		debug_log(stdout, "Failed in OMX_GetParameter inside omx_alloc_buffers\n");
		return omx_err;
	}

	portdef.nBufferCountActual = max(component->buffer_count, portdef.nBufferCountActual);
	portdef.nBufferSize = max(component->buffer_size, portdef.nBufferSize);

	omx_err = OMX_SetParameter(component->handle, OMX_IndexParamPortDefinition, &portdef);
if (omx_err != OMX_ErrorNone) {
		debug_log(stdout, "Failed to set portdef params\n");
		return omx_err;
	}

	debug_log(stdout, "\nnBufferCountActual: %d\nnBufferSize: %d\n\n", portdef.nBufferCountActual, portdef.nBufferSize);
	if(omx_get_state(component) != OMX_StateIdle) {
		if(omx_get_state(component) != OMX_StateLoaded)
			omx_set_state(component, OMX_StateLoaded, 5000);

		omx_set_state(component, OMX_StateIdle, 5000);
	}

	// enable port but don't wait
	omx_err = omx_enable_port(component, 0);
	if(omx_err != OMX_ErrorNone) {
		debug_log(stdout, "Error returned from omx_enable_port inside omx_alloc_buffers. Error string: %s\n", error_type_string(omx_err));
		return omx_err;
	}

	component->alignment = portdef.nBufferAlignment;
	component->buffer_count = portdef.nBufferCountActual;
	component->buffer_size = portdef.nBufferSize;

	for (i = 0; i < portdef.nBufferCountActual; i++) {
		OMX_BUFFERHEADERTYPE *buffer = NULL;
		omx_err = OMX_AllocateBuffer(component->handle, &buffer, component->port, component, component->buffer_size);
		if(omx_err != OMX_ErrorNone) {
		debug_log(stdout, "Failed in OMX_AllocBuffer inside omx_alloc_buffers. Error string: %s\n", error_type_string(omx_err));
			return omx_err;
	}

		buffer->nInputPortIndex = component->port;
		buffer->nFilledLen = 0;
		buffer->nOffset = 0;

	// add the allocated buffer to the linked list buffer_list
		list_append(&component->buffer_list, (void*)buffer);

	// add the allocated buffer to the queue of free buffers
	queue_enqueue(&component->free_buffer_queue, (void*)buffer);
	} // end for

	// now wait for the enable command to complete
	omx_err = wait_for_command_complete(component, OMX_CommandPortEnable, component->port, 50000); 
	if(omx_err != OMX_ErrorNone) {

		return omx_err;
	}

	return omx_err;
} // end omx_alloc_buffers


OMX_ERRORTYPE omx_free_buffers(AUDIO_COMPONENT_T *component) {
	list_destroy(&component->buffer_list);
	queue_destroy(&component->free_buffer_queue);
	return OMX_ErrorNone;
} // end omx_free_buffers







OMX_ERRORTYPE omx_set_pcm_parameters(
	AUDIO_COMPONENT_T *component,
	int samplerate,
	int channels,
	int bitdepth,
	char *dest)
{
	OMX_AUDIO_PARAM_PCMMODETYPE pcm;
	OMX_ERRORTYPE omx_err;
	OMX_INIT_STRUCTURE(pcm);

	debug_log(stdout, "Entered omx_set_pcm_parameters\n");

	pcm.nPortIndex = 100; //component->port;
	pcm.nChannels = channels;
	pcm.eNumData = OMX_NumericalDataSigned;
	pcm.eEndian = OMX_EndianLittle;
	pcm.nSamplingRate = samplerate;
	pcm.bInterleaved = OMX_TRUE;
	pcm.nBitPerSample = bitdepth;
	pcm.ePCMMode = OMX_AUDIO_PCMModeLinear;

	switch (channels) {
		case 1:
			pcm.eChannelMapping[0] = OMX_AUDIO_ChannelCF;
			break;
		case 8:
			pcm.eChannelMapping[0] = OMX_AUDIO_ChannelLF;
			pcm.eChannelMapping[1] = OMX_AUDIO_ChannelRF;
			pcm.eChannelMapping[2] = OMX_AUDIO_ChannelCF;
			pcm.eChannelMapping[3] = OMX_AUDIO_ChannelLFE;
			pcm.eChannelMapping[4] = OMX_AUDIO_ChannelLR;
			pcm.eChannelMapping[5] = OMX_AUDIO_ChannelRR;
			pcm.eChannelMapping[6] = OMX_AUDIO_ChannelLS;
			pcm.eChannelMapping[7] = OMX_AUDIO_ChannelRS;
			break;
		case 4:
			pcm.eChannelMapping[0] = OMX_AUDIO_ChannelLF;
			pcm.eChannelMapping[1] = OMX_AUDIO_ChannelRF;
			pcm.eChannelMapping[2] = OMX_AUDIO_ChannelLR;
			pcm.eChannelMapping[3] = OMX_AUDIO_ChannelRR;
			break;
		case 2:
			pcm.eChannelMapping[0] = OMX_AUDIO_ChannelLF;
			pcm.eChannelMapping[1] = OMX_AUDIO_ChannelRF;
			break;
	}

	omx_err = OMX_SetParameter(component->handle, OMX_IndexParamAudioPcm, &pcm);
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout, "Failed in OMX_SetParameter in omx_set_pcm_parameters. Error string: %s\n", error_type_string(omx_err));
		return omx_err;
	}

	OMX_CONFIG_BRCMAUDIODESTINATIONTYPE ar_dest;
	OMX_INIT_STRUCTURE (ar_dest);
	strcpy ((char *) ar_dest.sName, dest);
	omx_err = OMX_SetConfig(component->handle, OMX_IndexConfigBrcmAudioDestination, &ar_dest);
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout, "Failed in OMX_SetConfig setting audio destination in omx_set_pcm_parameters\n");
		return omx_err;
	}
	return OMX_ErrorNone;
} // end set_pcm_parameters


OMX_ERRORTYPE omx_set_volume(AUDIO_COMPONENT_T *component, unsigned int vol) {
	OMX_ERRORTYPE omx_err;
	OMX_AUDIO_CONFIG_VOLUMETYPE volume;
	OMX_INIT_STRUCTURE (volume);
	debug_log(stdout, "Entered omx_set_volume\n");
	vol = min(100, vol);
	volume.nPortIndex = component->port;
	volume.sVolume.nValue = vol;

	omx_err = OMX_SetParameter(component->handle, OMX_IndexConfigAudioVolume, &volume);
	if (omx_err != OMX_ErrorNone) {
		debug_log(stdout, "Failed in OMX_SetParameter, inside omx_set_volume. Error string: %s\n", error_type_string(omx_err));
		return omx_err;
	}
	debug_log(stdout, "Exit from omx_set_volume\n");
	return OMX_ErrorNone;
} // end omx_set_volume



OMX_ERRORTYPE omx_init_audio_render_component(AUDIO_COMPONENT_T *component, char *compname, int buffers_requested, int buffer_size_requested) {
	OMX_ERRORTYPE omx_err;
	memset (component, 0, sizeof(AUDIO_COMPONENT_T));

	component->port = 100;
	component->buffer_count = buffers_requested;
	component->buffer_size = (max(0, buffer_size_requested) + 15) & ~15;

	pthread_mutex_init (&component->comp_mutex, NULL);
	pthread_mutex_init(&component->event_queue_mutex, NULL);

	component->callbacks.EventHandler = omx_event_callback;
	component->callbacks.EmptyBufferDone = omx_empty_buffer_done_callback;
	component->callbacks.FillBufferDone = NULL; //omx_fill_buffer_done_callback;

	list_init(&component->buffer_list, release_buffer_list_entry);
	queue_init(&component->command_complete_event_queue, release_event_queue_entry);
	queue_init(&component->other_event_queue, release_event_queue_entry);
	queue_init(&component->free_buffer_queue, release_free_buffer_queue_entry);
debug_log(stdout, "Successfully initialised list and queues\n");

	omx_err = OMX_GetHandle(&component->handle, compname, component, &component->callbacks);
	if (omx_err != OMX_ErrorNone)
		return omx_err;
debug_log(stdout, "After GetHandle\n"); 

	omx_err = omx_disable_port(component, 5000);
	if (omx_err != OMX_ErrorNone)
		return omx_err;

	return OMX_ErrorNone;
} // end omx_init_audio_render_component



