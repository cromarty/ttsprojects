#ifndef ILCPCMRENDER_H
#define ILCPCMRENDER_H

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


int32_t pcmrender_create(
	PCMRENDER_STATE_T **component,
	uint32_t sample_rate,
	uint32_t num_channels,
	uint32_t bit_depth,
	uint32_t num_buffers,
	uint32_t buffer_size
	);

int32_t pcmrender_delete(PCMRENDER_STATE_T *st);
uint8_t *pcmrender_get_buffer(PCMRENDER_STATE_T *st);
int32_t pcmrender_play_buffer(PCMRENDER_STATE_T *st, uint8_t *buffer, uint32_t length);
uint32_t pcmrender_get_latency(PCMRENDER_STATE_T *st);


#endif


