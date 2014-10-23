/*
*
* <file> - <description>
*
* <short_description>
*
* Copyright (C) <years>, Mike Ray, <mike.ray@btinternet.com>
*
* This is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1, or (at your option) any later
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
* $Id: <author>
*
*--code--*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>
#include <espeak/speak_lib.h>
#include <espeak/speak_lib.h>

#include "list.h"
#include "queue.h"
#include "ilctts_lib.h"
#include "ilctts_types.h"
#include "espeak.h"

static TTSRENDER_STATE_T *g_st = NULL;

//-- functions

int ilctts_espeak_init(TTSRENDER_STATE_T *st) {
	int err;
	const char *espeak_version;
#ifndef _SD_MODULE_
	int EspeakAudioChunkSize =0;
#endif

	//DBG("Espeak: Module init().");

#ifdef _SD_MODULE_
	INIT_INDEX_MARKING();
	*status_info = NULL;
#endif

	// Report versions.
	espeak_version = espeak_Info(NULL);
	//DBG("Espeak: Initializing engine with buffer size %d ms.", EspeakAudioChunkSize);
#if ESPEAK_API_REVISION == 1
	espeak_sample_rate = espeak_Initialize(AUDIO_OUTPUT_RETRIEVAL, EspeakAudioChunkSize, NULL);
#else
	espeak_sample_rate = espeak_Initialize(AUDIO_OUTPUT_RETRIEVAL, EspeakAudioChunkSize, NULL, 0);
#endif

	if (espeak_sample_rate == EE_INTERNAL_ERROR) {
		//DBG("Espeak: Could not initialize engine."); 
#ifdef _SD_MODULE_ 
// *status_info = g_strdup("Could not initialize engine. "); 
#endif
		return ESPEAK_FATAL_ERROR;
	}

	//DBG("Espeak: Registering callbacks.");

	espeak_SetSynthCallback(ilctts_synth_callback);
	//espeak_SetUriCallback(uri_callback);
	//DBG("Setting up espeak specific configuration settings.");
	err = espeak_set_punctuation_list_from_utf8(EspeakPunctuationList);
	if (err != ESPEAK_OK) {
		//DBG("Espeak: Failed to set punctuation list.");
	}

	espeak_voice_list = espeak_list_synthesis_voices(st);

	// Reset global state
	espeak_state_reset(st);

	// Threading setup
	// These mutexes are locked when the corresponding threads are suspended.
	pthread_mutex_init(&st->espeak_stop_or_pause_suspended_mutex, NULL);
	pthread_mutex_init(&st->espeak_play_suspended_mutex, NULL);

	// This mutex mediates access to the playback queue between the espeak synthesis thread and the playback thread.
	pthread_mutex_init(&st->playback_queue_mutex, NULL);
	pthread_cond_init(&st->playback_queue_condition, NULL);

	// The following mutex protects access to various flags
	pthread_mutex_init(&st->tts_state_mutex, NULL);
	//DBG("Espeak: Creating new thread for stop or pause.");
	sem_init(&st->espeak_stop_or_pause_semaphore, 0, 0);
	err = pthread_create(&st->espeak_stop_or_pause_thread, NULL, _espeak_stop_or_pause, NULL);
	if (err != ESPEAK_OK) {
		DBG("Failed to create stop-or-pause thread.");
		*status_info = g_strdup("Failed to create stop-or-pause thread.");
		return ESPEAK_FATAL_ERROR;
	}
	sem_init(&st->espeak_play_semaphore, 0, 0);
	//DBG("Espeak: Creating new thread for playback.");
	err = pthread_create(&st->espeak_play_thread, NULL, _espeak_play, NULL);
	if (err != ESPEAK_OK) {
		DBG("Failed to create playback thread.");
		*status_info = g_strdup("Failed to create playback thread.");
		return ESPEAK_FATAL_ERROR;
	}

	*status_info = g_strdup("Espeak: Initialized successfully.");
	return ESPEAK_OK;
} // end ilctts_espeak_init



int ilctts_synth_callback(short *wav, int numsamples, espeak_EVENT * events) {
	static int numsamples_sent_msg = 0;
	int numsamples_sent = 0;

	// set espeak state mutex lock here

	// first time in for this message?
	if (g_st->tts_state == TTS_BEFORE_SYNTH) {
		numsamples_sent_msg = 0;
		g_st->tts_state = TTS_BEFORE_PLAY;
		// add begin flag to queue

		// wake playback thread here

	}
	// unlock the espeak state mutex here

	if (g_st->tts_state == TTS_STOP_REQUESTED)
		return 1;

	// process audio data and events
	while (events->type != espeakEVENT_LIST_TERMINATED) {

	} // end while (events->type != espeakEVENT_LIST_TERMINATED)

	// send audio up to here

	// increment the static number of samples in this message
	numsamples_sent_msg += numsamples;

	// return zero to indicate we still want more of this message
	return 0;
} // end ilctts_synth_callback








void ilctts_set_callbacks(TTSRENDER_STATE_T *st) {
	espeak_SetSynthCallback(ilctts_synth_callback);
	//espeak_SetUriCallback(ilctts_uri_callback);
	return;
} // end ilctts_set_callbacks


// Adds a chunk of pcm audio to the audio playback queue.
   // Waits until there is enough space in the queue.
static int espeak_add_audio_to_playback_queue(TTSRENDER_STATE_T *st, short *audio_chunk, int num_samples) {
	pthread_mutex_lock(&st->playback_queue_mutex);
	while (!st->tts_stop_requested && playback_queue_size > EspeakAudioQueueMaxSize) {
		pthread_cond_wait(&st->playback_queue_condition, &playback_queue_mutex);
	}
	pthread_mutex_unlock(&st->playback_queue_mutex);
	if (st->tts_stop_requested) {
		return FALSE;
	}

	PLAYBACK_QUEUE_ENTRY_T *playback_queue_entry = malloc(sizeof(PLAYBACK_QUEUE_ENTRY_T));
	memset(playback_queue_entry, 0, sizeof(PLAYBACK_QUEUE_ENTRY_T));
	playback_queue_entry->type = QET_AUDIO;
	playback_queue_entry->data.audio.num_samples = num_samples;
	int nbytes = sizeof(short) * num_samples;
	playback_queue_entry->data.audio.audio_chunk = (short *)g_memdup((gconstpointer) audio_chunk, nbytes);
	playback_queue_push(st, playback_queue_entry);
	return TRUE;
} // end espeak_add_audio_to_playback_queue




/* Adds a begin or end flag to the playback queue. */
static int espeak_add_flag_to_playback_queue(TTSRENDER_STATE_T *st, PLAYBACK_QUEUE_ENTRY_T type) {
	PLAYBACK_QUEUE_ENTRY_T *playback_queue_entry = (PLAYBACK_QUEUE_ENTRY_T*)malloc(sizeof(PLAYBACK_QUEUE_ENTRY_T));

	playback_queue_entry->type = type;
	return playback_queue_push(st, playback_queue_entry);
} // end espeak_add_flag_to_playback_queue



