#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <math.h>
#include <espeak/speak_lib.h>

#include <pipcmrender/pipcmrender_lib.h>
#include <pipcmrender/utils.h>

#include <bcm_host.h>



#define M 10
#define N (1<<M)
#define BUF_LEN 100

sem_t sema;

int synth_callback(short *wav, int numsamples, espeak_EVENT *events) {
	PCMRENDER_STATE_T *st = (PCMRENDER_STATE_T*)events->user_data;
	uint8_t *buf;

	if (numsamples) {
        
		buf = pipcmrender_get_buffer(st);
		while(buf == NULL) {
			pthread_mutex_lock(&st->free_buffer_mutex);
			pthread_cond_wait(&st->free_buffer_cv, &st->free_buffer_mutex);
			buf = pipcmrender_get_buffer(st);
			pthread_mutex_unlock(&st->free_buffer_mutex);
		}// end while

		memcpy(buf, wav, numsamples<<1);		
		pipcmrender_latency_wait((PCMRENDER_STATE_T *)st);
		pipcmrender_send_audio(st, buf, numsamples<<1);

	}

	while(events->type != espeakEVENT_LIST_TERMINATED) {
		if (events->type == espeakEVENT_MSG_TERMINATED)
			sem_post(&sema);

		events++;
	}


	return 0;
} // end Synth_callback


// the real producer is the synth callback above.
int producer(PCMRENDER_STATE_T *st, int wpm) {
	int sample_rate;
	int flags = espeakSSML | espeakCHARS_UTF8;
	espeak_ERROR erc;

char buf[BUF_LEN];

	sem_init(&sema, 0, 1);

	sample_rate = espeak_Initialize(AUDIO_OUTPUT_RETRIEVAL, 50, NULL, 0);
	erc = espeak_SetParameter(espeakRATE, wpm, 0);

	espeak_SetSynthCallback(synth_callback);

	while ( fgets (buf, BUF_LEN, stdin) != NULL) {
if (strcmp(buf, "quit()\n") == 0)
break;
		erc = espeak_Synth(buf, strlen(buf)+1, 0, POS_CHARACTER, 0, flags, NULL, st);
		sem_wait(&sema);
	}
sem_wait(&sema);
	sem_destroy(&sema);
	return 0;
} // end producer


int main(int argc, char **argv) {
	OMX_ERRORTYPE omx_err;
	OMX_STATETYPE state;
	PCMRENDER_STATE_T *st;
	int32_t ret;
	char debug_str[128];
	int chunks = 0;
int wpm;

	if (argc != 2) {
		printf("Usage: testlib <wpm>\n");
		return 1;
}

wpm = atoi(argv[1]);
printf("WPM: %d\n", wpm);

	ret = pipcmrender_initialize();
	if (ret < 0) { 
		printf("Failed to initialise OMX\n");
		return 1;
	}

	omx_err = pipcmrender_create(
		&st,			// the tts state object
		22050,			// sampling rate
		1,			// number of channels
		16,			// bit depth
		2,			// number of IL client buffers
	50,
	BS_MILLISECONDS,
	5
	);
	if (omx_err != OMX_ErrorNone) {
		printf("Failed to create component\n");
		return 1;
	}

	ret = pipcmrender_set_dest(st, "local");
	if (ret < 0) {
		printf("Failed to set audio destination\n");
		return 1;
	}

	ret = pipcmrender_get_state(st, &state);
	if (ret < 0) {
		printf("Failed to get state\n");
	}



ret = producer(st, wpm);

	omx_err = pipcmrender_delete(st);
	if (omx_err != OMX_ErrorNone) {
		printf("Failed to delete component\n");
		return 1;
	}

	pipcmrender_finalize();

	return 0;

} // end main


