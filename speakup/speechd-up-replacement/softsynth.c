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


int parse_softsynth_buffer(int bytesleft) {
	int err, headptr;
	int bytesparsed = 0, backup = 0;
	char head;


	headptr = RING_BUFFER_HEAD_POS(softbuffer);
	while(bytesleft)
	{
		head = RING_BUFFER_PEEK(softbuffer);
		if (head == DTLK_COMMAND) {
			if (bytesleft == 1)
				break;

			/* leave it for next time */
			break;
		}

		if (head < DTLK_SPACE)
		{
			err = parse_softsynth_command(&bytesparsed, &bytesleft, head);
			if (err < 0)
			{
				/*
				* err of less than zero indicates parse_softsynth_command was not able to complete the command before it
				* hit the end of the available data.  the pointer will be left at the start of the command
				* so it will be at the head of the buffer next time around.
				*/
				return bytesparsed;
			}
			/* in parse_softsynth_command_payload we must have got a complete command and dispatched it */
			continue;
		}
	} // while(bytesleft)

	return bytesparsed;

} // end parse_softsynth_buffer

