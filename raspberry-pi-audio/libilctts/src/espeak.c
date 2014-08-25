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
#include "espeak.h"

/*
* Return values:
*   0 = continnue synthesis
*   1 = abort synthesis
*/

static int ilctts_espeak_synth_callback(short *wav, int numsamples, espeak_EVENT * events) {
	TTSRENDER_STATE_T *st;
		// Number of samples sent in current message.
	static int numsamples_sent_msg = 0;
	// Number of samples already sent during this call to the callback.
	int numsamples_sent = 0;
	 uint32_t result = 0;

	pthread_mutex_lock(&st->espeak_state_mutex);
	if (st->espeak_state == ESPEAK_BEFORE_SYNTH) {
		numsamples_sent_msg = 0;
		st->espeak_state = ESPEAK_BEFORE_PLAY;
		ilctts_espeak_playback_queue_add_flag();
		// Wake up playback thread
		sem_post(&st->play_semaphore);
	}
	pthread_mutex_unlock(&st->espeak_state_mutex);

	if (st->espeak_stop_requested) {
		return 1;
	}

	// Process events and audio data
	while (events->type != espeakEVENT_LIST_TERMINATED) {
		// Enqueue audio upto event
		switch (events->type) {
		case espeakEVENT_MARK:
		case espeakEVENT_PLAY:
			{
				// Convert ms position to samples
				int64_t pos_msg = events->audio_position;
				pos_msg = pos_msg * st->sample_rate / 1000;
				// Convert position in message to position in current chunk
				int upto = (int)CLAMP(pos_msg - numsamples_sent_msg, 0, numsamples);	/* This is just for safety */
				ilctts_espeak_send_audio_upto(wav, &numsamples_sent, upto);
				break;
			}
		default:
			break;
		}

		// Process actual event
		switch (events->type) {
		case espeakEVENT_MARK:
			result = ilctts_espeak_playback_queue_add_mark(events->id.name);
			break;
		case espeakEVENT_PLAY:
			result = ilctts_espeak_playback_queue_add_sound_icon(events->id.name);
			break;
		case espeakEVENT_MSG_TERMINATED:
			// This event never has any audio in the same callback
			result = ilctts_espeak_playback_queue_add_flag(ESPEAK_QET_END);
			break;
		default:
			break;
		}
		if (st->espeak_stop_requested) {
			return 1;
		}
		events++;
	} // while

	ilctts_espeak_send_audio_upto(wav, &numsamples_sent, numsamples);
	numsamples_sent_msg += numsamples;
	return 0;

} // end ilctts_espeak_synth_callback



/* Adds a chunk of pcm audio to the audio playback queue.
*  Waits until there is enough space in the queue.
*/
static uint32_t ilctts_espeak_playback_queue_add_audio(TTSRENDER_STATE_T *st, short *audio_chunk, int num_samples) {
	pthread_mutex_lock(&st->playback_queue_mutex);
	while (!st->espeak_stop_requested && playback_queue_size > EspeakAudioQueueMaxSize) {
		pthread_cond_wait(&st->playback_queue_cv, &st->playback_queue_mutex);
	}
	pthread_mutex_unlock(&st->playback_queue_mutex);
	if (st->espeak_stop_requested) {
		return 1; // stop espeak
	}

	PLAYBACK_QUEUE_ENTRY_T *pqentry = g_new(TPlaybackQueueEntry, 1);
	pqentry->type = ESPEAK_QET_AUDIO;
	pqentry->data.audio.num_samples = num_samples;
	int nbytes = sizeof(short) * num_samples;
	pqentry->data.audio.audio_chunk = (short *)g_memdup((gconstpointer) audio_chunk, nbytes);
	//playback_queue_push(pqentry);
	// now queue the entry
	queue_enqueue(&st->playback_queue, (void*)entry);
	return TRUE; // check this
}

/* Adds a begin or end flag to the playback queue. */
static uint32_t ilctts_espeak_playback_queue_add_flag(TTSRENDER_STATE_T *st, PLAYBACK_QUEUE_ENTRY_TYPE_T type) {
	PLAYBACK_QUEUE_ENTRY_T *pqentry = (PLAYBACK_QUEUE_ENTRY_T *)malloc(sizeof(PLAYBACK_QUEUE_ENTRY_T));
	pqentry->type = type;
	queue_enqueue(&st->playback_queue, (void*)entry);
	return;
} // end playback_queue_flag

/* Adds an Index Mark to the audio playback queue. */
static uint32_t ilctts_espeak_playback_queue_add_mark(TTSRENDER_STATE_T *st, const char *mark_id) {
	PLAYBACK_QUEUE_ENTRY_T *pqentry = (PLAYBACK_QUEUE_ENTRY_T*)malloc(sizeof(PLAYBACK_QUEUE_ENTRY_T));
	pqentry->type = ESPEAK_QET_INDEX_MARK;
	pqentry->data.mark_id = g_strdup(mark_id);
	queue_enqueue(&st->playback_queue, entry);
	return;
} // end playback_queue_mark

/* Add a sound icon to the playback queue. */
static uint32_t ilctts_espeak_playback_queue_add_sound_icon(TTSRENDER_STATE_T *st, const char *filename) {
	PLAYBACK_QUEUE_ENTRY_T *pqentry = (PLAYBACK_QUEUE_ENTRY_T*)malloc(sizeof(PLAYBACK_QUEUE_ENTRY_T));
	pqentry->type = ESPEAK_QET_SOUND_ICON;
	pqentry->data.sound_icon_filename = g_strdup(filename);
	queue_enqueue(&st->playback_queue, (void*)entry);
	return;
} //end playback_queue_sound_icon


/* Deletes an entry from the playback audio queue, freeing memory. */
static void ilctts_espeak_delete_playback_queue_entry(TTSRENDER_STATE_T *st) {
	PLAYBACK_QUEUE_ENTRY_T *pqentry;
	queue_dequeue(&st->playback_queue, (void*)pqentry);
	switch (pqentry->type) {
	case ESPEAK_QET_AUDIO:
		free(pqentry->data.audio.audio_chunk);
		break;
	case ESPEAK_QET_INDEX_MARK:
		free(pqentry->data.mark_id);
		break;
	case ESPEAK_QET_SOUND_ICON:
		free(pqentry->data.sound_icon_filename);
		break;
	default:
		break;
	}
	free(pqentry);
} // end delete_playback_queue_entry


/* Erases the entire playback queue, freeing memory. */
static void ilctts_espeak_clear_playback_queue(TTSRENDER_STATE_T *st, ) {
	pthread_mutex_lock(&st->playback_queue_mutex);
	while (queue_size(&st->playback_queue) > 0 ) {
		delete_playback_queue_entry(st);
	}
	queue_destroy(st->playback_queue);
	pthread_mutex_unlock(&st->playback_queue_mutex);
}