// Adds an Index Mark to the audio playback queue.
static int espeak_add_mark_to_playback_queue(TTSRENDER_STATE_T *st, const char *markId) {
	PLAYBACK_QUEUE_ENTRY_T *playback_queue_entry = (PLAYBACK_QUEUE_ENTRY_T*)malloc(sizeof(PLAYBACK_QUEUE_ENTRY_T));
	playback_queue_entry->type = QET_INDEX_MARK;
	playback_queue_entry->data.markId = g_strdup(markId);
	return playback_queue_push(st, playback_queue_entry);
} // end espeak_add_mark_to_playback_queue




// Add a sound icon to the playback queue.
static int espeak_add_sound_icon_to_playback_queue(TTSRENDER_STATE_T *st, const char *filename) {
	PLAYBACK_QUEUE_ENTRY_T *playback_queue_entry = (PLAYBACK_QUEUE_ENTRY_T*)malloc(sizeof(PLAYBACK_QUEUE_ENTRY_T));
	playback_queue_entry->type = QET_SOUND_ICON;
	playback_queue_entry->data.sound_icon_filename = g_strdup(filename);
	return playback_queue_push(st, playback_queue_entry);
} // end espeak_add_sound_icon_to_playback_queue




/* Erases the entire playback queue, freeing memory. */
static void espeak_clear_playback_queue(TTSRENDER_STATE_T *st) {
	pthread_mutex_lock(&st->playback_queue_mutex);

	while (NULL != st->playback_queue) {
		PLAYBACK_QUEUE_ENTRY_T *playback_queue_entry = playback_queue->data;
		espeak_delete_playback_queue_entry(playback_queue_entry);
		playback_queue = g_slist_remove(playback_queue, playback_queue->data);
	}
	playback_queue = NULL;
	playback_queue_size = 0;
	pthread_mutex_unlock(&st->playback_queue_mutex);
} // end espeak_clear_playback_queue




