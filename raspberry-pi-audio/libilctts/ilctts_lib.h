#ifndef ILCTTS_LIB_H
#define ILCTTS_LIB_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>

#include "bcm_host.h"
#include "ilclient.h"


typedef int int32_t;

typedef struct {
   sem_t sema;
   ILCLIENT_T *client;
   COMPONENT_T *audio_render;
   OMX_HANDLETYPE *handle;
   COMPONENT_T *list[2];
   OMX_BUFFERHEADERTYPE *user_buffer_list; // buffers owned by the client
   	uint32_t sample_rate;
   		uint32_t num_channels;
   			uint32_t bit_depth;
   uint32_t num_buffers;
   	uint32_t buffer_size;
   		uint32_t buffer_count;
   uint32_t bytes_per_sample;
} PCMRENDER_STATE_T;


int32_t ilctts_create(
	PCMRENDER_STATE_T **component,
	uint32_t sample_rate,
	uint32_t num_channels,
	uint32_t bit_depth,
	uint32_t num_buffers,
	uint32_t buffer_size
	);

int32_t ilctts_delete(PCMRENDER_STATE_T *st);
uint8_t *ilctts_get_buffer(PCMRENDER_STATE_T *st);
int32_t ilctts_play_buffer(PCMRENDER_STATE_T *st, uint8_t *buffer, uint32_t length);
uint32_t ilctts_get_latency(PCMRENDER_STATE_T *st);
int32_t ilctts_set_dest(PCMRENDER_STATE_T *st, const char *name);
int32_t ilctts_get_state(PCMRENDER_STATE_T *st, OMX_STATETYPE *state);
int32_t ilctts_set_volume(PCMRENDER_STATE_T *st, unsigned int vol);
int32_t ilctts_pause(PCMRENDER_STATE_T *st);
int32_t ilctts_resume(PCMRENDER_STATE_T *st);



#endif


