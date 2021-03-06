#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ringbuffer.h"


ringbuffer *ringbuffer_init(int length) {
	ringbuffer *buffer = malloc(sizeof(ringbuffer));
	buffer->length = length;
	buffer->head = 0;
    buffer->tail = 0;
	buffer->buffer = malloc(length);
	return buffer;
}

void ringbuffer_destroy(ringbuffer *buffer)
{
	if(buffer) {
		free(buffer->buffer);
		free(buffer);
	}
}

int ringbuffer_write(ringbuffer *buffer, char *data, int writesize)
{
	int firstchunksize;
	int secondchunksize;
	int freespace;

	if ( writesize > buffer->length )
		return -1;

	freespace = ringbuffer_freespace(buffer);
	if (freespace < writesize)
		return -1;

	if ( ( buffer->length - buffer->tail ) >= writesize) {
		/* easy case, no wrapping */
		memcpy(&buffer->buffer[buffer->tail], data, writesize);
		buffer->tail += writesize;
	} else {
		/* harder case, buffer wraps */
		firstchunksize = buffer->length - buffer->tail;
		secondchunksize = writesize - firstchunksize;
		memcpy( &buffer->buffer[buffer->tail], data, firstchunksize);
		memcpy( &buffer->buffer[0], &data[firstchunksize], secondchunksize);
		buffer->tail = secondchunksize;
	}

	return writesize;

}

int ringbuffer_read(ringbuffer *buffer, char *data, int readsize) {
	int firstchunksize;
	int secondchunksize;

	if ( readsize > ringbuffer_usedspace(buffer))
		return -1;

	if( buffer->tail > buffer->head ) {
		/* easy case, no wrap */
		memcpy( data, &buffer->buffer[buffer->head], readsize);
		buffer->head += readsize;
	} else {
		/* harder case, wrap */
		firstchunksize = buffer->length - buffer->head;
		secondchunksize = readsize - firstchunksize;
		memcpy( data, &buffer->buffer[buffer->head], firstchunksize);
		memcpy( &data[firstchunksize], &buffer->buffer[0], secondchunksize);
		buffer->head = secondchunksize;
	}

	return readsize;

}

int ringbuffer_peek(ringbuffer *buffer, char *c, int offset) {
	int idx;
	if (buffer->head == buffer->tail)
		return -1;

	if (offset > buffer->length)
		return -1;

	idx = (buffer->head + offset) % buffer->length;
	*c = buffer->buffer[idx];
	return 1;

} // end ringbuffer_peek

int ringbuffer_slurp(ringbuffer *buffer, char *data) {
	int firstchunksize;
	int secondchunksize;
	int slurped;

	if (buffer->head == buffer->tail)
		return -1;

	if (buffer->tail > buffer->head) {
		/* easy case, no wrap */
		slurped = (buffer->tail - buffer->head);
		memcpy(data, &buffer->buffer[buffer->head], buffer->tail - buffer->head);
	} else {
		/* harder case, wrap */
		firstchunksize = buffer->length - buffer->head;
		secondchunksize = buffer->tail;
		slurped = firstchunksize + secondchunksize;
		memcpy( data, &buffer->buffer[buffer->head], firstchunksize);
		memcpy(&data[firstchunksize], &buffer->buffer[0], secondchunksize);
	}
	buffer->head = buffer->tail = 0;
	return slurped;

} // end ringbuffer_slurp


int ringbuffer_freespace(ringbuffer *buffer) {
if(buffer->head == buffer->tail)
                        return buffer->length;

	if( buffer->head < buffer->tail )
		return buffer->length - (buffer->tail - buffer->head);

	return buffer->head - buffer->tail;

} // end ringbuffer_freespace

int ringbuffer_usedspace(ringbuffer *buffer) {
	if (buffer->head == buffer->tail)
		return 0;

	if ( buffer->tail > buffer->head )
		return (buffer->tail - buffer->head);

	return (buffer->length - buffer->head) + buffer->tail;

} // end ringbuffer_datasize

int ringbuffer_spin(ringbuffer *buffer, int offset) {
	if (offset == 0)
		return 0;

	buffer->head = (buffer->head + offset) % buffer->length;
	return buffer->head;
} // end ringbuffer_spin

int ringbuffer_isempty(ringbuffer *buffer) {
	return (buffer->head == buffer->tail);
} // end ringbuffer_isempty

int ringbuffer_isfull(ringbuffer *buffer) {
	return (ringbuffer_freespace(buffer) == 0);
}

