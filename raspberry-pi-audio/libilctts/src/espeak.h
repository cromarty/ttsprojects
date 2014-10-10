#ifndef ESPEAK_H
#define ESPEAK_H
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

#include "list.h"
#include "queue.h"
#include "ilctts_lib.h"


static int synth_callback(short *wav, int numsamples, espeak_EVENT * events);


#endif

