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



static int ilctts_synth_callback(short *wav, int numsamples, espeak_EVENT * events);
void ilctts_set_callbacks(TTSRENDER_STATE_T*);

#endif

