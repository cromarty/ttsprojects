#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <math.h>
#include <espeak/speak_lib.h>

#include <piespeak/piespeak_lib.h>
#include <piespeak/utils.h>
#include <bcm_host.h>

#define M 10
#define N (1<<M)

#define BUFFER_SIZE_MILLISECONDS 50

int synth_callback(short *wav, int numsamples, espeak_EVENT *events) {
	TTSRENDER_STATE_T *st = (TTSRENDER_STATE_T*)events->user_data;
	uint8_t *buf;

	if (numsamples) {
        
		buf = piespeak_get_buffer(st);
		while(buf == NULL) {
			pthread_mutex_lock(&st->free_buffer_mutex);
			pthread_cond_wait(&st->free_buffer_cv, &st->free_buffer_mutex);
			buf = piespeak_get_buffer(st);
			pthread_mutex_unlock(&st->free_buffer_mutex);
		}// end while

		memcpy(buf, wav, numsamples<<1);		
		piespeak_send_audio(st, buf, numsamples<<1);

	}

	return 0;
} // end Synth_callback


// the real producer is the synth callback above.
int producer(TTSRENDER_STATE_T *st) {
	int sample_rate;
	int flags = espeakSSML | espeakCHARS_UTF8;
	char text[] = "Now is the time for every good man to come to the aid of the party";
	int bytes = strlen(text)+1;
	int res;
	sample_rate = espeak_Initialize(
	AUDIO_OUTPUT_RETRIEVAL,
	BUFFER_SIZE_MILLISECONDS,
	NULL,
	0);

	printf("About to set the synth callback\n");
	espeak_SetSynthCallback(synth_callback);
	printf("About to call espeak_Synth\n");

	res = espeak_Synth(text, bytes, 0, POS_CHARACTER, 0, flags, NULL, st);
	printf("After call to espeak_Synth\n");
	sleep(10);

	return 0;
} // end producer


int main(int argc, char **argv) {
	OMX_ERRORTYPE omx_err;
	OMX_STATETYPE state;
	TTSRENDER_STATE_T *st;
	int32_t ret;
	char debug_str[128];
	int chunks = 0;


	ret = piespeak_initialize();
	if (ret < 0) { 
		printf("Failed to initialise OMX\n");
		return 1;
	} else {
		printf("Initialised OMX ok\n");
	}

	omx_err = piespeak_create(&st, 22050, 1, 16, 5, BUFFER_SIZE_MILLISECONDS, BS_MILLISECONDS);
	if (omx_err != OMX_ErrorNone) {
		printf("Failed to create component\n");
		return 1;
	}

	ret = piespeak_set_dest(st, "local");
	if (ret < 0) {
		printf("Failed to set audio destination\n");
		return 1;
	}

	ret = piespeak_get_state(st, &state);
	if (ret < 0) {
		printf("Failed to get state\n");
		printf("Got state: %s\n", debug_str);
	}



ret = producer(st);


	omx_err = piespeak_delete(st);
	if (omx_err != OMX_ErrorNone) {
		printf("Failed to delete component\n");
		return 1;
	}

	piespeak_finalize();

	return 0;

} // end main