/* Deletes an entry from the playback audio queue, freeing memory. */
static void espeak_delete_playback_queue_entry(TTSRENDER_STATE_T *st, PLAYBACK_QUEUE_ENTRY_T *playback_queue_entry) {
	switch (playback_queue_entry->type) {
	case QET_AUDIO:
		g_free(playback_queue_entry->data.audio.audio_chunk);
		break;
	case QET_INDEX_MARK:
		g_free(playback_queue_entry->data.markId);
		break;
	case QET_SOUND_ICON:
		g_free(playback_queue_entry->data.sound_icon_filename);
		break;
	default:
		break;
	}
	g_free(playback_queue_entry);
} // end espeak_delete_playback_queue_entry



static int espeak_send_audio_upto(TTSRENDER_STATE_T *st, short *wav, int *sent, int upto) {
	assert(*sent >= 0);
	assert(upto >= 0);
	int numsamples = upto - (*sent);
	if (wav == NULL || numsamples == 0) {
		return TRUE;
	}
	short *start = wav + (*sent);
	int result = espeak_add_audio_to_playback_queue(st, start, numsamples);
	*sent = upto;
	return result;
} // end espeak_send_audio_upto




/* Sends a chunk of audio to the audio player and waits for completion or error. */
static int espeak_send_to_audio(TTSRENDER_STATE_T *st, TPlaybackQueueEntry * playback_queue_entry) {
	int ret = 0;
	AudioTrack track;
	track.num_samples = playback_queue_entry->data.audio.num_samples;
	track.num_channels = 1;
	track.sample_rate = espeak_sample_rate;
	track.bits = 16;
	track.samples = playback_queue_entry->data.audio.audio_chunk;

	DBG("Espeak: Sending %i samples to audio.", track.num_samples);
	ret = module_tts_output(track, SPD_AUDIO_LE);
	if (ret < 0) {
		DBG("ERROR: Can't play track for unknown reason.");
		return FALSE;
	}
	DBG("Espeak: Sent to audio.");
	return TRUE;
} // end espeak_send_to_audio



static void espeak_set_cap_let_recogn(TTSRENDER_STATE_T *st, ILCTTS_CAPITAL_LETTERS cap_mode) {
	int espeak_cap_mode = 0;
	switch (cap_mode) {
	case SPD_CAP_NONE:
		espeak_cap_mode = EspeakCapitalPitchRise;
		break;
	case SPD_CAP_SPELL:
		espeak_cap_mode = 2;
		break;
	case SPD_CAP_ICON:
		espeak_cap_mode = 1;
		break;
	}

	espeak_ERROR ret = espeak_SetParameter(espeakCAPITALS, espeak_cap_mode, 1);
	if (ret != EE_OK) {
		DBG("Espeak: Failed to set capitals mode.");
	} else {
		DBG("Set capitals mode.");
	}
} // end espeak_set_cap_let_recogn



static void espeak_set_language(TTSRENDER_STATE_T *st, char *lang) {
	espeak_set_language_and_voice(lang, msg_settings.voice_type);
} // end espeak_set_language




/* Given a language code and SD voice code, sets the espeak voice. */
static void espeak_set_language_and_voice(TTSRENDER_STATE_T *st, char *lang, SPDVoiceType voice_code) {
	DBG("Espeak: set_language_and_voice %s %d", lang, voice_code);
	espeak_ERROR ret;

	unsigned char overlay = 0;
	switch (voice_code) {
	case SPD_MALE1:
		overlay = 0;
		break;
	case SPD_MALE2:
		overlay = 1;
		break;
	case SPD_MALE3:
		overlay = 2;
		break;
	case SPD_FEMALE1:
		overlay = 11;
		break;
	case SPD_FEMALE2:
		overlay = 12;
		break;
	case SPD_FEMALE3:
		overlay = 13;
		break;
	case SPD_CHILD_MALE:
		overlay = 4;
		break;
	case SPD_CHILD_FEMALE:
		overlay = 14;
		break;
	default:
		overlay = 0;
		break;
	}

	char *name = g_strdup_printf("%s+%d", lang, overlay);
	DBG("Espeak: set_language_and_voice name=%s", name);
	ret = espeak_SetVoiceByName(name);
	if (ret != EE_OK) {
		DBG("Espeak: Error selecting language %s", name);
	} else {
		DBG("Espeak: Successfully set voice to \"%s\"", name);
	}
	g_free(name);
} // end espeak_set_language_and_voice




