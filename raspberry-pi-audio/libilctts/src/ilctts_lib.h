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
#include "ringbuffer.h"


typedef int int32_t;

typedef enum {
	TTS_INIT,
	TTS_IDLE,
	TTS_BEFORE_SYNTH,
	TTS_BEFORE_PLAY,
	TTS_SPEAKING,
	TTS_STOP_REQUESTED
} TTS_STATE_T;


typedef enum {
	TTS_PAUSE_OFF,
	TTS_PAUSE_REQUESTED,
	TTS_PAUSE_MARK_REPORTED
} TTS_PAUSE_STATE_T;
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
   	pthread_mutex_t free_buffer_mutex;			// mutex set in buffer callback
	pthread_cond_t	free_buffer_cv;				// free buffer condition
	pthread_mutex_t ringbuffer_mutex;			// ringbuffer protection mutex
	pthread_cond_t ringbuffer_cv;				// ringbuffer condition
	//pthread_t playback_queue_mutex;			// only needed in the speech-dispatcher module
	//pthread_cond_t	playback_queue_cv;		// as above
	//pthread_mutex_t	playback_thread_mutex;		// possibly needed in sd module?
	//pthread_cond_t	playback_thread_cv;		// as above
	//pthread_mutex_t espeak_state_mutex;			// possibly only needed in sd module
	sem_t buffer_list_sema;					// used during buffer setup
	TTS_STATE_T tts_state;
	TTS_PAUSE_STATE_T tts_pause_state;
	//sem_t	playback_queue_sema;				// possibly only needed in sd module
	//sem_t	playback_thread_sema;				// as above
	//QUEUE_T playback_queue;				// as above
	//uint32_t playback_queue_size;				// as above
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
	uint32_t buffer_size,
	uint32_t ringbuffer_length
	);

int32_t ilctts_delete(TTSRENDER_STATE_T *st);
uint8_t *ilctts_get_buffer(TTSRENDER_STATE_T *st);
int32_t ilctts_play_audio(TTSRENDER_STATE_T *st, uint8_t *buffer, uint32_t length);
uint32_t ilctts_get_latency(TTSRENDER_STATE_T *st);
int32_t ilctts_set_dest(TTSRENDER_STATE_T *st, const char *name);
int32_t ilctts_get_state(TTSRENDER_STATE_T *st, OMX_STATETYPE *state);
int32_t ilctts_set_volume(TTSRENDER_STATE_T *st, unsigned int vol);
int32_t ilctts_pause(TTSRENDER_STATE_T *st);
int32_t ilctts_resume(TTSRENDER_STATE_T *st);
int32_t ilctts_start_ringbuffer_consumer_thread(TTSRENDER_STATE_T *st);
void ilctts_stop_ringbuffer_consumer_thread(TTSRENDER_STATE_T *st);


#endif


