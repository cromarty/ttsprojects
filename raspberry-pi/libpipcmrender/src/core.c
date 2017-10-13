/*
*
* core.c - The main code of the library
*
* Main code of the library libpipcmrender.so.
* See the top-level README file for details of what the library does.
*
* Copyright (C) 2014, Mike Ray, <mike.ray@btinternet.com>
*
* This is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 3, or (at your option) any later
* version.
*
* This software is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this package; see the file COPYING.  If not, write to the Free
* Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
* 02110-1301, USA.
*
*--code--*/
#include "config.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>
#include <sys/time.h>
#include <sys/resource.h>

#include "bcm_host.h"
#include "ilclient.h"
#include "pipcmrender_lib.h"
#include "core.h"
//#include "debug.h"


#define OUT_CHANNELS(num_channels) ((num_channels) > 4 ? 8: (num_channels) > 2 ? 4: (num_channels))

#define OMX_INIT_STRUCTURE(a) \
	memset(&(a), 0, sizeof(a)); \
		(a).nSize = sizeof(a); \
			(a).nVersion.s.nVersionMajor = OMX_VERSION_MAJOR; \
				(a).nVersion.s.nVersionMinor = OMX_VERSION_MINOR; \
					(a).nVersion.s.nRevision = OMX_VERSION_REVISION; \
						(a).nVersion.s.nStep = OMX_VERSION_STEP

#define CTTW_SLEEP_TIME 10
#define MIN_LATENCY_TIME 20



static int max(int val1, int val2) {
	return (val1 > val2 ? val1 : val2);
} // end max

static int min(int val1, int val2) {
	return (val1 < val2 ? val1 : val2 );
} // end min

static void input_buffer_callback(void *data, COMPONENT_T *comp) {
	TTSRENDER_STATE_T *st = (TTSRENDER_STATE_T*)data;
	ILC_GET_HANDLE(comp); // just to suppress warnings about unused parameter
	pthread_mutex_lock(&st->free_buffer_mutex);
	pthread_cond_signal(&st->free_buffer_cv);
	pthread_mutex_unlock(&st->free_buffer_mutex);

} // end input_buffer_callback

/*
static void config_changed_callback(void *data, COMPONENT_T *comp) {

} // end config_changed_callback


static void port_settings_changed_callback(void *data, COMPONENT_T *comp) {

} // end port_settings_changed_callback
*/


static void destroy_semaphores(TTSRENDER_STATE_T *st) {
	sem_destroy(&st->buffer_list_sema);
	return;
} // end destroy_semaphores

static void destroy_mutexes(TTSRENDER_STATE_T *st) {
	pthread_mutex_destroy(&st->free_buffer_mutex);
	return;
} // end destroy_mutexes


static int calc_buffer_size_from_ms(
	int sample_rate,
	int bit_depth,
	int channels,
	int ms,
	int align
)
{
	int buffer_size;

	if (sample_rate <= 0)
		return -1;

	if (bit_depth <= 0)
		return -1;

	if (bit_depth & 8)
		return -1;

	if ( (channels < 1) || (channels > 2) )
		return -1;

	buffer_size = sample_rate * channels * (bit_depth / 8) * (ms/1000.0);
	if (align)
		return (buffer_size + 15) & ~15;
	else
		return buffer_size;

} // end calc_buffer_size_from_ms


static double get_benchmark_time()
{
    struct timeval t;
    struct timezone tzp;
    gettimeofday(&t, &tzp);
    return t.tv_sec + t.tv_usec*1e-6;
} // end get_time


int32_t pipcmrender_initialize() {
	OMX_ERRORTYPE omx_err;
	bcm_host_init();
	omx_err = OMX_Init();
	if (omx_err != OMX_ErrorNone) {
	}
	return (omx_err == OMX_ErrorNone ? 0 : -1);
} // end pipcmrender_initialize

int32_t pipcmrender_finalize() {
	OMX_ERRORTYPE omx_err;
	omx_err = OMX_Deinit();
	if (omx_err != OMX_ErrorNone) {
		return -1;
	}

	return 0;
} // end pipcmrender_finalize

