#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>

#include "ringbuffer.h"

#define BUF_LEN 1024

void print_specs(ringbuffer *rb, char *msg) {
	int head, tail, isfull, isempty;
	head = RING_BUFFER_HEAD(rb);
	tail = RING_BUFFER_TAIL(rb);
	isfull = RING_BUFFER_IS_FULL(rb);
	isempty = RING_BUFFER_IS_EMPTY(rb);
	printf("----------------------------------------\n");
	printf("%s\n", msg);
	printf("Data length: %d\n", RING_BUFFER_DATA_SIZE(rb));
	printf("Full: %d Empty: %d\n", isfull, isempty);
	printf("Free space: %d\n", RING_BUFFER_FREE_SPACE(rb));
	printf("Head: %d Tail: %d\n", head, tail);
	printf("----------------------------------------\n\n");
	return;
}



int main()
{
	ringbuffer *rb;
	int res, bytesread;
	int zro;
	char c;
	char bigbuf[BUF_LEN*2];
	char smallbuf[BUF_LEN/2];
	rb = ringbuffer_init(BUF_LEN);
	if (rb == NULL) {
		printf("Initialisation of ring buffer failed\n");
		return 1;
	}
	printf("Testing the RING_BUFFER_SIZE macro...\n");
	res = RING_BUFFER_SIZE(rb);
	printf("The size of the buffer is: %d\n", res);
	print_specs(rb, "After init:");
	printf("Attempt to peek before there is any data...\n");
	res = ringbuffer_peek(rb, &c);
	if (res < 0) {
		printf("Attempt to peek before any data failed\n");
	} else {
		printf("Attempt to peek before any data worked! There is something wrong\n");
		return 1;
	}
	res = ringbuffer_write(rb, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 26);
	if (res == -1) {
		printf("Failed write\n");
		return 1;
	}
	printf("Write succeeded: %d\n", res);
	print_specs(rb, "After write:");
	printf("Attempt to peek at head of buffer...\n");
	res = ringbuffer_peek(rb, &c);
	if (res < 0) {
		printf("Attempt to peek at head of buffer failed\n");
		return 1;
	}
	printf("Found %c at head of buffer\n", c);
	res = ringbuffer_read(rb, smallbuf, 10);
	if (res < 0) {
		printf("Read failed\n");
		return 1;
	}
	printf("Read succeeded: %s\n", smallbuf);
	print_specs(rb, "After read:");
	printf("Spinning by 1 byte...\n");
	res = RING_BUFFER_SPIN(rb, 1);
	if (res < 0) {
		printf("Spin failed: %d\n", res);
		return 1;
	}
	printf("Head after Spin: %d\n", res);
	print_specs(rb, "After spin:");
	printf("Try to spin by more than data size...\n");
	res = RING_BUFFER_SPIN(rb, 200);
	if (res < 0) {
		printf("Spin failed\n");
	} else {
		printf("Bad spin worked! Something wrong\n");
		return 1;
	}
	printf("opening /dev/zero to get some data...\n");
	zro = open("/dev/zero", O_RDONLY);
	if (zro < 0) {
		printf("Opening /dev/zero failed\n");
		return 1;
	}
	memset(bigbuf, 0, BUF_LEN*2);
	bytesread = 0;
	while(bytesread <= BUF_LEN) {
		memset(smallbuf, 0, BUF_LEN/2);
		res = read(zro, smallbuf, 500);
		if (res < 0) {
			printf("Read from /dev/zero failed\n");
			return 1;
		}
		printf("Read %d bytes from /dev/zero\n", res);
		bytesread += res;
		strcat(bigbuf, smallbuf);
	}
	printf("Read a total of %d bytes from /dev/zero\n", bytesread);
	printf("Size of data to try to write to ring buffer: %d\n", bytesread);
	printf("Attempting to write more than the size of the buffer...\n");
	res = ringbuffer_write(rb, bigbuf, bytesread);
	if (res < 0) {
		printf("Attempt to write more than the buffer size failed: %d\n", res);
	} else {
		printf("Attempt at bad write worked!  Something wrong: %d\n", res);
		return 1;
	}
	printf("Trying to read more than the size of the buffer...\n");
	res = ringbuffer_read(rb, bigbuf, 1200);
	if (res < 0) {
		printf("Attempt to read more than the buffer size failed\n");
	} else {
		printf("Attempt to read more than the buffer size worked, something wrong\n");
		return 1;
	}
	printf("Trying to read more than available data, but less than the buffer size...\n");
	res = RING_BUFFER_DATA_SIZE(rb);
	res = ringbuffer_read(rb, bigbuf, res+1);
	if (res < 0) {
		printf("Attempt to read more than the available data failed\n");
	} else {
		printf("Attempt to read more than the available data worked! Something wrong\n");
		return 1;
	}
	print_specs(rb, "Before flush:\n");
	printf("Testing the RING_BUFFER_FLUSH macro...\n");
	RING_BUFFER_FLUSH(rb);
	print_specs(rb, "At end of tests:\n");
	printf("Writing some data to the buffer so we can test the slurp function...\n");
	res = ringbuffer_write(rb, "Elephant", strlen("Elephant"));
	if (res < 0) {
		printf("Failed the write before the slurp test\n");
		return 1;
	}
	print_specs(rb, "Before slurp test:");
	printf("Slurping...\n");
	memset(smallbuf, 0, BUF_LEN/2);
		res = ringbuffer_slurp(rb, smallbuf);
		if (res < 0) {
			printf("Failed in slurp test\n");
		return 1;
	}
	printf("Slurped: %s\n", smallbuf);
	print_specs(rb, "After slurp test");
	printf("Freeing the buffer...\n");
	ringbuffer_destroy(rb);
	printf("Tests complete\n");
	return 0;
}
