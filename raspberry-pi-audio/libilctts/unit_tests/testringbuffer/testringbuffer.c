#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>

#include "ringbuffer.h"

#define BUF_LEN 50


void print_results(RINGBUFFER_T *rb, int res, char *msg) {
	int head, tail;
	int isfull, isempty;
	int freespace, usedspace;
	head = rb->head;
	tail = rb->tail;
	isfull = ringbuffer_isfull(rb);;
	isempty = ringbuffer_isempty(rb);
	freespace = ringbuffer_freespace(rb);
	usedspace = ringbuffer_used_space(rb);

	printf("===================\n");
	printf("%s\n", msg);
	printf("-------------------\n");
	printf("Result code: %d\n", res);
	printf("Head: %d Tail: %d\n", head, tail);
	printf("Full: %d Empty: %d\n", isfull, isempty);
	printf("Free space: %d Used space: %d\n", freespace, usedspace);
	printf("==================\n\n");
	return;
}

int main() {
	RINGBUFFER_T *rb;
	char readdata[BUF_LEN+1];
	int err = 0;
	int offset;
	int zeros;
	char c;
	rb = ringbuffer_init(BUF_LEN);
	if (rb == NULL) {
		printf("Failed in ringbuffer_init\n");
		return 1;
	}
	print_results(rb, err, "After initialise");
	err = ringbuffer_write(rb, "111111111122222222223333333333", 30);
	print_results(rb, err, "After first write of 30 bytes");
	if (err < 0) {
		printf("First write failed\n");
		return 1;
	}
	err = ringbuffer_write(rb, "444444444455555555556666666666", 30);
	if (err < 0) {
		printf("Result after second write, trying to write too many bytes for free space: %d, this is correct\n", err);
	} else {
		printf("Result after attempt to write too many bytes for free space: %d, this is an error\n");
		return 1;
	}
	err = ringbuffer_read(rb, readdata, 20);
	print_results(rb, err, "Second read, first 20 of 30 bytes");
	err = ringbuffer_write(rb, "777777777788888888889999999999", 30);
	print_results(rb, err, "Result of third write, should wrap");
	if (err < 0) {
		printf("Third write (wrapping) returned: %d, this is an error\n", err);
		return 1;
	} else {
		printf("Third write (wrapping) returned: %d, this is correct\n");
	}

	err = ringbuffer_slurp(rb, readdata);
	print_results(rb, err, "After slurp of non-empty buffer");
	zeros = open("/dev/zero", O_RDONLY);
	if (zeros < 0) {
		printf("Failed to open /dev/zero");
		return 1;
	}
	err = read(zeros, readdata, BUF_LEN);
	if (err != BUF_LEN) {
		printf("Failed to read from /dev/zero");
		close(zeros);
		return 1;
	}
	err = ringbuffer_write(rb, readdata, BUF_LEN);
	if (err < 0) {
		printf("Failed wrapped write of zeros to buffer, this is an error\n");
	} else {
		printf("Wrapped write returned: %d\n", err);
	}
	close(zeros);
	return 0;
}