static void espeak_set_pitch(TTSRENDER_STATE_T *st, signed int pitch) {
	assert(pitch >= -100 && pitch <= +100);
	int pitchBaseline;
	// Possible range 0 to 100.
	if (pitch < 0) {
		pitchBaseline = ((float)(pitch + 100) * espeak_voice_pitch_baseline) / (float)100;
	} else {
		pitchBaseline = (((float)pitch * (100 - espeak_voice_pitch_baseline)) / (float)100) + espeak_voice_pitch_baseline;
	}
	assert(pitchBaseline >= 0 && pitchBaseline <= 100);
	espeak_ERROR ret = espeak_SetParameter(espeakPITCH, pitchBaseline, 0);
	if (ret != EE_OK) {
		DBG("Espeak: Error setting pitch %i.", pitchBaseline);
	} else {
		DBG("Espeak: Pitch set to %i.", pitchBaseline);
	}
} // end espeak_set_pitch





static int espeak_set_punctuation_list_from_utf8(const char *punct) {
	ESPEAK_ERROR_T result = ESPEAK_ERROR;
	wchar_t *wc_punct = (wchar_t *) g_convert(punct, -1, "wchar_t", "utf-8", NULL, NULL, NULL);
	if (wc_punct != NULL) {
		espeak_ERROR err = espeak_SetPunctuationList(wc_punct);
		if (err == EE_OK)
			result = ESPEAK_OK;
		free(wc_punct);
	}
	return result;
} // end espeak_set_punctuation_list_from_utf8




static void espeak_set_punctuation_mode(TTSRENDER_STATE_T *st, SPDPunctuation punct_mode) {
	espeak_PUNCT_TYPE espeak_punct_mode = espeakPUNCT_SOME;
	switch (punct_mode) {
	case SPD_PUNCT_ALL:
		espeak_punct_mode = espeakPUNCT_ALL;
		break;
	case SPD_PUNCT_SOME:
		espeak_punct_mode = espeakPUNCT_SOME;
		break;
	case SPD_PUNCT_NONE:
		espeak_punct_mode = espeakPUNCT_NONE;
		break;
	}

	espeak_ERROR ret = espeak_SetParameter(espeakPUNCTUATION, espeak_punct_mode, 0);
	if (ret != EE_OK) {
		DBG("Espeak: Failed to set punctuation mode.");
	} else {
		DBG("Set punctuation mode.");
	}
} // end espeak_set_punctuation_mode



static void espeak_set_rate(TTSRENDER_STATE_T *st, signed int rate) {
	assert(rate >= -100 && rate <= +100);
	int speed;
	int normal_rate = EspeakNormalRate, max_rate = EspeakMaxRate, min_rate = EspeakMinRate;

	if (rate < 0)
		speed = normal_rate + (normal_rate - min_rate) * rate / 100;
	else
		speed = normal_rate + (max_rate - normal_rate) * rate / 100;

	espeak_ERROR ret = espeak_SetParameter(espeakRATE, speed, 0);
	if (ret != EE_OK) {
		DBG("Espeak: Error setting rate %i.", speed);
	} else {
		DBG("Espeak: Rate set to %i.", speed);
	}
} // end espeak_set_rate



static void espeak_set_synthesis_voice(TTSRENDER_STATE_T *st, char *synthesis_voice) {
	if (synthesis_voice != NULL) {
		espeak_ERROR ret = espeak_SetVoiceByName(synthesis_voice);
		if (ret != EE_OK) {
			DBG("Espeak: Failed to set synthesis voice to %s.", synthesis_voice);
		}
	}
} // end espeak_set_synthesis_voice


static void espeak_set_volume(TTSRENDER_STATE_T *st, signed int volume) {
	assert(volume >= -100 && volume <= +100);
	int vol;
	vol = volume + 100;
	espeak_ERROR ret = espeak_SetParameter(espeakVOLUME, vol, 0);
	if (ret != EE_OK) {
		DBG("Espeak: Error setting volume %i.", vol);
	} else {
		DBG("Espeak: Volume set to %i.", vol);
	}
} // end espeak_set_volume




// espeak state reset
static void espeak_state_reset(TTSRENDER_STATE_T *st) {
	st->tts_state = IDLE;
	st->tts_pause_state = ESPEAK_PAUSE_OFF;
	st->tts_stop_requested = FALSE;
} // end espeak_state_reset



