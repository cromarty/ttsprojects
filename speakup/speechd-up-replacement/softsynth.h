#ifndef SOFTSYNTH_H
#define SOFTSYNTH_H

#define BUFFER_SIZE 1024
#define SS_NONBLOCK 1
#define SS_SEC_TIMEOUT 0
#define SS_USEC_TIMEOUT 500000




int open_softsynth(int ssFlags);
int close_softsynth(int ss);
int read_softsynth(int softsynthfd);
int parse_buffer(const char *buf);


#endif




