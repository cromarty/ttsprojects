#ifndef SOFTSYNTH_H
#define SOFTSYNTH_H

#define BUFFER_SIZE 1024
#define SS_NONBLOCK 1

#define DTLK_COMMAND 0x01
#define DTLK_STOP 0x18

#define DTLK_RESET 0x48
#define DTLK_PLUS_SIGN 0x2b
#define DTLK_MINUS_SIGN 0x2d

#define DTLK_PITCH 0x70
#define DTLK_PUNCTUATION 0x62
#define DTLK_FREQUENCY 0x66
#define DTLK_RATE 0x73
#define DTLK_VOLUME 0x76
#define DTLK_UNKNOWN 0x78
#define DTLK_VOICE 0x6f

typedef struct dtlkcmd {
	int type;
	int set;
	int rel;
} dtlkcommand;

int open_softsynth(int ssFlags);
int close_softsynth(int ss);
int read_softsynth(int softsynthfd);
int parse_softsynth_buffer(int bytesleft);


#endif




