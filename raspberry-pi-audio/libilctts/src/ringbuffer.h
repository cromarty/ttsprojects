#ifndef RING_BUFFER_H
#define RING_BUFFER_H


typedef struct {
    char *buffer;
    int length;
    int head;
    int tail;
} RINGBUFFER_T;

RINGBUFFER_T *ringbuffer_init(int length);
void ringbuffer_destroy(RINGBUFFER_T *buffer);
int ringbuffer_freespace(RINGBUFFER_T *buffer);
int ringbuffer_used_space(RINGBUFFER_T *buffer);
int ringbuffer_read(RINGBUFFER_T *buffer, char *target, int amount);
int ringbuffer_write(RINGBUFFER_T *buffer, char *data, int length);
int ringbuffer_peek(RINGBUFFER_T *buffer, char *c, int offset);
int ringbuffer_slurp(RINGBUFFER_T *buffer, char *buf);
int ringbuffer_spin(RINGBUFFER_T *buffer, int offset);
int ringbuffer_isfull(RINGBUFFER_T *buffer);
int ringbuffer_isempty(RINGBUFFER_T *buffer);

#endif

