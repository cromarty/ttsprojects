#ifndef ESPEAK_H
#define ESPEK_H
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>
#include <espeak/speak_lib.h>

//#include "ringbuffer.h"
#include "ilctts_lib.h"
#include "list.h"
#include "queue.h"


static int ilctts_espeak_synth_callback(short *wav, int numsamples, espeak_EVENT * events);
static ILCTTS_BOOLEAN_T playback_queue_add_audio(TTSRENDER_STATE_T *st, short *audio_chunk, int num_samples);
static ILCTTS_BOOLEAN_T playback_queue_add_flag(TTSRENDER_STATE_T *st, PLAYBACK_QUEUE_ENTRY_TYPE_T type);
static ILCTTS_BOOLEAN_T playback_queue_add_mark(TTSRENDER_STATE_T *st, const char *mark_id);
static ILCTTS_BOOLEAN_T playback_queue_add_sound_icon(TTSRENDER_STATE_T *st, const char *filename);
static void delete_playback_queue_entry(TTSRENDER_STATE_T *st);
static void clear_playback_queue(TTSRENDER_STATE_T *st, );


#endif

