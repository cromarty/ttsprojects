

static int synth_callback(short *wav, int numsamples, espeak_EVENT * events) {
	static int numsamples_sent_msg = 0;
	int numsamples_sent = 0;

	// set espeak state mutex lock here

	// first time in for this message?
	if (espeak_state == BEFORE_SYNTH) {
		numsamples_sent_msg = 0;
		espeak_state = BEFORE_PLAY;
		// add begin flag to queue
		// wake playback thread here

	}
	// unlock the espeak state mutex here

	if (espeak_stop_requested)
		return 1;

	// process audio data and events
	while (events->type != espeakEVENT_LIST_TERMINATED) {

	} // end while (events->type != espeakEVENT_LIST_TERMINATED)
	// send audio up to here

	// increment the static number of samples in this message
	numsamples_sent_msg += numsamples;

	// return zero to indicate we still want more of this message
	return 0;
}
