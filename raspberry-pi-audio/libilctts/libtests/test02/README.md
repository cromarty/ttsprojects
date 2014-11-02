
## testlib02 ##

This version of the test-harness is the first which tests the producer/consumer 
matched pair of functions.

In this code the producer is a function in testlib.c and the consumer is the 
ringbuffer consumer thread in the library.

The producer function in testlib.c reads from a raw PCM file in chunks and 
writes the data into the ring buffer.

The consumer thread in the library reads the data from the ring buffer in chunks 
and submits the data for rendering on the GPU via the OMX IL library code.

