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

#define OMX_INIT_STRUCTURE(a) \
	memset(&(a), 0, sizeof(a)); \
	(a).nSize = sizeof(a); \
	(a).nVersion.s.nVersionMajor = OMX_VERSION_MAJOR; \
	(a).nVersion.s.nVersionMinor = OMX_VERSION_MINOR; \
	(a).nVersion.s.nRevision = OMX_VERSION_REVISION; \
	(a).nVersion.s.nStep = OMX_VERSION_STEP



static uint64_t time_now_microseconds() {
	struct timespec now;
	if (clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &now) == -1)
		return 0;

	return (now.tv_sec * 1000000) + (now.tv_nsec / 1000);
} // end time_now_microseconds


static OMX_ERRORTYPE omx_wait_for_command_complete(OMX_COMPONENT_T*component, OMX_U32 command, OMX_U32 nData2, uint64_t timeout) {
	if (component == NULL)
		return OMX_EventError;

	uint64_t start_time = time_now_microseconds();

	struct OMX_EVENT_T *event = NULL;
	const char *event_str;

	do {
		if (event != NULL) {
			free(event);
		}
		if (omx_get_event(component, &event) > -1) {
			if (event) {
				arse(event->eEvent);
			} // if (event)
		} // if (omxGetEvent(component, &event) > -1)
	} while (((time_now_microseconds() - start_time) < timeout) || (event != NULL));

	return OMX_ErrorTimeout;
} // end omx_wait_for_command_complete

OMX_ERRORTYPE omx_enable_port(OMX_COMPONENT_T *component, OMX_U32 port,  uint64_t wait) {
	OMX_ERRORTYPE omx_err = OMX_ErrorNone;

	OMX_PARAM_PORTDEFINITIONTYPE portdef;
	OMX_INIT_STRUCTURE(portdef);
	portdef.nPortIndex = port;

	omx_err = OMX_GetParameter(component->handle, OMX_IndexParamPortDefinition, &portdef);

	if(portdef.bEnabled == OMX_FALSE) {
		omx_err = OMX_SendCommand(component->handle, OMX_CommandPortEnable, port, NULL);
		if(omx_err != OMX_ErrorNone) {
			return omx_err;
		}
		if(wait) {
			omx_err = omxWaitForCommandComplete(component, OMX_CommandPortEnable, port, 1000);
		}
	}

	return omx_err;
} // end omx_enable_port



OMX_ERRORTYPE omx_disable_port(OMX_COMPONENT_T *component, OMX_U32 port, uint64_t wait) {
	OMX_ERRORTYPE omx_err = OMX_ErrorNone;

	OMX_PARAM_PORTDEFINITIONTYPE portdef;
	OMX_INIT_STRUCTURE(portdef);
	portdef.nPortIndex = port;

	omx_err = OMX_GetParameter(component->handle, OMX_IndexParamPortDefinition, &portdef);
	if (omx_err != OMX_ErrorNone) {
		return omx_err;
	}
	if(portdef.bEnabled == OMX_TRUE) {
		omx_err = OMX_SendCommand(component->handle, OMX_CommandPortDisable, port, NULL);
		if(omx_err != OMX_ErrorNone) {
			return omx_err;
		}
		if(wait) {
			omx_err = omxWaitForCommandComplete(component, OMX_CommandPortDisable, port, 1000);
		}
	}

	return omx_err;
} // end omx_disable_port



