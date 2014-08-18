#ifndef ILCPCMRENDER_H
#define ILCPCMRENDER_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>

#include "bcm_host.h"
#include "ilclient.h"


int32_t pcmrender_create(
	PCMRENDER_STATE_T **component,
	uint32_t sample_rate,
	uint32_t num_channels,
	uint32_t bit_depth,
	uint32_t num_buffers,
	uint32_t buffer_size);

int32_t pcmrender_delete(PCMRENDER_STATE_T *st);


#endif


