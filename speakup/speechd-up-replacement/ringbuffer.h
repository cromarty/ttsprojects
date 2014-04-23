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



#define RING_BUFFER_DATA_SIZE(B) (((B)->tail + 1) % (B)->length - (B)->head - 1)
#define RING_BUFFER_FREE_SPACE(B) ((B)->length - (B)->tail - 1)
#define RING_BUFFER_FULL(B) (RING_BUFFER_DATA_SIZE((B)) - (B)->length == 0)
#define RING_BUFFER_EMPTY(B) (RING_BUFFER_DATA_SIZE((B)) == 0)
#define RING_BUFFER_HEAD(B) ((B)->buffer + (B)->head)
#define RING_BUFFER_TAIL(B) ((B)->buffer + (B)->tail)
#define RING_BUFFER_COMMIT_READ(B, A) ((B)->head = ((B)->head + (A)) % (B)->length)
#define RING_BUFFER_COMMIT_WRITE(B, A) ((B)->tail = ((B)->tail + (A)) % (B)->length)
#define RING_BUFFER_HEAD_POS(B)  ((B)->head)
#define RING_BUFFER_TAIL_POS(B)  ((B)->tail)
#define RING_BUFFER_SPIN(B, A)  (A > RING_BUFFER_DATA_SIZE(B) ? -1 : RING_BUFFER_COMMIT_READ(B, A))
#define RING_BUFFER_PEEK(B)   ((B)->buffer[(B)->head])



#endif

