/*
*
* core.c - The main code of the library
*
* Main code of the library libilctts.so.
* See the top-level README.md file for details of what the library does.
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
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

#include "bcm_host.h"
#include "ilclient.h"
#include "ilctts_lib.h"
#include "debug.h"



#define OUT_CHANNELS(num_channels) ((num_channels) > 4 ? 8: (num_channels) > 2 ? 4: (num_channels))

//#ifndef countof
//   #define countof(arr) (sizeof(arr) / sizeof(arr[0]))
//#endif

//#define BUFFER_SIZE_SAMPLES 1024

#define OMX_INIT_STRUCTURE(a) \
	memset(&(a), 0, sizeof(a)); \
		(a).nSize = sizeof(a); \
			(a).nVersion.s.nVersionMajor = OMX_VERSION_MAJOR; \
				(a).nVersion.s.nVersionMinor = OMX_VERSION_MINOR; \
					(a).nVersion.s.nRevision = OMX_VERSION_REVISION; \
						(a).nVersion.s.nStep = OMX_VERSION_STEP



static int max(int val1, int val2) {
	return (val1 > val2 ? val1 : val2);
} // end max

static int min(int val1, int val2) {
	return (val1 < val2 ? val1 : val2 );
} // end min

static void input_buffer_callback(void *data, COMPONENT_T *comp) {
	ENTER(LOGLEVEL_5, "input_buffer_callback"); 
	TTSRENDER_STATE_T *st = (TTSRENDER_STATE_T*)data;
	ILC_GET_HANDLE(comp); // just to suppress warnings about unused parameter
		pthread_mutex_lock(&st->free_buffer_mutex);
			pthread_cond_signal(&st->free_buffer_cv);
				pthread_mutex_unlock(&st->free_buffer_mutex);

} // end input_buffer_callback


static void config_changed_callback(void *data, COMPONENT_T *comp) {
	ENTER(LOGLEVEL_3, "config_changed_callback");
} // end config_changed_callback


static void port_settings_changed_callback(void *data, COMPONENT_T *comp) {
	ENTER(LOGLEVEL_3, "port_settings_changed_callback");
} // end port_settings_changed_callback



static void destroy_semaphores(TTSRENDER_STATE_T *st) {
	ENTER(LOGLEVEL_3, "destroy_semaphores");
	sem_destroy(&st->buffer_list_sema);
	return;
} // end destroy_semaphores

static void destroy_mutexes(TTSRENDER_STATE_T *st) {
	ENTER(LOGLEVEL_3, "destroy_mutexes");
	pthread_mutex_destroy(&st->free_buffer_mutex);
	return;
} // end destroy_mutexes


static void*_ringbuffer_consumer_thread(void *arg) {
/*
*
* Note: There are a lot of what might seem like pointless casts in this
* function.  In args to pthread and semaphore functions.
*
* These casts are to suppress compiler warnings
* about 'discarding the volatile directive'.
*
*/
	ENTER(LOGLEVEL_3, "_ringbuffer_consume_thread");
	volatile TTSRENDER_STATE_T *st = (TTSRENDER_STATE_T*)arg;
	uint8_t *buf = NULL;
	int bytes_to_send;
	int rc;

	while(1) {
		// wait for ringbuffer data semaphore. this tells us there is data available in the ring buffer
		sem_wait((sem_t*)&st->ringbuffer_data_sema);
		pthread_mutex_lock((pthread_mutex_t*)&st->ringbuffer_mutex);
		while( ! ringbuffer_isempty(st->ringbuffer)) {
			// set bytes_to_send to either the OMX IL Client buffer size, or the number of bytes waiting in the ring buffer, whichever is the smaller
			bytes_to_send = min(st->buffer_size, ringbuffer_used_space(st->ringbuffer));
			buf = ilctts_get_buffer((TTSRENDER_STATE_T*)st);
			while(buf == NULL) {
				//pthread_mutex_lock((pthread_mutex_t*)&st->free_buffer_mutex);
				//pthread_cond_wait((pthread_cond_t*)&st->free_buffer_cv, (pthread_mutex_t*)&st->free_buffer_mutex);
				buf = ilctts_get_buffer((TTSRENDER_STATE_T*)st);
				//pthread_mutex_unlock((pthread_mutex_t*)&st->free_buffer_mutex);
			}// end while buf == NULL

			rc = ringbuffer_read(st->ringbuffer, (void*)buf, bytes_to_send);
			if (rc == -1) {
				ERROR("ringbuffer_read returned -1 error code in ilctts_consumer_thread\n", "");
			}

			rc = ilctts_send_audio((TTSRENDER_STATE_T*)st, buf, bytes_to_send);
			if (rc == -1) {
				ERROR("ilctts_send_audio returned error code -1 in ilctts_consumer_thread\n", "");
			}

		} // end while buffer is not empty

		pthread_mutex_unlock((pthread_mutex_t*)&st->ringbuffer_mutex);
		// post ringbuffer semaphore to tell producer thread to go ahead
		sem_post((sem_t*)&st->ringbuffer_empty_sema);
		buf = NULL;
		usleep(1000);
	} // end while(1)

	pthread_exit(NULL);
} // end _ringbuffer_consumer_thread

