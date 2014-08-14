#ifndef PCM_RING_BUFFER_H
#define PCM_RING_BUFFER_H


typedef struct {
    short *pcm;
    int length;
    int head;
    int tail;
} PCM_RING_BUFFER_T;
 

PCM_RING_BUFFER_T *pcm_ring_buffer_init(int length);
void pcm_ring_buffer_destroy(PCM_RING_BUFFER_T *buffer);
int pcm_ring_buffer_free_space(PCM_RING_BUFFER_T *buffer);
int pcm_ring_buffer_used_space(PCM_RING_BUFFER_T *buffer);
int pcm_ring_buffer_read(PCM_RING_BUFFER_T *buffer, short *target, int amount);
int pcm_ring_buffer_write(PCM_RING_BUFFER_T *buffer, short *pcm, int length);
int pcm_ring_buffer_peek(PCM_RING_BUFFER_T *buffer, short *pcm, int offset);
int pcm_ring_buffer_slurp(PCM_RING_BUFFER_T *buffer, short *buf);
void pcm_ring_buffer_flush(PCM_RING_BUFFER_T *buffer);
int pcm_ring_buffer_is_full(PCM_RING_BUFFER_T *buffer);
int pcm_ring_buffer_is_empty(PCM_RING_BUFFER_T *buffer);

#endif

