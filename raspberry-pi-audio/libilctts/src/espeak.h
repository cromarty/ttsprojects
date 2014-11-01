/*
*
* <file> - <description>
*
* <short_description>
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
#ifndef ESPEAK_H
#define ESPEAK_H
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>
#include <espeak/speak_lib.h>

#include "list.h"
#include "queue.h"
#include "ilctts_lib.h"
#include "ilctts_types.h"

#define CLAMP(x, low, high)  (((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))

typedef enum {
	ESPEAK_FATAL_ERROR = -1,
	ESPEAK_OK = 0,
	ESPEAK_ERROR = 1
} ESPEAK_ERROR_T;

// Playback queue entry types

// PLAYBACK_QUEUE_ENTRY_T
typedef enum {
	QET_AUDIO,	// Chunk of audio.
	QET_INDEX_MARK,	// Index mark event.
	QET_SOUND_ICON,	// A Sound Icon
	QET_BEGIN,	// Beginning of speech
	QET_END		// Speech completed
} PLAYBACK_QUEUE_ENTRY_TYPE_T;


// Chunk of audio data
typedef struct {
	long num_samples;
	short *audio_chunk;
} PLAYBACK_QUEUE_AUDIO_CHUNK_T;

// Playback queue entry type

typedef struct {
	PLAYBACK_QUEUE_ENTRY_TYPE_T type;
	union {
		char *markId;
		PLAYBACK_QUEUE_AUDIO_CHUNK_T audio;
		char *sound_icon_filename;
	} data;
} PLAYBACK_QUEUE_ENTRY_T;

//-- function prototypes

int ilctts_espeak_init(TTSRENDER_STATE_T *st);
int ilctts_synth_callback(short *wav, int numsamples, espeak_EVENT *events);
/*
int ilctts_uri_callback(int type, const char *uri, const char *base);
*/
void ilctts_set_callbacks(TTSRENDER_STATE_T *st);

//-- static functions

static int espeak_add_audio_to_playback_queue(TTSRENDER_STATE_T *st, short *audio_chunk, int num_samples);
static int espeak_add_flag_to_playback_queue(TTSRENDER_STATE_T *st, PLAYBACK_QUEUE_ENTRY_T type);
static int espeak_add_mark_to_playback_queue(TTSRENDER_STATE_T *st, const char *markId);
static int espeak_add_sound_icon_to_playback_queue(TTSRENDER_STATE_T *st, const char *filename);
static void espeak_clear_playback_queue(TTSRENDER_STATE_T *st);
static void espeak_delete_playback_queue_entry(TTSRENDER_STATE_T *st, PLAYBACK_QUEUE_ENTRY_T *playback_queue_entry);
static int espeak_send_audio_upto(TTSRENDER_STATE_T *st, short *wav, int *sent, int upto);
static int espeak_send_to_audio(TTSRENDER_STATE_T *st, PLAYBACK_QUEUE_ENTRY_T *playback_queue_entry);
static void espeak_set_cap_let_recogn(TTSRENDER_STATE_T *st, ILCTTS_CAPITAL_LETTERS cap_mode);
static void espeak_set_language(TTSRENDER_STATE_T *st, char *lang);
static void espeak_set_language_and_voice(TTSRENDER_STATE_T *st, char *lang, SPDVoiceType voice_code);
static void espeak_set_pitch(TTSRENDER_STATE_T *st, signed int pitch);
static int espeak_set_punctuation_list_from_utf8(const char *punct);
static void espeak_set_punctuation_mode(TTSRENDER_STATE_T *st, SPDPunctuation punct_mode);
static void espeak_set_rate(TTSRENDER_STATE_T *st, signed int rate);
static void espeak_set_synthesis_voice(TTSRENDER_STATE_T *st, char *synthesis_voice);
static void espeak_set_volume(TTSRENDER_STATE_T *st, signed int volume);
static void espeak_state_reset(TTSRENDER_STATE_T *st);
static int is_thread_busy(TTSRENDER_STATE_T *st, pthread_mutex_t *suspended_mutex);
static TPlaybackQueueEntry *playback_queue_pop();
static gboolean playback_queue_push(TPlaybackQueueEntry * entry);
static void set_speaking_thread_parameters();

static void *_espeak_play(void *param);
static void *_espeak_stop_or_pause(void *param);


#endif

