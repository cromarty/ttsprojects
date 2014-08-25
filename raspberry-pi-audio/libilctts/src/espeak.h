#ifndef ESPEAK_H
#define ESPEK_H
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>
#include <espeak/speak_lib.h>

#include "ilctts_lib.h"
#include "list.h"
#include "queue.h"


typedef enum {
	ESPEAK_FATAL_ERROR = -1,
	ESPEAK_OK = 0,
	ESPEAK_ERROR = 1
} ESPEAK_SUCCESS_T;

typedef enum {
	ESPEAK_IDLE,
	ESPEAK_BEFORE_SYNTH,
	ESPEAK_BEFORE_PLAY,
	ESPEAK_SPEAKING
} ESPEAK_STATE_T;

typedef enum {
	ESPEAK_PAUSE_OFF,
	ESPEAK_PAUSE_REQUESTED,
	ESPEAK_PAUSE_MARK_REPORTED
} ESPEAK_PAUSED_STATE_T;

typedef enum {
	ESPEAK_QET_AUDIO,	/* Chunk of audio. */
	ESPEAK_QET_INDEX_MARK,	/* Index mark event. */
	ESPEAK_QET_SOUND_ICON,	/* A Sound Icon */
	ESPEAK_QET_BEGIN,	/* Beginning of speech. */
	ESPEAK_QET_END		/* Speech completed. */
} ESPEAK_PLAYBACK_QUEUE_ENTY_TYPE_T;


typedef struct {
	long num_samples;
	short *audio_chunk;
} ESPEAK_PLAYBACK_QUEUE_AUDIO_CHUNK_T;


typedef struct {
	ESPEAK_PLAYBACK_QUEUE_ENTRY_TYPE_T type;
	union {
		char *markId;
		ESPEAK_PLAYBACK_QUEUE_AUDIO_CHUNK_T audio;
		char *sound_icon_filename;
	} data;
} ESPEAK_PLAYBACK_QUEUE_ENTRY_T;


static int ilctts_espeak_synth_callback(short *wav, int numsamples, espeak_EVENT * events);
static uint32_t playback_queue_add_audio(TTSRENDER_STATE_T *st, short *audio_chunk, int num_samples);
static uint32_t playback_queue_add_flag(TTSRENDER_STATE_T *st, PLAYBACK_QUEUE_ENTRY_TYPE_T type);
static uint32_t playback_queue_add_mark(TTSRENDER_STATE_T *st, const char *mark_id);
static uint32_t playback_queue_add_sound_icon(TTSRENDER_STATE_T *st, const char *filename);
static void delete_playback_queue_entry(TTSRENDER_STATE_T *st);
static void clear_playback_queue(TTSRENDER_STATE_T *st, );


#endif