int32_t ilctts_initialize() {
	ENTER(LOGLEVEL_1, "ilctts_initialize");
	OMX_ERRORTYPE omx_err;
	bcm_host_init();
	omx_err = OMX_Init();
	if (omx_err != OMX_ErrorNone) {
		ERROR("OMX_Init returned error in ilctts_initialize: %d", omx_err);
	}
	return (omx_err == OMX_ErrorNone ? 0 : -1);
} // end ilctts_initialize

int32_t ilctts_finalize() {
	ENTER(LOGLEVEL_1, "ilctts_finalize");
	OMX_ERRORTYPE omx_err;
	omx_err = OMX_Deinit();
	if (omx_err != OMX_ErrorNone) {
		ERROR("OMX_Deinit returned error in ilctts_finalize: %d", omx_err);
		return -1;
	}

	return 0;
} // end ilctts_finalize

int32_t ilctts_create(
	TTSRENDER_STATE_T **component,
	uint32_t sample_rate,
	uint32_t num_channels,
	uint32_t bit_depth,
	uint32_t num_buffers,
	uint32_t buffer_size,
	uint32_t ringbuffer_length
)
{
	ENTER(LOGLEVEL_1, "ilctts_create");
	int32_t ret;
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
		ERROR("sem_init returned error in ilctts_create: %d", s);
		return -1;
	}

	// free_buffer mutex and cv
	pthread_mutex_init(&st->free_buffer_mutex, NULL);
	pthread_cond_init(&st->free_buffer_cv, NULL);

	// ringbuffer mutex
	pthread_mutex_init(&st->ringbuffer_mutex, NULL);
	//pthread_cond_init(&st->ringbuffer_cv, NULL);

	st->sample_rate = sample_rate;
	st->num_channels = num_channels;
	st->bit_depth = bit_depth;
	st->bytes_per_sample = (bit_depth * OUT_CHANNELS(num_channels)) >> 3;
	st->buffer_size = (buffer_size + 15) & ~15;
	st->num_buffers = num_buffers;
	st->client = ilclient_init();
	st->tts_state = TTS_INIT;
	st->tts_pause_state = TTS_PAUSE_OFF;

	st->ringbuffer = ringbuffer_init(ringbuffer_length);
	if (st->ringbuffer == NULL) {
		ERROR("ringbuffer_init failed in ilctts_create", "");
		return -1;
	}

	// set up callbacks
	ilclient_set_empty_buffer_done_callback(st->client, input_buffer_callback, st);
	ilclient_set_configchanged_callback(st->client, config_changed_callback, st);
	ilclient_set_port_settings_callback(st->client, port_settings_changed_callback, st);

	ret = ilclient_create_component(st->client, &st->audio_render, "audio_render", ILCLIENT_ENABLE_INPUT_BUFFERS | ILCLIENT_DISABLE_ALL_PORTS);
	if (ret == -1) {
		ERROR("ilclcient_create_component returned error in ilctts_create: %d", ret);
		return ret;
	}

	st->list[0] = st->audio_render;

	// set up the number/size of buffers
		OMX_INIT_STRUCTURE(param);
	param.nPortIndex = 100;
	omx_err = OMX_GetParameter(ILC_GET_HANDLE(st->audio_render), OMX_IndexParamPortDefinition, &param);
	if (omx_err != OMX_ErrorNone) {
		ERROR("OMX_GetParameter returned error in ilctts_create: %d", omx_err);
		return -1;
	}

	// set the buffer size to the requested size, or the minimum size returned, whichever is greater
	st->buffer_size = max(buffer_size, param.nBufferSize);
	param.nBufferSize = st->buffer_size;
	param.nBufferCountActual = max(st->buffer_count, param.nBufferCountMin);

	omx_err = OMX_SetParameter(ILC_GET_HANDLE(st->audio_render), OMX_IndexParamPortDefinition, &param);
	if (omx_err != OMX_ErrorNone) {
		ERROR("OMX_SetParameter returned error in ilctts_create: %d", omx_err);
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
		ERROR("OMX_SetParameter returned error in ilctts_create: %d", omx_err);
		return -1;
	}

	// this function waits for the command to complete
	ret = ilclient_change_component_state(st->audio_render, OMX_StateIdle);
	if (ret < 0) {
		ERROR("ilctts_change_component_state returned error in ilctts_create: %d", ret);
		return -1;
	}

	ret = ilclient_enable_port_buffers(st->audio_render, 100, NULL, NULL, NULL);
	if (ret < 0) {
		ERROR("ilclient_enable_port_buffers returned error in ilctts_create: %d", ret);
		ilclient_change_component_state(st->audio_render, OMX_StateLoaded);
		ilclient_cleanup_components(st->list);
		omx_err = OMX_Deinit();
		ilclient_destroy(st->client);
		destroy_semaphores(st);
		destroy_mutexes(st);
		ringbuffer_destroy(st->ringbuffer);
		// need to destroy and free other stuff here?
		free(st);
		*component = NULL;
		return -1;
	}

	INFO(LOGLEVEL_1, "Setting state to executing in ilctts_create");
	return ilclient_change_component_state(st->audio_render, OMX_StateExecuting);

} // end ilctts_create


