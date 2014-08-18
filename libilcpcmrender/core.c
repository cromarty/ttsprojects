#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>

#include "bcm_host.h"
#include "ilclient.h"

#include "ilcpcmrender.h"


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
						
						
static const char *audio_dest[] = {"local", "hdmi"};

static int max(int val1, int val2) {
	return (val1 > val2 ? val1 : val2);
} // end max

static int min(int val1, int val2) {
	return (val1 < val2 ? val1 : val2 );
} // end min

static void input_buffer_callback(void *data, COMPONENT_T *comp) {

} // end input_buffer_callback


int32_t pcmrender_create(
	PCMRENDER_STATE_T **component,
	uint32_t sample_rate,
	uint32_t num_channels,
	uint32_t bit_depth,
	uint32_t num_buffers,
	uint32_t buffer_size)
{
	int32_t ret;
		OMX_ERRORTYPE omx_err;
	PCMRENDER_STATE_T *st;


	*component = NULL;


	st = calloc(1, sizeof(PCMRENDER_STATE_T));
	OMX_PARAM_PORTDEFINITIONTYPE param;
	OMX_AUDIO_PARAM_PCMMODETYPE pcm;
	int32_t s;

	*component = st;

	// create and start up everything
	s = sem_init(&st->sema, 0, 1);
	st->sample_rate = sample_rate;
	st->num_channels = num_channels;
	st->bit_depth = bit_depth;
		st->bytes_per_sample = (bit_depth * OUT_CHANNELS(num_channels)) >> 3;
	st->buffer_size = (buffer_size + 15) & ~15;
	st->num_buffers = num_buffers;
	st->client = ilclient_init();
	ilclient_set_empty_buffer_done_callback(st->client, input_buffer_callback, st);

	ret = ilclient_create_component(st->client, &st->audio_render, "audio_render", ILCLIENT_ENABLE_INPUT_BUFFERS | ILCLIENT_DISABLE_ALL_PORTS);
	if (ret == -1)
		return -1;
st->handle = ILC_GET_HANDLE(st->audio_render);


	st->list[0] = st->audio_render;

	// set up the number/size of buffers
	memset(&param, 0, sizeof(OMX_PARAM_PORTDEFINITIONTYPE));
	param.nSize = sizeof(OMX_PARAM_PORTDEFINITIONTYPE);
	param.nVersion.nVersion = OMX_VERSION;
	param.nPortIndex = 100;
	omx_err = OMX_GetParameter(ILC_GET_HANDLE(st->audio_render), OMX_IndexParamPortDefinition, &param);
	if (omx_err != OMX_ErrorNone)
		return -1;

	param.nBufferSize = max(st->buffer_size, param.nBufferSize);
	param.nBufferCountActual = max(st->buffer_count, param.nBufferCountMin);

	omx_err = OMX_SetParameter(ILC_GET_HANDLE(st->audio_render), OMX_IndexParamPortDefinition, &param);
	if (omx_err != OMX_ErrorNone)
		return -1;

	// set the pcm parameters
	memset(&pcm, 0, sizeof(OMX_AUDIO_PARAM_PCMMODETYPE));
	pcm.nSize = sizeof(OMX_AUDIO_PARAM_PCMMODETYPE);
	pcm.nVersion.nVersion = OMX_VERSION;
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
	if (omx_err != OMX_ErrorNone)
		return -1;

	ret = ilclient_change_component_state(st->audio_render, OMX_StateIdle);
	if (ret < 0) {
		printf("Failed to set OMX_StateIdle\n");
		return -1;
	}

	ret = ilclient_enable_port_buffers(st->audio_render, 100, NULL, NULL, NULL);
	if (ret < 0) {
		// error
		printf("Failed to enable port\n");
		ilclient_change_component_state(st->audio_render, OMX_StateLoaded);
		ilclient_cleanup_components(st->list);
		omx_err = OMX_Deinit();
		ilclient_destroy(st->client);
		sem_destroy(&st->sema);
		free(st);
		*component = NULL;
		return -1;
	}

	return ilclient_change_component_state(st->audio_render, OMX_StateExecuting);

} // end pcmrender_create


