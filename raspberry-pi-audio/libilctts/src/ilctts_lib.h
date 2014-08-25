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
#include "list.h"
#include "queue.h"


typedef int int32_t;

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
   	pthread_mutex_t free_buffer_mutex;
	pthread_cond_t	free_buffer_cv;
	pthread_t pbq_mutex;
	pthread_cond_t	pbq_cv;
	pthread_mutex_t	playback_thread_mutex;
	pthread_cond_t	playback_thread_cv;
	pthread_mutex_t espeak_state_mutex;
	uint32_t espeak_state;
	uint32_t stop_requested;
	sem_t buffer_list_sema;
	sem_t	pbq_sema;
	sem_t	playback_thread_sema;
	QUEUE_T pbq;  // queue of playback objects
	uint32_t pbq_size;  // number of samples currently in queue
} TTSRENDER_STATE_T;

int32_t ilctts_initialize();
int32_t ilctts_finalize();

int32_t ilctts_create(
	TTSRENDER_STATE_T **component,
	uint32_t sample_rate,
	uint32_t num_channels,
	uint32_t bit_depth,
	uint32_t num_buffers,
	uint32_t buffer_size
	);

int32_t ilctts_delete(TTSRENDER_STATE_T *st);
uint8_t *ilctts_get_buffer(TTSRENDER_STATE_T *st);
int32_t ilctts_play_buffer(TTSRENDER_STATE_T *st, uint8_t *buffer, uint32_t length);
uint32_t ilctts_get_latency(TTSRENDER_STATE_T *st);
int32_t ilctts_set_dest(TTSRENDER_STATE_T *st, const char *name);
int32_t ilctts_get_state(TTSRENDER_STATE_T *st, OMX_STATETYPE *state);
int32_t ilctts_set_volume(TTSRENDER_STATE_T *st, unsigned int vol);
int32_t ilctts_pause(TTSRENDER_STATE_T *st);
int32_t ilctts_resume(TTSRENDER_STATE_T *st);



#endif