// Return true if the thread is busy, i.e., suspended mutex is not locked.
static int is_thread_busy(TTSRENDER_STATE_T *st, pthread_mutex_t *suspended_mutex) {
	if (EBUSY == pthread_mutex_trylock(suspended_mutex))
		return FALSE;
	else {
		pthread_mutex_unlock(suspended_mutex);
		return TRUE;
	}
} // end is_thread_busy



static TPlaybackQueueEntry *playback_queue_pop() {
	TPlaybackQueueEntry *result = NULL;
	pthread_mutex_lock(&playback_queue_mutex);
	while (!espeak_stop_requested && playback_queue == NULL) {
		pthread_cond_wait(&playback_queue_condition, &playback_queue_mutex);
	}
	if (!espeak_stop_requested) {
		result = (TPlaybackQueueEntry *) playback_queue->data;
		playback_queue = g_slist_remove(playback_queue, playback_queue->data);
		if (result->type == ESPEAK_QET_AUDIO) {
			playback_queue_size -= result->data.audio.num_samples;
			pthread_cond_signal(&playback_queue_condition);
		}
	}
	pthread_mutex_unlock(&playback_queue_mutex);
	return result;
} // end playback_queue_pop




static gboolean playback_queue_push(TPlaybackQueueEntry * entry) {
	pthread_mutex_lock(&playback_queue_mutex);
	playback_queue = g_slist_append(playback_queue, entry);
	if (entry->type == ESPEAK_QET_AUDIO) {
		playback_queue_size += entry->data.audio.num_samples;
	}
	pthread_cond_signal(&playback_queue_condition);
	pthread_mutex_unlock(&playback_queue_mutex);
	return TRUE;
} // end playback_queue_push





// set speaking thread parameters
static void set_speaking_thread_parameters() {
	int ret;
	sigset_t all_signals;	    

	ret = sigfillset(&all_signals);
	if (ret == 0){
		ret = pthread_sigmask(SIG_BLOCK,&all_signals,NULL);
		if (ret != 0)
			DBG("Can't set signal set, expect problems when terminating!\n");
	}else{
		DBG("Can't fill signal set, expect problems when terminating!\n");
	}

	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);				

} // end set_speaking_thread_parameters





// Playback thread.
static void *_espeak_play(void *param) {
	volatile TTSRENDER_STATE_T *st = (TTSRENDER_STATE_T*)param;
	char *markid;
	PLAYBACK_QUEUE_ENTRY_T *playback_queue_entry = NULL;

	//DBG("Espeak: Playback thread starting.......");

	// Block all signals to this thread.
	set_speakinthread_parameters();

	while (!st->tts_close_requested) {
		// If semaphore not set, set suspended lock and suspend until it is signaled.
		if (0 != sem_trywait(&st->tts_play_semaphore)) {
			pthread_mutex_lock(&st->tts_play_suspended_mutex);
			sem_wait(&st->tts_play_semaphore);
			pthread_mutex_unlock(&tts_play_suspended_mutex);
		}
		//DBG("Espeak: Playback semaphore on.");
		if (st->tts_close_requested)
			break;
		if (st->tts_state < BEFORE_PLAY) {
			// This can happen after wake-up  from suspend-to-disk
			//DBG("Espeak: Warning: Spurious wake of of playback thread.");
			continue;
		}

		while (1) {
			int finished = 0;
			playback_queue_entry = playback_queue_pop(st);
			if (playback_queue_entry == NULL) {
				//DBG("Espeak: playback thread detected stop.");
				break;
			}

			switch (playback_queue_entry->type) {
			case QET_AUDIO:
				espeak_send_to_audio(st, playback_queue_entry);
				break;
			case QET_INDEX_MARK:
				markid = playback_queue_entry->data.markid;
				//DBG("Espeak: reporting index mark |%s|.", markid);
				module_report_index_mark(markid);
				//DBG("Espeak: index mark reported.");
				pthread_mutex_lock(&st->tts_state_mutex);
				if (st->tts_state == SPEAKING && st->tts_pause_state == TTS_PAUSE_REQUESTED && !is_thread_busy (&espeak_stop_or_pause_suspended_mutex) && str_has_prefix(markid, "__spd_")) {
					//DBG("Espeak: Pause requested in playback thread.  Stopping.");
					st->tts_stop_requested = TRUE;
					st->tts_pause_state = TTS_PAUSE_MARK_REPORTED;
					sem_post(&st->tts_stop_or_pause_semaphore);
					finished = 1;
				}
				pthread_mutex_unlock(&st->tts_state_mutex);
				break;
			case QET_SOUND_ICON:
				module_play_file(playback_queue_entry->data.sound_icon_filename);
				break;
			case QET_BEGIN:
				{
					int report_begin = 0;
					pthread_mutex_lock(&st->tts_state_mutex);
					if (st->tts_state == BEFORE_PLAY) {
						st->tts_state = SPEAKING;
						report_begin = 1;
					}
					pthread_mutex_unlock(&st->tts_state_mutex);
					if (report_begin)
						module_report_event_begin();
					break;
				}
			case QET_END:
				pthread_mutex_lock(&st->tts_state_mutex);
				//DBG("Espeak: playback thread got END from queue.");
				if (st->tts_state == SPEAKING) {
					if (!st->tts_stop_requested) {
						//DBG("Espeak: playback thread reporting end.");
						st->tts_state = IDLE;
						st->tts_pause_state = TTS_PAUSE_OFF;
					}
					finished = 1;
				}
				pthread_mutex_unlock(&st->tts_state_mutex);
				if (finished)
					module_report_event_end();
				break;
			}

			espeak_delete_playback_queue_entry(st, playback_queue_entry);
			if (finished)
				break;
		} // end while(1)
		} // end while (!espeak_close_requested)
	//DBG("Espeak: Playback thread ended.......");
	return 0;
} // end _espeak_play




