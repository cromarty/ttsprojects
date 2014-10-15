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
#include "espeak.h"

static TTSRENDER_STATE_T *g_st = NULL;



static int ilctts_synth_callback(short *wav, int numsamples, espeak_EVENT * events) {
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
	g_st = st;
	espeak_SetSynthCallback(ilctts_synth_callback);
	//espeak_SetUriCallback(ilctts_uri_callback);
	return;
} // end ilctts_set_callbacks
