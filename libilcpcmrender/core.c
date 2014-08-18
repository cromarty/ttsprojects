#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>

#include "bcm_host.h"
#include "ilclient.h"


#define OUT_CHANNELS(num_channels) ((num_channels) > 4 ? 8: (num_channels) > 2 ? 4: (num_channels))

#ifndef countof
   #define countof(arr) (sizeof(arr) / sizeof(arr[0]))
#endif

#define BUFFER_SIZE_SAMPLES 1024

typedef int int32_t;

typedef struct {
   sem_t sema;
   ILCLIENT_T *client;
   COMPONENT_T *audio_render;
   COMPONENT_T *list[2];
   OMX_BUFFERHEADERTYPE *user_buffer_list; // buffers owned by the client
   uint32_t num_buffers;
   uint32_t bytes_per_sample;
} PCMRENDER_STATE_T;

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
	uint32_t bytes_per_sample = (bit_depth * OUT_CHANNELS(num_channels)) >> 3;

	*component = NULL;
/*******
	if (sample_rate < 11025)
		sample_rate = 11025;
	else
		if (sample_rate < 22050)
			sample_rate = 22050;
		else
			sample_rate = 44100;

	if ((num_channels != 1) && (num_channels != 2))
		return -1;

	if ((bit_depth != 16) && (bit_depth != 32))
		return -1;
******/
	int size = (buffer_size + 15) & ~15;
	st = calloc(1, sizeof(PCMRENDER_STATE_T));
	OMX_PARAM_PORTDEFINITIONTYPE port_param;
	OMX_AUDIO_PARAM_PCMMODETYPE pcm;
	int32_t s;

	*component = st;

	// create and start up everything
	s = sem_init(&st->sema, 0, 1);
	st->bytes_per_sample = bytes_per_sample;
	st->num_buffers = num_buffers;
	st->client = ilclient_init();
	ilclient_set_empty_buffer_done_callback(st->client, input_buffer_callback, st);

	ret = ilclient_create_component(st->client, &st->audio_render, "audio_render", ILCLIENT_ENABLE_INPUT_BUFFERS | ILCLIENT_DISABLE_ALL_PORTS);
	if (ret == -1)
		return -1;
/******
	st->list[0] = st->audio_render;

	// set up the number/size of buffers
	memset(&port_param, 0, sizeof(OMX_PARAM_PORTDEFINITIONTYPE));
	port_param.nSize = sizeof(OMX_PARAM_PORTDEFINITIONTYPE);
	port_param.nVersion.nVersion = OMX_VERSION;
	port_param.nPortIndex = 100;
	omx_err = OMX_GetParameter(ILC_GET_HANDLE(st->audio_render), OMX_IndexParamPortDefinition, &port_param);
	if (omx_err != OMX_ErrorNone)
		return -1;

	port_param.nBufferSize = size;
	port_param.nBufferCountActual = num_buffers;
	omx_err = OMX_SetParameter(ILC_GET_HANDLE(st->audio_render), OMX_IndexParamPortDefinition, &port_param);
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

	switch(num_channels) {
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
	if (ret < 0)
		return -1;

	ret = ilclient_enable_port_buffers(st->audio_render, 100, NULL, NULL, NULL);
	if (ret < 0) {
		// error
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
******/
return 0;

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


OMX_ERRORTYPE omx_initialize() {
	return OMX_Init();
} // end omx_initialize;


int main() {
	OMX_ERRORTYPE omx_err;
	PCMRENDER_STATE_T *st;

	omx_err = omx_initialize();
	if (omx_err != OMX_ErrorNone)
		return 1;

	omx_err = pcmrender_create(&st, 22050, 1, 16, 5, 2048);
	if (omx_err != OMX_ErrorNone)
		return 1;

	omx_err = pcmrender_delete(st);
	if (omx_err != OMX_ErrorNone)
		return 1;

	return 0;

} // end main