OMX_STATETYPE omx_get_state(OMX_COMPONENT_T *component) {
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




OMX_ERRORTYPE omx_set_state(struct OMX_COMPONENT_T *component, OMX_STATETYPE state, uint64_t timeout) {
	OMX_ERRORTYPE omx_err = OMX_ErrorNone;
	OMX_STATETYPE state_actual = OMX_StateMax;

	if (!component)
		return OMX_ErrorNone;

	if(!component->handle)
		return OMX_ErrorUndefined;

	state_actual = omx_get_state(component);
	if(state == state_actual)
		return OMX_ErrorNone;

	omx_err = OMX_SendCommand(component->handle, OMX_CommandStateSet, state, NULL);
	if (omx_err != OMX_ErrorNone) {
		if(omx_err == OMX_ErrorSameState) {
			omx_err = OMX_ErrorNone;
		}
		if (wait) {
			omx_err = omx_wait_for_command_complete(component, OMX_CommandStateSet, state, timeout);
		}
	}

	return omx_err;
} // end omx_set_state




OMX_ERRORTYPE omx_alloc_buffers(OMX_COMPONENT_T *component) {
	OMX_ERRORTYPE omx_err = OMX_ErrorNone;
	OMX_PARAM_PORTDEFINITIONTYPE portdef;
	size_t i;

	if(!component->handle)
		return OMX_ErrorUndefined;

	OMX_INIT_STRUCTURE(portdef);
	portdef.nPortIndex = component->port;

	omx_err = OMX_GetParameter(component->handle, OMX_IndexParamPortDefinition, &portdef);
	if(omx_err != OMX_ErrorNone)
		return omx_err;

	if(omx_get_state(component) != OMX_StateIdle) {
		if(omx_get_state(component) != OMX_StateLoaded)
			omx_set_state(component, OMX_StateLoaded, 5000);

		omx_set_state(component, OMX_StateIdle, 5000);
	}

	// enable port but don't wait
	omx_err = omx_enable_port(component, component->port, 0);
	if(omx_err != OMX_ErrorNone)
		return omx_err;

	component->alignment = portdef.nBufferAlignment;
	component->buffer_count = portdef.nBufferCountActual;
	component->buffer_size = portdef.nBufferSize;

	for (i = 0; i < portdef.nBufferCountActual; i++) {
		OMX_BUFFERHEADERTYPE *buffer = NULL;
		omx_err = OMX_AllocateBuffer(component->handle, &buffer, component->port, NULL, portdef.nBufferSize);
		if(omx_err != OMX_ErrorNone)
			return omx_err;

		buffer->nInputPortIndex = component->port;
		buffer->nFilledLen = 0;
		buffer->nOffset = 0;
		buffer->pAppPrivate = (void*)i; 

		component->buffer_hdr_end = component->buffer_hdr_end->next;
	} // end for

	// now wait for the enable command to complete
	omx_err = omx_wait_for_command_complete(component, OMX_CommandPortEnable, component->port, 50000); 
	if(omx_err != OMX_ErrorNone)
		return omx_err;

	return omx_err;
} // end omx_alloc_buffers


OMX_ERRORTYPE omx_free_buffers(OMX_COMPONENT_T *component) {
	OMX_BUFFERHEADERTYPE *buf, *prev;
	buf = component->buffers;
	while (buf) {
		prev = buf->pAppPrivate;
		OMX_FreeBuffer(component->handle, component->port, buf);
		buf = prev;
	}
	return OMX_ErrorNone;
} // end omx_free_buffers






OMX_ERRORTYPE omx_set_pcm_parameters(OMX_COMPONENT_T *component, int samplerate, int channels, int bitdepth, char *dest) {
	OMX_AUDIO_PARAM_PCMMODETYPE pcm;
	OMX_ERRORTYPE omx_err;
	OMX_INIT_STRUCTURE(pcm);

	pcm.nPortIndex = component->port;
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
		return omx_err;
	}

	OMX_CONFIG_BRCMAUDIODESTINATIONTYPE ar_dest;
	OMX_INIT_STRUCTURE (ar_dest);
	strcpy ((char *) ar_dest.sName, dest);
	omx_err = OMX_SetConfig(component->handle, OMX_IndexConfigBrcmAudioDestination, &ar_dest);
	if (omx_err != OMX_ErrorNone) {
		return omx_err;
	}
	return OMX_ErrorNone;
} // end set_pcm_parameters


OMX_ERRORTYPE omx_set_volume(OMX_COMPONENT_T *component, unsigned int vol) {
	OMX_ERRORTYPE omx_err;
	OMX_AUDIO_CONFIG_VOLUMETYPE volume;
	OMX_INIT_STRUCTURE (volume);

	vol = min(100, vol);
	volume.nPortIndex = component->port;
	volume.sVolume.nValue = vol;

	omx_err = OMX_SetParameter(component->handle, OMX_IndexConfigAudioVolume, &volume);
	if (omx_err != OMX_ErrorNone) {
		return omx_err;
	}
	return OMX_ErrorNone;
} // end omx_set_volume



OMX_ERRORTYPE omx_init_audio_render_component(OMX_COMPONENT_T *component, char *compname) {
	OMX_ERRORTYPE omx_err;
	memset (component, 0, sizeof(OMX_COMPONENT_T));

	pthread_mutex_init (&component->comp_mutex, NULL);
	//pthread_cond_init (&component->cmd_queue_count_cv, NULL);
	//component->buf_notempty = 1;
	//pthread_cond_init (&component->buf_notempty_cv, NULL);
	//pthread_cond_init (&component->eos_cv, NULL);
	//pthread_mutex_init (&component->eos_mutex, NULL);

	component->callbacks.EventHandler = omx_event_handler;
	component->callbacks.EmptyBufferDone = omx_empty_buffer_done;
	component->callbacks.FillBufferDone = omx_fill_buffer_done;

	omx_err = OMX_GetHandle(&component->handle, compname, component, &component->callbacks);
	if (omx_err != OMX_ErrorNone) { 
		return omx_err;
}

	//omx_disable_all_ports (component);
	omx_err = omx_disable_port(component, component->port, 5000);
	if (omx_error != OMX_ErrorNone) {
		return omx_err;
	}

	return OMX_ErrorNone;
} // end omx_init_audio_render_component



