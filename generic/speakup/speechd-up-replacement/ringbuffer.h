#ifndef RING_BUFFER_H
#define RING_BUFFER_H


typedef struct {
    char *buffer;
    int length;
    int head;
    int tail;
} ringbuffer;

ringbuffer *ringbuffer_init(int length);
void ringbuffer_destroy(ringbuffer *buffer);
int ringbuffer_freespace(ringbuffer *buffer);
int ringbuffer_usedspace(ringbuffer *buffer);
int ringbuffer_read(ringbuffer *buffer, char *target, int amount);
int ringbuffer_write(ringbuffer *buffer, char *data, int length);
int ringbuffer_peek(ringbuffer *buffer, char *c, int offset);
int ringbuffer_slurp(ringbuffer *buffer, char *buf);
int ringbuffer_spin(ringbuffer *buffer, int offset);
int ringbuffer_isfull(ringbuffer *buffer);
int ringbuffer_isempty(ringbuffer *buffer);

#endif