/* Stop or Pause thread. */
static void *_espeak_stop_or_pause(void *param) {
	volatile TTSRENDER_STATE_T *st = (TTSRENDER_STATE_T*)param;
	int ret;

	//DBG("Espeak: Stop or pause thread starting.......");

	// Block all signals to this thread.
	set_speaking_thread_parameters();

	while (!st->tts_close_requested) {
		/* If semaphore not set, set suspended lock and suspend until it is signaled. */
		if (0 != sem_trywait(&st->tts_stop_or_pause_semaphore)) {
			pthread_mutex_lock(&st->tts_stop_or_pause_suspended_mutex);
			sem_wait(&st->tts_stop_or_pause_semaphore);
			pthread_mutex_unlock(&st->tts_stop_or_pause_suspended_mutex);
		}
		//DBG("Espeak: Stop or pause semaphore on.");
		if (st->tts_close_requested)
			break;
		if (!st->tts_stop_requested) {
			// This sometimes happens after wake-up from suspend-to-disk. 
			//DBG("Espeak: Warning: spurious wake-up  of stop thread.");
			continue;
		}

		pthread_mutex_lock(&st->playback_queue_mutex);
		pthread_cond_broadcast(&st->playback_queue_condition);
		pthread_mutex_unlock(&st->playback_queue_mutex);

		if (module_audio_id) {
			//DBG("Espeak: Stopping audio.");
			ret = spd_audio_stop(module_audio_id);
			//DBG_WARN(ret == 0, "spd_audio_stop returned non-zero value.");
			while (is_thread_busy(&st->tts_play_suspended_mutex)) {
				ret = spd_audio_stop(module_audio_id);
				//DBG_WARN(ret == 0, "spd_audio_stop returned non-zero value.");
				usleep(5000);
			} // while (is_thread_busy(&st->tts_play_suspended_mutex))
		} else {
			while (is_thread_busy(&st->tts_play_suspended_mutex)) {
				usleep(5000);
			} // while (is_thread_busy(&st->tts_play_suspended_mutex))
		}

		//DBG("Espeak: Waiting for synthesis to stop.");
		ret = espeak_Cancel();
		//DBG_WARN(ret == EE_OK, "Espeak: error in espeak_Cancel().");

		//DBG("Espeak: Clearing playback queue.");
		espeak_clear_playback_queue(st);

		int save_pause_state = espeak_pause_state;
		pthread_mutex_lock(&st->tts_state_mutex);
		espeak_state_reset(st);
		pthread_mutex_unlock(&st->tts_state_mutex);

		if (save_pause_state == ESPEAK_PAUSE_MARK_REPORTED) {
			module_report_event_pause();
		} else {
			module_report_event_stop();
		}

		//DBG("Espeak: Stop or pause thread ended.......\n")
	} // while (!st->espeak_close_requested)
	pthread_exit(NULL);
} // end _espeak_stop_or_pause