int32_t pipcmrender_create(
	TTSRENDER_STATE_T **component,
	uint32_t sample_rate,
	uint32_t num_channels,
	uint32_t bit_depth,
	uint32_t num_buffers,
	uint32_t buffer_size_ms,
	BUFFER_SIZE_TYPE_T buffer_size_type
)
{

	int32_t ret;
	uint32_t buffer_size;

		OMX_ERRORTYPE omx_err;
	TTSRENDER_STATE_T *st;

	*component = NULL;

	st = calloc(1, sizeof(TTSRENDER_STATE_T));
	OMX_PARAM_PORTDEFINITIONTYPE param;
	OMX_AUDIO_PARAM_PCMMODETYPE pcm;
	int32_t s;

	*component = st;

	// create and start up everything

	// initialise buffer list semaphore
	s = sem_init(&st->buffer_list_sema, 0, 1);
	if (s < 0) {
		return -1;
	}

	// free_buffer mutex and cv
	pthread_mutex_init(&st->free_buffer_mutex, NULL);
	pthread_cond_init(&st->free_buffer_cv, NULL);

	st->sample_rate = sample_rate;
	st->num_channels = num_channels;
	st->bit_depth = bit_depth;
	st->bytes_per_sample = (bit_depth * OUT_CHANNELS(num_channels)) >> 3;

	if (buffer_size_type == BS_MILLISECONDS) {
		// supplied buffer size was in milliseconds, calculate the byte size
		// note: calc_buffer_size_from_ms returns buffer size aligned for VCHI
		buffer_size = calc_buffer_size_from_ms(sample_rate, bit_depth, num_channels, buffer_size_ms, 1);
	} else {
		// supplied buffer size was in bytes
		// buffer size must be 16 byte aligned for VCHI
		buffer_size = (buffer_size_ms + 15) & ~15;
	}

	st->num_buffers = num_buffers;
	st->client = ilclient_init();
	st->tts_stop = 0;
	st->tts_pause_state = TTS_PAUSE_OFF;


	// set up callbacks
	ilclient_set_empty_buffer_done_callback(st->client, input_buffer_callback, st);
	//ilclient_set_configchanged_callback(st->client, config_changed_callback, st);
	//ilclient_set_port_settings_callback(st->client, port_settings_changed_callback, st);

	ret = ilclient_create_component(st->client, &st->audio_render, "audio_render", ILCLIENT_ENABLE_INPUT_BUFFERS | ILCLIENT_DISABLE_ALL_PORTS);
	if (ret == -1) {
		return ret;
	}

	st->list[0] = st->audio_render;

	// set up the number/size of buffers
		OMX_INIT_STRUCTURE(param);
	param.nPortIndex = 100;
	omx_err = OMX_GetParameter(ILC_GET_HANDLE(st->audio_render), OMX_IndexParamPortDefinition, &param);
	if (omx_err != OMX_ErrorNone) {
		return -1;
	}

	// set the buffer size to the requested size, or the minimum size returned, whichever is greater
	st->buffer_size = max(buffer_size, param.nBufferSize);
	param.nBufferSize = st->buffer_size;
	param.nBufferCountActual = max(st->buffer_count, param.nBufferCountMin);

	omx_err = OMX_SetParameter(ILC_GET_HANDLE(st->audio_render), OMX_IndexParamPortDefinition, &param);
	if (omx_err != OMX_ErrorNone) {
		return -1;
	}

	// set the pcm parameters
	OMX_INIT_STRUCTURE(pcm);
	pcm.nPortIndex = 100;
	pcm.nChannels = OUT_CHANNELS(num_channels);
	pcm.eNumData = OMX_NumericalDataSigned;
	pcm.eEndian = OMX_EndianLittle;
	pcm.nSamplingRate = sample_rate;
	pcm.bInterleaved = OMX_TRUE;
	pcm.nBitPerSample = bit_depth;
	pcm.ePCMMode = OMX_AUDIO_PCMModeLinear;

	switch(st->num_channels) {
		case 1:
			pcm.eChannelMapping[0] = OMX_AUDIO_ChannelCF;
			break;
		case 3:
			pcm.eChannelMapping[2] = OMX_AUDIO_ChannelCF;
			pcm.eChannelMapping[1] = OMX_AUDIO_ChannelRF;
			pcm.eChannelMapping[0] = OMX_AUDIO_ChannelLF;
			break;
		case 8:
			pcm.eChannelMapping[7] = OMX_AUDIO_ChannelRS;
		case 7:
			pcm.eChannelMapping[6] = OMX_AUDIO_ChannelLS;
		case 6:
			pcm.eChannelMapping[5] = OMX_AUDIO_ChannelRR;
		case 5:
			pcm.eChannelMapping[4] = OMX_AUDIO_ChannelLR;
		case 4:
			pcm.eChannelMapping[3] = OMX_AUDIO_ChannelLFE;
			pcm.eChannelMapping[2] = OMX_AUDIO_ChannelCF;
		case 2:
			pcm.eChannelMapping[1] = OMX_AUDIO_ChannelRF;
		pcm.eChannelMapping[0] = OMX_AUDIO_ChannelLF;
			break;
	}

	omx_err = OMX_SetParameter(ILC_GET_HANDLE(st->audio_render), OMX_IndexParamAudioPcm, &pcm);
	if (omx_err != OMX_ErrorNone) {
		return -1;
	}

	// this function waits for the command to complete
	ret = ilclient_change_component_state(st->audio_render, OMX_StateIdle);
	if (ret < 0) {
		return -1;
	}

	ret = ilclient_enable_port_buffers(st->audio_render, 100, NULL, NULL, NULL);
	if (ret < 0) {
		ilclient_change_component_state(st->audio_render, OMX_StateLoaded);
		ilclient_cleanup_components(st->list);
		omx_err = OMX_Deinit();
		ilclient_destroy(st->client);
		destroy_semaphores(st);
		destroy_mutexes(st);
		// need to destroy and free other stuff here?
		free(st);
		*component = NULL;
		return -1;
	}

	return ilclient_change_component_state(st->audio_render, OMX_StateExecuting);

} // end pipcmrender_create


