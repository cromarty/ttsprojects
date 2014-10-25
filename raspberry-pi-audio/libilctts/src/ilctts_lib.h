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
//#include "list.h"
//#include "queue.h"

//-- linked list types

// linked list entry
typedef struct LLIST_ENTRY_ {
void               *data;
struct LLIST_ENTRY_   *next;
} LLIST_ENTRY_T;

// linked list type
typedef struct LLIST_ {
int                size;
void               (*destroy)(void *data);
LLIST_ENTRY_T           *head;
LLIST_ENTRY_T           *tail;
} LLIST_T;


//-- queue type
typedef LLIST_T QUEUE_T;

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
   	pthread_mutex_t free_buffer_mutex;
	pthread_cond_t	free_buffer_cv;
	pthread_t playback_queue_mutex;
	pthread_cond_t	playback_queue_cv;
	pthread_mutex_t	playback_thread_mutex;
	pthread_cond_t	playback_thread_cv;
	pthread_mutex_t espeak_state_mutex;
	TTS_STATE_T tts_state;
	TTS_PAUSE_STATE_T tts_pause_state;
	sem_t buffer_list_sema;
	sem_t	playback_queue_sema;
	sem_t	playback_thread_sema;
	QUEUE_T playback_queue;  // queue of playback objects
	uint32_t playback_queue_size;  // number of samples currently in queue
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

//-- linked list function prototypes


void list_init(LLIST_T *list, void (*destroy)(void *data));
void list_destroy(LLIST_T *list);
int list_insert_next(LLIST_T *list, LLIST_ENTRY_T *element, const void *data);
int list_remove_next(LLIST_T *list, LLIST_ENTRY_T *element, void **data);

//-- linked list macros
#define list_size(list) ((list)->size)
#define list_head(list) ((list)->head)
#define list_tail(list) ((list)->tail)
#define list_is_head(list, element) ((element) == (list)->head ? 1 : 0)
#define list_is_tail(element) ((element)->next == NULL ? 1 : 0)
#define list_is_empty(list) ((list)->size == 0 ? 1 : 0)
#define list_data(element) ((element)->data)
#define list_next(element) ((element)->next)
#define list_append(list, data) (list_insert_next(list, ((list)->tail), data))

//-- queue function prototypes and macros

#define queue_init list_init
#define queue_destroy list_destroy

int queue_push(QUEUE_T *queue, const void *data);
int queue_pop(QUEUE_T *queue, void **data);

#define queue_peek(queue) ((queue)->head == NULL ? NULL : (queue)->head->data)
#define queue_is_empty(list) (list_is_empty(list))
#define queue_size list_size

//-- end of queue function prototypes and macros



#endif


