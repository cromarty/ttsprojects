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
int ringbuffer_read(ringbuffer *buffer, char *target, int amount);
int ringbuffer_write(ringbuffer *buffer, char *data, int length);
int ringbuffer_peek(ringbuffer *buffer, char *c);
int ringbuffer_slurp(ringbuffer *buffer, char *buf);


#define RING_BUFFER_SIZE(B) ((B)->length - 1 )
#define RING_BUFFER_DATA_SIZE(B) (((B)->tail + 1) % (B)->length - (B)->head - 1)
#define RING_BUFFER_FREE_SPACE(B) ((B)->length - RING_BUFFER_DATA_SIZE(B) - 1)
#define RING_BUFFER_IS_FULL(B) (RING_BUFFER_DATA_SIZE((B)) - (B)->length == 0)
#define RING_BUFFER_IS_EMPTY(B) (RING_BUFFER_DATA_SIZE((B)) == 0)
#define RING_BUFFER_HEAD(B)  ((B)->head)
#define RING_BUFFER_TAIL(B)  ((B)->tail)
#define RING_BUFFER_SPIN(B, A)  (A > RING_BUFFER_DATA_SIZE(B) ? -1 : ((B)->head = ((B)->head + (A)) % (B)->length) )
#define RING_BUFFER_FLUSH(B) ((B)->head = (B)->tail = 0)



#endif