int32_t pipcmrender_delete(TTSRENDER_STATE_T *st) {
	int32_t ret;
	OMX_ERRORTYPE omx_err;

	ret = ilclient_change_component_state(st->audio_render, OMX_StateIdle);
	if (ret < 0) {
		return -1;
	}

	omx_err = OMX_SendCommand(ILC_GET_HANDLE(st->audio_render), OMX_CommandStateSet, OMX_StateLoaded, NULL);
	if (omx_err != OMX_ErrorNone) {
		return -1;
	}


	ilclient_disable_port_buffers(st->audio_render, 100, st->user_buffer_list, NULL, NULL);
	ilclient_change_component_state(st->audio_render, OMX_StateLoaded);
	ilclient_cleanup_components(st->list);

	ilclient_destroy(st->client);
	//sem_destroy(&st->buffer_list_sema);
	destroy_semaphores(st);
	destroy_mutexes(st);
	free(st);
	return 0;
} // end pipcmrender_delete


uint8_t *pipcmrender_get_buffer(TTSRENDER_STATE_T *st) {
	OMX_BUFFERHEADERTYPE *hdr = NULL;

	hdr = ilclient_get_input_buffer(st->audio_render, 100, 0);
	if(hdr) {
		// put on the user list
		sem_wait(&st->buffer_list_sema);
		hdr->pAppPrivate = st->user_buffer_list;
		st->user_buffer_list = hdr;
		sem_post(&st->buffer_list_sema);
	}

	return hdr ? hdr->pBuffer : NULL;
} // end pipcmrender_get_buffer


int32_t pipcmrender_send_audio(TTSRENDER_STATE_T *st, uint8_t *buffer, uint32_t length) {
	OMX_BUFFERHEADERTYPE *hdr = NULL, *prev = NULL;
	int32_t ret = -1;

	if(length % st->bytes_per_sample) {
		return -1;
	}

	if (length > st->buffer_size) {
		return -1;
	}

	sem_wait(&st->buffer_list_sema);

	// search through user list for the right buffer header
	hdr = st->user_buffer_list;
	while(hdr != NULL && hdr->pBuffer != buffer && hdr->nAllocLen < length) {
		prev = hdr;
		hdr = hdr->pAppPrivate;
	}

	if(hdr) {
		// we found it, remove from list
		ret = 0;
		if(prev)
			prev->pAppPrivate = hdr->pAppPrivate;
		else
			st->user_buffer_list = hdr->pAppPrivate;
	}

	sem_post(&st->buffer_list_sema);

	if(hdr) {
		OMX_ERRORTYPE omx_err;
		hdr->pAppPrivate = NULL;
		hdr->nOffset = 0;
		hdr->nFilledLen = length;
		omx_err = OMX_EmptyThisBuffer(ILC_GET_HANDLE(st->audio_render), hdr);
		if (omx_err != OMX_ErrorNone) {
			return -1;
		}
	}
	return ret;
} // end pipcmrender_send_audio