int32_t ilctts_delete(TTSRENDER_STATE_T *st) {
	ENTER(LOGLEVEL_1, "ilctts_delete");
	int32_t ret;
	OMX_ERRORTYPE omx_err;

	ret = ilclient_change_component_state(st->audio_render, OMX_StateIdle);
	if (ret < 0) {
		ERROR("ilctts_change_component_state returned error in ilctts_delete: %d", ret);
		return -1;
	}

	omx_err = OMX_SendCommand(ILC_GET_HANDLE(st->audio_render), OMX_CommandStateSet, OMX_StateLoaded, NULL);
	if (omx_err != OMX_ErrorNone) {
		ERROR("OMX_SendCommand returned error in ilctts_delete: %d", omx_err);
		return -1;
	}


	ilclient_disable_port_buffers(st->audio_render, 100, st->user_buffer_list, NULL, NULL);
	ilclient_change_component_state(st->audio_render, OMX_StateLoaded);
	ilclient_cleanup_components(st->list);

	ilclient_destroy(st->client);
	sem_destroy(&st->buffer_list_sema);
	free(st);

	return 0;
} // end ilctts_delete


uint8_t *ilctts_get_buffer(TTSRENDER_STATE_T *st) {
	ENTER(LOGLEVEL_5, "ilctts_get_buffer");
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
} // end ilctts_get_buffer


int32_t ilctts_send_audio(TTSRENDER_STATE_T *st, uint8_t *buffer, uint32_t length) {
	ENTER(LOGLEVEL_5, "ilctts_send_audio");
	OMX_BUFFERHEADERTYPE *hdr = NULL, *prev = NULL;
	int32_t ret = -1;

	if(length % st->bytes_per_sample) {
		ERROR("length invalid in ilctts_send_audio: %d", length);
		return -1;
	}

	if (length > st->buffer_size) {
		ERROR("length exceeds component buffer size in ilctts_send_audio: %d, buffer size: %d", length, st->buffer_size); 
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
		INFO(LOGLEVEL_5, "Calling empty_this_buffer");
		omx_err = OMX_EmptyThisBuffer(ILC_GET_HANDLE(st->audio_render), hdr);
		if (omx_err != OMX_ErrorNone) {
			ERROR("OMX_EmptyThisBuffer returned error in ilctts_send_audio: %d", omx_err);
			return -1;
		}
	}
	return ret;
} // end ilctts_send_audio


