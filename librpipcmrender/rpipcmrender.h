#ifndef LIBRPIPCMRENDER_H
#define LIBRPI_PCMRENDER_H
#include <stdlib.h>
#include <IL/OMX_Component.h>
#include <IL/OMX_Audio.h>
#include <IL/OMX_Broadcom.h>

#include "list.h"
#include "queue.h"

typedef struct {
	OMX_HANDLETYPE handle;
	OMX_U32 port;
	OMX_U32 alignment;
	OMX_U32 buffer_count;
	OMX_U32 buffer_size;
	OMX_CALLBACKTYPE callbacks;
	LLIST_T buffer_list;
	QUEUE_T event_queue;
	pthread_mutex_t comp_mutex;
	pthread_mutex_t event_queue_mutex;
} OMX_COMPONENT_T;


struct OMX_EVENT_T {
	OMX_EVENTTYPE event;
	OMX_U32 data1;
	OMX_U32 data2;
	OMX_PTR event_data;
};



OMX_ERRORTYPE omx_enable_port(OMX_COMPONENT_T *component, uint64_t wait);
OMX_ERRORTYPE omx_disable_port(OMX_COMPONENT_T *component, uint64_t wait);
OMX_STATETYPE omx_get_state(OMX_COMPONENT_T *component);
OMX_ERRORTYPE omx_set_state(OMX_COMPONENT_T *component, OMX_STATETYPE state, uint64_t timeout);
OMX_ERRORTYPE omx_alloc_buffers(OMX_COMPONENT_T *component);
OMX_ERRORTYPE omx_free_buffers(OMX_COMPONENT_T *component);
OMX_ERRORTYPE omx_set_pcm_parameters(OMX_COMPONENT_T *component, int samplerate, int channels, int bitdepth, char *dest);
OMX_ERRORTYPE omx_set_volume(OMX_COMPONENT_T *component, unsigned int vol);
OMX_ERRORTYPE omx_init_audio_render_component(OMX_COMPONENT_T *component, char *compname);

#endif