int32_t pipcmrender_set_dest(TTSRENDER_STATE_T *st, const char *name) {
	OMX_ERRORTYPE omx_err;
	OMX_CONFIG_BRCMAUDIODESTINATIONTYPE dest;
	char device[8];

	if ( (strcmp(name, "local") != 0) && (strcmp(name, "hdmi") != 0) )
		strcpy(device, "local");
	else
		strcpy(device, name);

	OMX_INIT_STRUCTURE(dest);
	strcpy((char *)dest.sName, device);

	 omx_err = OMX_SetConfig(ILC_GET_HANDLE(st->audio_render), OMX_IndexConfigBrcmAudioDestination, &dest);
 	if (omx_err != OMX_ErrorNone) {
		return -1;
	}

	return 0;
} // end pipcmrender_set_dest



uint32_t pipcmrender_get_latency(TTSRENDER_STATE_T *st) {
	OMX_PARAM_U32TYPE param;
	OMX_ERRORTYPE omx_err;
	OMX_INIT_STRUCTURE(param);
	param.nPortIndex = 100;

	omx_err = OMX_GetConfig(ILC_GET_HANDLE(st->audio_render), OMX_IndexConfigAudioRenderingLatency, &param);
	if (omx_err != OMX_ErrorNone) {
		return -1;
	}

	return param.nU32;
} // end pipcmrender_get_latency



int32_t pipcmrender_get_state(TTSRENDER_STATE_T *st, OMX_STATETYPE *state) {
	OMX_ERRORTYPE omx_err = OMX_GetState(ILC_GET_HANDLE(st->audio_render), state);
	if (omx_err != OMX_ErrorNone) {
		return -1;
	}

	return 0;
} // end pipcmrender_get_state


int32_t pipcmrender_set_volume(TTSRENDER_STATE_T *st, unsigned int vol) {
	OMX_ERRORTYPE omx_err;
	OMX_AUDIO_CONFIG_VOLUMETYPE volume;
	OMX_INIT_STRUCTURE(volume);
	vol = min(100, vol);
	volume.nPortIndex = 100;
	volume.sVolume.nValue = vol;
	omx_err = OMX_SetParameter(ILC_GET_HANDLE(st->audio_render), OMX_IndexConfigAudioVolume, &volume);
	if (omx_err != OMX_ErrorNone) {
		return -1;
	}

	return 0;
} // end pipcmrender_set_volume

int32_t pipcmrender_pause(TTSRENDER_STATE_T *st) {
		return ilclient_change_component_state(st->audio_render, OMX_StatePause);
		} //end pipcmrender_pause

int32_t pipcmrender_resume(TTSRENDER_STATE_T *st) {
	return ilclient_change_component_state(st->audio_render, OMX_StateExecuting);
} //end pipcmrender_resume

void pipcmrender_stop_request(TTSRENDER_STATE_T *st) {
	st->tts_stop = 1;
	return;
} // end pipcmrender_stop_request


int32_t pipcmrender_flush(TTSRENDER_STATE_T *st) {
	OMX_ERRORTYPE omx_err;
	omx_err = OMX_SendCommand(ILC_GET_HANDLE(st->audio_render), OMX_CommandFlush, -1, NULL);
	if (omx_err != OMX_ErrorNone) {
		return -1;
	}
	return 0;
} // end pipcmrender_flush

void pipcmrender_latency_wait(TTSRENDER_STATE_T *st) {
	uint32_t latency;
	while( (latency = pipcmrender_get_latency(st)) > (st->sample_rate * (MIN_LATENCY_TIME + CTTW_SLEEP_TIME) / 1000))
		usleep(CTTW_SLEEP_TIME*1000);

	return;
} // end pipcmrender_latency_wait


