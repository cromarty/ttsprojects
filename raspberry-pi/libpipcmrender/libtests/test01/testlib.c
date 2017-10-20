#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <math.h>
#include <pipcmrender/pipcmrender_lib.h>
#include <pipcmrender/utils.h>

#include "bcm_host.h"


int main(int argc, char **argv) {
	printf("Size of a PCMRENDER_STATE_T object: %d bytes\n", sizeof(PCMRENDER_STATE_T));
	return 0;
}
