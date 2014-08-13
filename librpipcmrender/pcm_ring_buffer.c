#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "pcm_ring_buffer.h"


PCM_RING_BUFFER_T *pcm_ring_buffer_init(int length) {
	PCM_RING_BUFFER_T *buffer = malloc(sizeof(PCM_RING_BUFFER_T));
	buffer->length = length;
	buffer->head = 0;
    buffer->tail = 0;
	buffer->pcm = malloc(length*sizeof(short));
	return buffer;
}

void pcm_ring_buffer_destroy(PCM_RING_BUFFER_T *buffer)
{
	if(buffer) {
		free(buffer->pcm);
		free(buffer);
	}
}

int pcm_ring_buffer_write(PCM_RING_BUFFER_T *buffer, short *pcm, int writesize)
{
	int firstchunksize;
	int secondchunksize;
	int freespace;

	if ( writesize > buffer->length )
		return -1;

	freespace = pcm_ring_buffer_free_space(buffer);
	if (freespace < writesize)
		return -1;

	if ( ( buffer->length - buffer->tail ) >= writesize) {
		/* easy case, no wrapping */
		memcpy(&buffer->pcm[buffer->tail], pcm, writesize*sizeof(short));
		buffer->tail += writesize;
	} else {
		/* harder case, buffer wraps */
		firstchunksize = buffer->length - buffer->tail;
		secondchunksize = writesize - firstchunksize;
		memcpy( &buffer->pcm[buffer->tail], pcm, firstchunksize*sizeof(short));
		memcpy( &buffer->pcm[0], &pcm[firstchunksize*sizeof(short)], secondchunksize*sizeof(short));
		buffer->tail = secondchunksize;
	}

	return writesize;

}

int pcm_ring_buffer_read(PCM_RING_BUFFER_T *buffer, short *pcm, int readsize) {
	int firstchunksize;
	int secondchunksize;

	if ( readsize > pcm_ring_buffer_used_space(buffer))
		return -1;

	if( buffer->tail > buffer->head ) {
		/* easy case, no wrap */
		memcpy( pcm, &buffer->pcm[buffer->head], 
readsize*sizeof(short));
		buffer->head += readsize;
	} else {
		/* harder case, wrap */
		firstchunksize = buffer->length - buffer->head;
		secondchunksize = readsize - firstchunksize;
		memcpy( pcm, &buffer->pcm[buffer->head], firstchunksize*sizeof(short));
		memcpy( &pcm[firstchunksize], &buffer->pcm[0], secondchunksize*sizeof(short));
		buffer->head = secondchunksize;
	}

	return readsize;

}

int pcm_ring_buffer_peek(PCM_RING_BUFFER_T *buffer, short *pcm, int offset) {
	int idx;
	if (buffer->head == buffer->tail)
		return -1;

	if (offset > buffer->length)
		return -1;

	idx = (buffer->head + offset) % buffer->length;
	*pcm = buffer->pcm[idx];
	return 1;

} // end PCM_RING_BUFFER_T *_peek

int pcm_ring_buffer_slurp(PCM_RING_BUFFER_T *buffer, short *pcm) {
	int firstchunksize;
	int secondchunksize;
	int slurped;

	if (buffer->head == buffer->tail)
		return -1;

	if (buffer->tail > buffer->head) {
		/* easy case, no wrap */
		slurped = (buffer->tail - buffer->head);
		memcpy(pcm, &buffer->pcm[buffer->head], (buffer->tail - buffer->head) * sizeof(short));
	} else {
		/* harder case, wrap */
		firstchunksize = buffer->length - buffer->head;
		secondchunksize = buffer->tail;
		slurped = firstchunksize + secondchunksize;
		memcpy(pcm, &buffer->pcm[buffer->head], firstchunksize*sizeof(short));
		memcpy(&pcm[firstchunksize*sizeof(short)], &buffer->pcm[0], secondchunksize*sizeof(short));
	}
	buffer->head = buffer->tail = 0;
	return slurped;

} // end PCM_RING_BUFFER_T *_slurp


int pcm_ring_buffer_free_space(PCM_RING_BUFFER_T *buffer) {
if(buffer->head == buffer->tail)
                        return buffer->length;

	if( buffer->head < buffer->tail )
		return buffer->length - (buffer->tail - buffer->head);

	return buffer->head - buffer->tail;

} // end PCM_RING_BUFFER_T *_freespace

int pcm_ring_buffer_used_space(PCM_RING_BUFFER_T *buffer) {
	if (buffer->head == buffer->tail)
		return 0;

	if ( buffer->tail > buffer->head )
		return (buffer->tail - buffer->head);

	return (buffer->length - buffer->head) + buffer->tail;

} // end PCM_RING_BUFFER_T *_pcmsize

int pcm_ring_buffer_spin(PCM_RING_BUFFER_T *buffer, int offset) {
	if (offset == 0)
		return 0;

	buffer->head = (buffer->head + offset) % buffer->length;
	return buffer->head;
} // end PCM_RING_BUFFER_T *_spin

int pcm_ring_buffer_is_empty(PCM_RING_BUFFER_T *buffer) {
	return (buffer->head == buffer->tail);
} // end PCM_RING_BUFFER_T *_isempty

int pcm_ring_buffer_is_full(PCM_RING_BUFFER_T *buffer) {
	return (pcm_ring_buffer_free_space(buffer) == 0);
}

void pcm_ring_buffer_flush(PCM_RING_BUFFER_T *buffer) {
	buffer->head = buffer->tail = 0;
	return;
}


