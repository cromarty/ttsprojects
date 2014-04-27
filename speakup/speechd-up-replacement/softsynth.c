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
	bufferspace = ringbuffer_freespace(softbuffer);

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


/*
* This is along function.  I could have broken it into more functions to make it more
* easy to understand but speed is of the essence when parsing the buffer from the soft synth
*/
int parse_softsynth_buffer(int bytesleft) {
	int err, mult;
	int bytesparsed = 0;
	int offset;
	char c;
	char cmdbuf[32];
	char textbuf[1024];


	memset(textbuf, 0, 1024);

	/*
	* We won't actually remove bytes from the ring buffer, it is faster and more flexible to just manipulate the head
	* pointer, which is an integer index into the buffer.
	* Need to be careful with the ringbuffer_spin macro because it does not check
	* whether it tries to spin forward past the tail or backwards past the head of the buffer.
	* Use the offset integer variable to keep count of how many bytes past the head we are peeking, and hence how many
	* bytes to spin the ring buffer when a command or a chunk of text is completed.
	*
	* Not removing the data from the ring also makes it easier for us to leave an incomplete command at the end of the buffer which
	* can probably be completed after the next asynchronous read.
	*/

	while(bytesleft) {
		offset = 0;
		err = ringbuffer_peek(softbuffer, &c, offset);

		if (c == DTLK_STOP) {
			printf("Command: STOP\n");
			err = ringbuffer_spin(softbuffer, (offset+1));
			bytesparsed += (offset+1); bytesleft -= (offset+1);
			continue;
		}

		if (c == DTLK_COMMAND) {
			offset++;
			err = ringbuffer_peek(softbuffer, &c, offset);
			if (c == DTLK_RESET) {
				cmdbuf[0] = c;
				cmdbuf[1] = 0;
				err = ringbuffer_spin(softbuffer, (offset+1));
				bytesparsed += (offset+1) ; bytesleft -= (offset+1);
				printf("Command: %s\n", cmdbuf);
				continue;
			}

			switch(c)
			{
				case DTLK_PLUS_SIGN:
					mult = 1;
					offset++;
					break;
				case DTLK_MINUS_SIGN:
					mult = -1;
					offset++;
					break;
				default: /* not a sign */
					mult = 0;
					break;
			} // switch

			cmdbuf[offset-1] = c;
			if (bytesleft <= offset)
				break;

			err = ringbuffer_peek(softbuffer, &c, offset);

			/* while we have bytes left and they are digits */
			while( bytesleft && ( c >= 0x30 ) && (c <= 0x39 ) ) {
				cmdbuf[offset-1] = c;
				offset++;
				if (bytesleft <= offset)
					break;
				err = ringbuffer_peek(softbuffer, &c, offset);
			} // while bytesleft and digit

			/* if we have run out of bytes before the command is completed by the last alpha character, break out of the parse loop and leave the command for next time */
			if (bytesleft <= offset)
				break;

			/* now get the actual command character */
			switch(c)
			{
				case DTLK_PUNCTUATION: /* b */
					break;
				case DTLK_FREQUENCY: /* f */
					break;
				case DTLK_VOICE: /* o */
					break;
				case DTLK_PITCH: /* p */
					break;
				case DTLK_RATE: /* s */
					break;
				case DTLK_VOLUME: /* v */
					break;
				case DTLK_UNKNOWN: /* x */
					break;
				default:
					/* what */
					break;
		} // switch

		cmdbuf[offset-1] = c;
		cmdbuf[offset] = 0;
		err = ringbuffer_spin(softbuffer, (offset+1));
		bytesparsed += (offset+1); bytesleft -= (offset+1);
		printf("Command: %s\n", cmdbuf);
		continue;
		} // c == DTLK_COMMAND

		/* something other than a command */
		err = ringbuffer_spin(softbuffer, 1);
		bytesparsed++; bytesleft--;

	} // while(bytesleft)
	printf("Out of bytes\n");
	return bytesparsed;

} // end parse_softsynth_buffer

