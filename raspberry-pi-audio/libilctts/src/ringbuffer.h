#ifndef RINGBUFFER_H
#define RINGBUFFER_H


typedef struct {
    char *buffer;
    int length;
    int head;
    int tail;
} RING_BUFFER_T;

RING_BUFFER_T *ringbuffer_init(int length);
void ringbuffer_destroy(RING_BUFFER_T*buffer);
int ringbuffer_freespace(RING_BUFFER_T*buffer);
int ringbuffer_usedspace(RING_BUFFER_T*buffer);
int ringbuffer_read(RING_BUFFER_T*buffer, char *target, int amount);
int ringbuffer_write(RING_BUFFER_T*buffer, char *data, int length);
int ringbuffer_peek(RING_BUFFER_T*buffer, char *c, int offset);
int ringbuffer_slurp(RING_BUFFER_T*buffer, char *buf);
int ringbuffer_spin(RING_BUFFER_T*buffer, int offset);
int ringbuffer_isfull(RING_BUFFER_T*buffer);
int ringbuffer_isempty(RING_BUFFER_T*buffer);

#endif

