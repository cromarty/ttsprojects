/*
*
* ringbuffer.c - Functions to implement a circular buffer of type void
*
* Functionality to implement a circular buffer of type void. Differs from
* that in queue.c in that the FIFO is a pure void data rather than a queue of complex data type pointers.
*
* Copyright (C) 2014, Mike Ray, <mike.ray@btinternet.com>
*
* This is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 3, or (at your option) any later
* version.
*
* This software is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this package; see the file COPYING.  If not, write to the Free
* Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
* 02110-1301, USA.
*
*--code--*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ringbuffer.h"


RINGBUFFER_T *ringbuffer_init(int length) {
	RINGBUFFER_T *buffer = malloc(sizeof(RINGBUFFER_T));
	if (buffer == NULL)
		return NULL;
	buffer->length = length;
	buffer->head = 0;
    buffer->tail = 0;
	buffer->buffer = malloc(length);
	if (buffer->buffer == NULL) {
		free(buffer);
		return NULL;
	}
	return buffer;
}

void ringbuffer_destroy(RINGBUFFER_T *buffer)
{
	if(buffer) {
		free(buffer->buffer);
		free(buffer);
	}
}

int ringbuffer_write(RINGBUFFER_T *buffer, void *data, int writesize)
{
	int firstchunksize;
	int secondchunksize;
	int freespace;
	char *b_ptr; // buffer pointer
char *d_ptr; // data pointer

	if ( writesize > buffer->length )
		return -1;

	freespace = ringbuffer_freespace(buffer);
	if (freespace < writesize)
		return -1;

	if ( ( buffer->length - buffer->tail ) >= writesize) {
		// easy case, no wrapping
b_ptr = (char*)buffer->buffer + buffer->tail;
		memcpy(b_ptr, data, writesize);
		buffer->tail += writesize;
	} else {
		// harder case, buffer wraps
		firstchunksize = buffer->length - buffer->tail;
		secondchunksize = writesize - firstchunksize;
	b_ptr = (char*)buffer->buffer + buffer->tail;
		memcpy(b_ptr, data, firstchunksize);
b_ptr = (char*)buffer->buffer;
d_ptr = (char*)data + firstchunksize;
		memcpy(b_ptr, d_ptr, secondchunksize);
		buffer->tail = secondchunksize;
	}

	return writesize;

}

int ringbuffer_read(RINGBUFFER_T *buffer, void *data, int readsize) {
	int firstchunksize;
	int secondchunksize;
char *b_ptr; // buffer pointer
char *d_ptr; // data pointer

	if ( readsize > ringbuffer_used_space(buffer))
		return -1;

	if( buffer->tail > buffer->head ) {
		// easy case, no wrap
b_ptr = (char*)buffer->buffer + buffer->head;
		memcpy( data, b_ptr, readsize);
		buffer->head += readsize;
	} else {
		// harder case, wrap
		firstchunksize = buffer->length - buffer->head;
		if (readsize <= firstchunksize) {
			b_ptr = (char*)buffer->buffer + buffer->head;
			memcpy(data, b_ptr, readsize);
			buffer->head += readsize;
		} else {
			secondchunksize = readsize - firstchunksize;
			b_ptr = (char*)buffer->buffer + buffer->head;
			memcpy( data, b_ptr, firstchunksize);
			b_ptr = (char*)buffer->buffer;
			d_ptr = (char*)data + firstchunksize;
			memcpy( d_ptr, b_ptr, secondchunksize);
			buffer->head = secondchunksize;
		}
	}

	return readsize;

}


int ringbuffer_slurp(RINGBUFFER_T *buffer, void *data) {
	int firstchunksize;
	int secondchunksize;
	int slurped;
	char *b_ptr; // buffer pointer
	char *d_ptr; // data pointer
	if (buffer->head == buffer->tail)
		return -1;

	if (buffer->tail > buffer->head) {
		// easy case, no wrap
		slurped = (buffer->tail - buffer->head);
		b_ptr = buffer->buffer + buffer->head;
		memcpy(data, b_ptr, slurped);
	} else {
		// harder case, wrap
		firstchunksize = buffer->length - buffer->head;
		secondchunksize = buffer->tail;
		slurped = firstchunksize + secondchunksize;
		b_ptr = buffer->buffer + buffer->head;
		memcpy( data, b_ptr, firstchunksize);
		b_ptr = buffer->buffer;
		d_ptr = data + firstchunksize;
		memcpy(d_ptr, b_ptr, secondchunksize);
	}
	buffer->head = buffer->tail = 0;
	return slurped;

} // end ringbuffer_slurp


int ringbuffer_freespace(RINGBUFFER_T *buffer) {
if(buffer->head == buffer->tail)
                        return buffer->length;

	if( buffer->head < buffer->tail )
		return buffer->length - (buffer->tail - buffer->head);

	return buffer->head - buffer->tail;

} // end ringbuffer_freespace

int ringbuffer_used_space(RINGBUFFER_T *buffer) {
	if (buffer->head == buffer->tail)
		return 0;

	if ( buffer->tail > buffer->head )
		return (buffer->tail - buffer->head);

	return (buffer->length - buffer->head) + buffer->tail;

} // end ringbuffer_datasize

int ringbuffer_spin(RINGBUFFER_T *buffer, int offset) {
	if (offset == 0)
		return 0;

	buffer->head = (buffer->head + offset) % buffer->length;
	return buffer->head;
} // end ringbuffer_spin

int ringbuffer_isempty(RINGBUFFER_T *buffer) {
	return (buffer->head == buffer->tail);
} // end ringbuffer_isempty

int ringbuffer_isfull(RINGBUFFER_T *buffer) {
	return (ringbuffer_freespace(buffer) == 0);
}

//
