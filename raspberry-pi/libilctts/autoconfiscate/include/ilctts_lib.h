/*
*
* ilctts_lib.h - Main public header file for the core functionality of the library
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
#ifndef ILCTTS_LIB_H
#define ILCTTS_LIB_H
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

//-- linked list stuff

typedef struct LLIST_ENTRY_ {
void               *data;
struct LLIST_ENTRY_   *next;
} LLIST_ENTRY_T;

typedef struct LLIST_ {
int                size;
void               (*destroy)(void *data);
LLIST_ENTRY_T           *head;
LLIST_ENTRY_T           *tail;
} LLIST_T;

typedef LLIST_T QUEUE_T;

typedef struct {
    void *buffer;
    int length;
    int head;
    int tail;
} RINGBUFFER_T;


// TTSRENDER_STATE_T
typedef struct {
	ILCLIENT_T *client;
	COMPONENT_T *audio_render;
	COMPONENT_T *list[2];
	OMX_BUFFERHEADERTYPE *user_buffer_list; // buffers owned by the client
	uint32_t sample_rate;
	uint32_t num_channels;
	uint32_t bit_depth;
	uint32_t ringbuffer_size;
	uint32_t num_buffers;
	uint32_t buffer_size;
	uint32_t buffer_count;
	uint32_t bytes_per_sample;
	int64_t	position_in_message;
// mutexes and semaphores
	pthread_mutex_t ringbuffer_mutex;			// ringbuffer protection mutex
	pthread_mutex_t free_buffer_mutex;
	pthread_cond_t free_buffer_cv;
	sem_t ringbuffer_data_sema;				// there is data in the ringbuffer
	sem_t ringbuffer_empty_sema;				// there is space in the ringbuffer
	sem_t buffer_list_sema;					// used during buffer setup
// state variables
	uint32_t tts_stop;
	TTS_PAUSE_STATE_T tts_pause_state;
// ringbuffer (fifo) of pcm data
	RINGBUFFER_T *ringbuffer;
} TTSRENDER_STATE_T;

int32_t ilctts_initialize();
int32_t ilctts_finalize();

int32_t ilctts_create(
	TTSRENDER_STATE_T **component,
	uint32_t sample_rate,
	uint32_t num_channels,
	uint32_t bit_depth,
	uint32_t num_buffers,
	uint32_t buffer_size_ms,
	BUFFER_SIZE_TYPE_T buffer_size_type,
	uint32_t ringbuffer_length
	);

int32_t ilctts_delete(TTSRENDER_STATE_T *st);
uint8_t *ilctts_get_buffer(TTSRENDER_STATE_T *st);
int32_t ilctts_send_audio(TTSRENDER_STATE_T *st, uint8_t *buffer, uint32_t length);
uint32_t ilctts_get_latency(TTSRENDER_STATE_T *st);
int32_t ilctts_set_dest(TTSRENDER_STATE_T *st, const char *name);
int32_t ilctts_get_state(TTSRENDER_STATE_T *st, OMX_STATETYPE *state);
int32_t ilctts_set_volume(TTSRENDER_STATE_T *st, unsigned int vol);
int32_t ilctts_pause(TTSRENDER_STATE_T *st);
int32_t ilctts_resume(TTSRENDER_STATE_T *st);
int32_t ilctts_start_ringbuffer_consumer_thread(TTSRENDER_STATE_T *st);
void ilctts_stop_request(TTSRENDER_STATE_T *st);
int32_t ilctts_flush(TTSRENDER_STATE_T *st);
int ilctts_pcm_write(TTSRENDER_STATE_T *st, void *data, int length);
int ilctts_pcm_read(TTSRENDER_STATE_T *st, void *data, int length);

int ilctts_wait_space(TTSRENDER_STATE_T *st);
int ilctts_post_space(TTSRENDER_STATE_T *st);
int ilctts_wait_data(TTSRENDER_STATE_T *st);
int ilctts_post_data(TTSRENDER_STATE_T *st);
int ilctts_lock_ringbuffer(TTSRENDER_STATE_T *st);
int ilctts_unlock_ringbuffer(TTSRENDER_STATE_T *st);
void ilctts_latency_wait(TTSRENDER_STATE_T *st);

#endif


