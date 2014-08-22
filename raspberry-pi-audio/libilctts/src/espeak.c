#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>
#include <espeak/speak_lib.h>

#include "audioq.h"
#include "ringbuffer.h"
#include "ilctts_lib.h"



/*
* Return values:
*   0 = continnue synthesis
*   1 = abort synthesis
*/
int espeak_synth_callback(short *wav, int numsamples, espeak_EVENT *events) {
	return 0;
} // end espeak_synth_callback

