#ifndef RING_BUFFER_H
#define RING_BUFFER_H


typedef struct {
    void *buffer;
    int length;
    int head;
    int tail;
} RINGBUFFER_T;

RINGBUFFER_T *ringbuffer_init(int length);
void ringbuffer_destroy(RINGBUFFER_T *buffer);
int ringbuffer_freespace(RINGBUFFER_T *buffer);
int ringbuffer_used_space(RINGBUFFER_T *buffer);
int ringbuffer_read(RINGBUFFER_T *buffer, void *target, int amount);
int ringbuffer_write(RINGBUFFER_T *buffer, void *data, int length);
int ringbuffer_slurp(RINGBUFFER_T *buffer, void *buf);
int ringbuffer_spin(RINGBUFFER_T *buffer, int offset);
int ringbuffer_isfull(RINGBUFFER_T *buffer);
int ringbuffer_isempty(RINGBUFFER_T *buffer);

#endif

