/*
*
* pipcmrender_lib.h - Main public header file for the core functionality of the library
*
* Contains function prototypes and type definitions for the main code.
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
#ifndef PIPCMRENDER_LIB_H
#define PIPCMRENDER_LIB_H
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

#include "bcm_host.h"
#include "ilclient.h"

typedef int int32_t;



typedef enum {
	BS_MILLISECONDS,
	BS_BYTES
} BUFFER_SIZE_TYPE_T;

/*
typedef enum {
	TTS_INIT,
	TTS_IDLE,
	TTS_BEFORE_SYNTH,
	TTS_BEFORE_PLAY,
	TTS_SPEAKING,
	TTS_STOP
} TTS_STATE_T;
*/

typedef enum {
	TTS_PAUSE_OFF,
	TTS_PAUSE_REQUESTED,
	TTS_PAUSE_MARK_REPORTED
} TTS_PAUSE_STATE_T;

// PCMRENDER_STATE_T
typedef struct {
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
	int64_t	position_in_message;
// mutexes and semaphores
	pthread_mutex_t free_buffer_mutex;
	pthread_cond_t free_buffer_cv;
	sem_t buffer_list_sema;					// used during buffer setup
// state variables
	uint32_t tts_stop;
	TTS_PAUSE_STATE_T tts_pause_state;
} PCMRENDER_STATE_T;

int32_t pipcmrender_initialize();
int32_t pipcmrender_finalize();

int32_t pipcmrender_create(
	PCMRENDER_STATE_T **component,
	uint32_t sample_rate,
	uint32_t num_channels,
	uint32_t bit_depth,
	uint32_t num_buffers,
	uint32_t buffer_size_ms,
	BUFFER_SIZE_TYPE_T buffer_size_type
	);

int32_t pipcmrender_delete(PCMRENDER_STATE_T *st);
uint8_t *pipcmrender_get_buffer(PCMRENDER_STATE_T *st);
int32_t pipcmrender_send_audio(PCMRENDER_STATE_T *st, uint8_t *buffer, uint32_t length);
uint32_t pipcmrender_get_latency(PCMRENDER_STATE_T *st);
int32_t pipcmrender_set_dest(PCMRENDER_STATE_T *st, const char *name);
int32_t pipcmrender_get_state(PCMRENDER_STATE_T *st, OMX_STATETYPE *state);
int32_t pipcmrender_set_volume(PCMRENDER_STATE_T *st, unsigned int vol);
int32_t pipcmrender_pause(PCMRENDER_STATE_T *st);
int32_t pipcmrender_resume(PCMRENDER_STATE_T *st);
void pipcmrender_stop_request(PCMRENDER_STATE_T *st);
int32_t pipcmrender_flush(PCMRENDER_STATE_T *st);
int pipcmrender_pcm_write(PCMRENDER_STATE_T *st, void *data, int length);
int pipcmrender_pcm_read(PCMRENDER_STATE_T *st, void *data, int length);
void pipcmrender_latency_wait(PCMRENDER_STATE_T *st);

#endif


