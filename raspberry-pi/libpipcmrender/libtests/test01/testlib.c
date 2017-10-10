#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <math.h>
#include <piespeak/piespeak_lib.h>
#include <piespeak/utils.h>

#include "bcm_host.h"


int main(int argc, char **argv) {
	printf("Size of a TTSRENDER_STATE_T object: %d bytes\n", sizeof(TTSRENDER_STATE_T));
	return 0;
}
