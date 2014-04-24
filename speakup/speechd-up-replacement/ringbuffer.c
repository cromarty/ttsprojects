#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ringbuffer.h"

#define RING_BUFFER_HEAD_PTR(B) ((B)->buffer + (B)->head)
#define RING_BUFFER_TAIL_PTR(B) ((B)->buffer + (B)->tail)
#define RING_BUFFER_COMMIT_READ(B, A) ((B)->head = ((B)->head + (A)) % (B)->length)
#define RING_BUFFER_COMMIT_WRITE(B, A) ((B)->tail = ((B)->tail + (A)) % (B)->length)


ringbuffer *ringbuffer_init(int length)
{
	ringbuffer *buffer = calloc(1, sizeof(ringbuffer));
	buffer->length  = length + 1;
	buffer->head = 0;
    buffer->tail = 0;
    buffer->buffer = calloc(buffer->length, 1);

    return buffer;
}

void ringbuffer_destroy(ringbuffer *buffer)
{
	if(buffer) {
		free(buffer->buffer);
		free(buffer);
	}
}

int ringbuffer_write(ringbuffer *buffer, char *data, int length)
{
	void *result = NULL;

	if(RING_BUFFER_DATA_SIZE(buffer) == 0)
		buffer->head = buffer->tail = 0;

	if (length <= RING_BUFFER_FREE_SPACE(buffer)) {
		result = memcpy(RING_BUFFER_TAIL_PTR(buffer), data, length);
		if (result == NULL)
			return -1;
	} else {
		return -1;
	}

	RING_BUFFER_COMMIT_WRITE(buffer, length);

	return length;

}

int ringbuffer_read(ringbuffer *buffer, char *target, int amount)
{
	void *result= NULL;

	if (amount > RING_BUFFER_DATA_SIZE(buffer))
		return -1;

	result = memcpy(target, RING_BUFFER_HEAD_PTR(buffer), amount);
	if (result == NULL)
		return-1;

	RING_BUFFER_COMMIT_READ(buffer, amount);

	if(buffer->tail == buffer->head)
		buffer->head = buffer->tail = 0;

	return amount;

}

int ringbuffer_peek(ringbuffer *buffer, char *c)
{
	if (buffer->head == buffer->tail)
		return -1;

	*c = buffer->buffer[buffer->head];
	return 0;
}

int ringbuffer_slurp(ringbuffer *buffer, char *buf)
{
	int datalen;

	datalen = RING_BUFFER_DATA_SIZE(buffer);
	return ringbuffer_read(buffer, buf, datalen);

}