#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include "main.h"
#include "softsynth.h"
#include "ringbuffer.h"

extern ringbuffer *softbuffer;
extern sockwritebuffer;


int open_softsynth(int ssFlags)
{
	int ss, flags, err;
	char synth[] = "/dev/softsynth";

	ss = open(synth, O_RDONLY);
	if (ss == -1)
	{
		perror("open_softsynth");
		return -1;
	}

	if (ssFlags & SS_NONBLOCK)
	{
		flags = fcntl(ss, F_GETFL);
		err = fcntl(ss, F_SETFL, flags | O_NONBLOCK);
		if (err == -1)
			return -1;
	}
	return ss;
} // end open_softsynth

int close_softsynth(int ss)
{
	return close(ss);
} // end close_softsynth

int read_softsynth(int softsynthfd)
{
	int bufferspace, bytesread, err;
	char tempbuf[SOFT_SYNTH_BUFFER_SIZE];

	memset(tempbuf, 0, SOFT_SYNTH_BUFFER_SIZE);
	bufferspace = RING_BUFFER_FREE_SPACE(softbuffer);

	bytesread = read(softsynthfd, tempbuf, bufferspace);
	if (bytesread < 0)
		return -1;

	if (bytesread == 0)
	{
		/* end of file, not likely with the soft synth */
		return 0;
	}
	/* we have bytesread bytes, put them in the ring buffer */
	err = ringbuffer_write(softbuffer, tempbuf, bytesread);
	return ( err == -1 ? -2 : bytesread);

} // end read_soft_synth


int parse_softsynth_buffer(int bytesleft)
{
	int bufdatalen, err;
	int bytesparsed = 0;
	char head;

	bufdatalen = RING_BUFFER_DATA(softbuffer);
	if (bufdatalen < 0)
		return -1;

	/*
	* we're not going to take data out of the ring buffer until we complete each coherent chunk.
	* this is because the read may have ended at a place where it splits a command.
	* if the available data ends where it would split a command, move the buffer head pointer up to
	* just before the start of the split command and leave it there to process next time round
	* note that we don't actually remove data from the ring anyway, just manipulate the head and tail pointers
	*/
	while(bytesleft)
	{
		head = RING_BUFFER_PEEK(softbuffer);
		switch(head)
		{
			case DTLK_COMMAND:
				printf("command: %c\n", head);
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
				break;
			case DTLK_INDEX:
				printf("Index: %c\n", head);
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
				break;
			case DTLK_STOP:
				printf("Stop: %c\n", head);
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
				break;
			default:
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
			}
	} // while(bytesleft)

	return bytesparsed;

} // end parse_softsynth_buffer
