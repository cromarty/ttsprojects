#ifndef RINGBUFFER_H
#define RINGBUFFER_H


typedef struct {
    char *buffer;
    int length;
    int head;
    int tail;
} RING_BUFFER_T;

RING_BUFFER_T *ilctts_ringbuffer_init(int length);
void ilctts_ringbuffer_destroy(RING_BUFFER_T*buffer);
int ilctts_ringbuffer_freespace(RING_BUFFER_T*buffer);
int ilctts_ringbuffer_usedspace(RING_BUFFER_T*buffer);
int ilctts_ringbuffer_read(RING_BUFFER_T*buffer, char *target, int amount);
int ilctts_ringbuffer_write(RING_BUFFER_T*buffer, char *data, int length);
int ilctts_ringbuffer_peek(RING_BUFFER_T*buffer, char *c, int offset);
int ilctts_ringbuffer_slurp(RING_BUFFER_T*buffer, char *buf);
int ilctts_ringbuffer_spin(RING_BUFFER_T*buffer, int offset);
int ilctts_ringbuffer_isfull(RING_BUFFER_T*buffer);
int ilctts_ringbuffer_isempty(RING_BUFFER_T*buffer);

#endif