int32_t ilctts_set_dest(TTSRENDER_STATE_T *st, const char *name) {
	ENTER(LOGLEVEL_3, "ilctts_set_dest");
	int32_t ret = -1;
	OMX_CONFIG_BRCMAUDIODESTINATIONTYPE dest;

	if (name && strlen(name) < sizeof(dest.sName)) {
		OMX_ERRORTYPE omx_err;
		OMX_INIT_STRUCTURE(dest);
		strcpy((char *)dest.sName, name);

		 omx_err = OMX_SetConfig(ILC_GET_HANDLE(st->audio_render), OMX_IndexConfigBrcmAudioDestination, &dest);
		 	if (omx_err != OMX_ErrorNone) {
				ERROR("OMX_SetConfig returned error in ilctts_set_dest: %d", omx_err);
				return ret;
			}

		ret = 0;
	}

	return ret;
} // end ilctts_set_dest



uint32_t ilctts_get_latency(TTSRENDER_STATE_T *st) {
	ENTER(LOGLEVEL_5, "ilctts_get_latency");
	OMX_PARAM_U32TYPE param;
	OMX_ERRORTYPE omx_err;
	OMX_INIT_STRUCTURE(param);
	param.nPortIndex = 100;

	omx_err = OMX_GetConfig(ILC_GET_HANDLE(st->audio_render), OMX_IndexConfigAudioRenderingLatency, &param);
	if (omx_err != OMX_ErrorNone) {
		ERROR("OMX_GetConfig returned error in ilctts_get_latency: %d", omx_err);
		return -1;
	}

	return param.nU32;
} // end ilctts_get_latency



int32_t ilctts_get_state(TTSRENDER_STATE_T *st, OMX_STATETYPE *state) {
	ENTER(LOGLEVEL_4, "ilctts_get_state");
	OMX_ERRORTYPE omx_err = OMX_GetState(ILC_GET_HANDLE(st->audio_render), state);
	if (omx_err != OMX_ErrorNone) {
		ERROR("OMX_GetState returned error in ilctts_get_state: %d", omx_err);
		return -1;
	}

	return 0;
} // end ilctts_get_state


int32_t ilctts_set_volume(TTSRENDER_STATE_T *st, unsigned int vol) {
	ENTER(LOGLEVEL_4, "ilctts_set_volume");
	OMX_ERRORTYPE omx_err;
	OMX_AUDIO_CONFIG_VOLUMETYPE volume;
	OMX_INIT_STRUCTURE(volume);
	vol = min(100, vol);
	volume.nPortIndex = 100;
	volume.sVolume.nValue = vol;
	omx_err = OMX_SetParameter(ILC_GET_HANDLE(st->audio_render), OMX_IndexConfigAudioVolume, &volume);
	if (omx_err != OMX_ErrorNone) {
		ERROR("OMX_SetParameter returned error in ilctts_set_volume: %d", omx_err);
		return -1;
	}

	return 0;
} // end ilctts_set_volume

int32_t ilctts_pause(TTSRENDER_STATE_T *st) {
	ENTER(LOGLEVEL_4, "ilctts_pause");
		return ilclient_change_component_state(st->audio_render, OMX_StatePause);
		} //end ilctts_pause

int32_t ilctts_resume(TTSRENDER_STATE_T *st) {
	ENTER(LOGLEVEL_4, "ilctts_resume");
	return ilclient_change_component_state(st->audio_render, OMX_StateExecuting);
} //end ilctts_resume

int32_t ilctts_start_ringbuffer_consumer_thread(TTSRENDER_STATE_T *st) {
	ENTER(LOGLEVEL_5, "ilctts_start_ringbuffer_consumer_thread");
	pthread_t th;
	return pthread_create(&th, NULL, _ringbuffer_consumer_thread, (void*)st);
} // end ilctts_start_ringbuffer_consumer_thread

/*
void ilctts_stop_ringbuffer_consumer_thread(TTSRENDER_STATE_T *st) {
	ENTER(LOGLEVEL_5, "ilctts_stop_ringbuffer_consumer_thread");
	
	return;
} // end ilctts_stop_ringbuffer_consumer_thread
*/




