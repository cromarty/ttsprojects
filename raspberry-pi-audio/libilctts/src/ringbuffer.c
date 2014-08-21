#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ringbuffer.h"


RING_BUFFER_T *ilctts_ringbuffer_init(int length) {
	RING_BUFFER_T *buffer = malloc(sizeof(RING_BUFFER_T));
	buffer->length = length;
	buffer->head = 0;
    buffer->tail = 0;
	buffer->buffer = malloc(length);
	return buffer;
} // end ilctts_ringbuffer_init

void ilctts_ringbuffer_destroy(RING_BUFFER_T *buffer)
{
	if(buffer) {
		free(buffer->buffer);
		free(buffer);
	}
} // end ilctts_ringbuffer_destroy

int ilctts_ringbuffer_write(RING_BUFFER_T *buffer, char *data, int writesize)
{
	int firstchunksize;
	int secondchunksize;
	int freespace;

	if ( writesize > buffer->length )
		return -1;

	freespace = ilctts_ringbuffer_freespace(buffer);
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

} // end ilctts_ringbuffer_write

int ilctts_ringbuffer_read(RING_BUFFER_T *buffer, char *data, int readsize) {
	int firstchunksize;
	int secondchunksize;

	if ( readsize > ilctts_ringbuffer_usedspace(buffer))
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

} // end ilctts_ringbuffer_read

int ilctts_ringbuffer_peek(RING_BUFFER_T *buffer, char *c, int offset) {
	int idx;
	if (buffer->head == buffer->tail)
		return -1;

	if (offset > buffer->length)
		return -1;

	idx = (buffer->head + offset) % buffer->length;
	*c = buffer->buffer[idx];
	return 1;

} // end ilctts_ringbuffer_peek

int ilctts_ringbuffer_slurp(RING_BUFFER_T *buffer, char *data) {
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

} // end ilctts_ringbuffer_slurp


int ilctts_ringbuffer_freespace(RING_BUFFER_T *buffer) {
if(buffer->head == buffer->tail)
                        return buffer->length;

	if( buffer->head < buffer->tail )
		return buffer->length - (buffer->tail - buffer->head);

	return buffer->head - buffer->tail;

} // end ilctts_ringbuffer_freespace

int ilctts_ringbuffer_usedspace(RING_BUFFER_T *buffer) {
	if (buffer->head == buffer->tail)
		return 0;

	if ( buffer->tail > buffer->head )
		return (buffer->tail - buffer->head);

	return (buffer->length - buffer->head) + buffer->tail;

} // end ilctts_ringbuffer_usedspace

int ilctts_ringbuffer_spin(RING_BUFFER_T *buffer, int offset) {
	if (offset == 0)
		return 0;

	buffer->head = (buffer->head + offset) % buffer->length;
	return buffer->head;
} // end ilctts_ringbuffer_spin

int ilctts_ringbuffer_isempty(RING_BUFFER_T *buffer) {
	return (buffer->head == buffer->tail);
} // end ilctts_ringbuffer_isempty

int ilctts_ringbuffer_isfull(RING_BUFFER_T *buffer) {
	return (ilctts_ringbuffer_freespace(buffer) == 0);
} // end ilctts_ringbuffer_isfull

