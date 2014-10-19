#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "ringbuffer.h"

#define BUFFER_SIZE 1024

void print_ringbuffer_state(RING_BUFFER_T *rb) {
	return;
}

int main(int argc, char **argv) {
	RING_BUFFER_T *rb;
	short *buf = malloc(BUFFER_SIZE*sizeof(short));
	rb = ilctts_ringbuffer_init(BUFFER_SIZE*sizeof(short));
	if (rb == NULL) {
		printf("Failed to initialise ring buffer\n");
		return 1;
	}
	
	return 0;
}