int32_t pcmrender_delete(PCMRENDER_STATE_T *st) {
	int32_t ret;
	OMX_ERRORTYPE omx_err;

	ret = ilclient_change_component_state(st->audio_render, OMX_StateIdle);
	if (ret < 0)
		return -1;

	omx_err = OMX_SendCommand(ILC_GET_HANDLE(st->audio_render), OMX_CommandStateSet, OMX_StateLoaded, NULL);
	if (omx_err != OMX_ErrorNone)
		return -1;

	ilclient_disable_port_buffers(st->audio_render, 100, st->user_buffer_list, NULL, NULL);
	ret = ilclient_change_component_state(st->audio_render, OMX_StateLoaded);
	ilclient_cleanup_components(st->list);

	omx_err = OMX_Deinit();
	if (omx_err != OMX_ErrorNone)
		return -1;

	ilclient_destroy(st->client);
	sem_destroy(&st->sema);
	free(st);
	return 0;
} // end pcmrender_delete

/*
OMX_ERRORTYPE omx_initialize() {
	return OMX_Init();
} // end omx_initialize;
*/


uint8_t *pcmrender_get_buffer(PCMRENDER_STATE_T *st) {
	OMX_BUFFERHEADERTYPE *hdr = NULL;

	hdr = ilclient_get_input_buffer(st->audio_render, 100, 0);

	if(hdr) {
		// put on the user list
		sem_wait(&st->sema);
		hdr->pAppPrivate = st->user_buffer_list;
		st->user_buffer_list = hdr;
		sem_post(&st->sema);
	}

	return hdr ? hdr->pBuffer : NULL;
} // end pcmrender_get_buffer


int32_t pcmrender_play_buffer(PCMRENDER_STATE_T *st, uint8_t *buffer, uint32_t length) {
	OMX_BUFFERHEADERTYPE *hdr = NULL, *prev = NULL;
	int32_t ret = -1;

	if(length % st->bytes_per_sample)
		return -1;

	sem_wait(&st->sema);

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

	sem_post(&st->sema);

	if(hdr) {
		OMX_ERRORTYPE omx_err;
		hdr->pAppPrivate = NULL;
		hdr->nOffset = 0;
		hdr->nFilledLen = length;
		omx_err = OMX_EmptyThisBuffer(ILC_GET_HANDLE(st->audio_render), hdr);
				if (omx_err != OMX_ErrorNone)
							return -1;
	}
	return ret;
} // end pcmrender_play_buffer


int32_t pcmrender_set_dest(PCMRENDER_STATE_T *st, const char *name) {
	int32_t ret = -1;
	OMX_CONFIG_BRCMAUDIODESTINATIONTYPE dest;

	if (name && strlen(name) < sizeof(dest.sName)) {
		OMX_ERRORTYPE omx_err;
		OMX_INIT_STRUCTURE(dest);
		strcpy((char *)dest.sName, name);

		 omx_err = OMX_SetConfig(ILC_GET_HANDLE(st->audio_render), OMX_IndexConfigBrcmAudioDestination, &dest);
		 	if (omx_err != OMX_ErrorNone)
				return ret;

		ret = 0;
	}

	return ret;
} // end pcmrender_play_buffer



uint32_t pcmrender_get_latency(PCMRENDER_STATE_T *st) {
	OMX_PARAM_U32TYPE param;
	OMX_ERRORTYPE omx_err;

	memset(&param, 0, sizeof(OMX_PARAM_U32TYPE));
	param.nSize = sizeof(OMX_PARAM_U32TYPE);
	param.nVersion.nVersion = OMX_VERSION;
	param.nPortIndex = 100;

	omx_err = OMX_GetConfig(ILC_GET_HANDLE(st->audio_render), OMX_IndexConfigAudioRenderingLatency, &param);
		if (omx_err != OMX_ErrorNone)
				return -1;

	return param.nU32;
} // end pcmrender_get_latency



int32_t pcmrender_get_state(PCMRENDER_STATE_T *st, OMX_STATETYPE *state) {
	OMX_ERRORTYPE omx_err = OMX_GetState(st->handle, state);
		return (omx_err == OMX_ErrorNone ? 0 : -1);
		} // end pcmrender_get_state
		 

		
	
