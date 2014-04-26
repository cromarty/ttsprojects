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
	int offset, cmdlen;
	char c;
	char cmdbuf[32];
	char textbuf[1024];

	memset(cmdbuf, 0, 32);
	memset(textbuf, 0, 1024);

	/*
	* We won't actually remove bytes from the ring buffer, it is faster and more flexible to just manipulate the head
	* pointer, which is an integer index into the buffer.
	* Need to be careful with the RING_BUFFER_SPIN macro because it does not check
	* whether it tries to spin forward past the tail or backwards past the head of the buffer.
	* Use the offset integer variable to keep count of how many bytes past the head we are peeking, and hence how many
	* bytes to spin the ring buffer when a command or a chunk of text is completed.
	*
	* Not removing the data from the ring also makes it easier for us to leave an incomplete command at the end of the buffer which
	* can probably be completed after the next asynchronous read.
	*/

	while(bytesleft) {
		offset = cmdlen = 0;
		/* peek at the next byte */
		err = ringbuffer_peek(softbuffer, &c, offset);

		if (c == DTLK_STOP) {
			/* A stop command, which has no further parameter associated with it, spin out and continue */
			printf("stop command\n");
			err = RING_BUFFER_SPIN(softbuffer, 1);
			bytesparsed++; bytesleft--;
			continue;
		}
//==== cmdlen and offset still zero
		if (c == DTLK_COMMAND) {
			offset = cmdlen = 1;
			/* peek ahead one byte */
			err = ringbuffer_peek(softbuffer, &c, offset);
			cmdbuf[cmdlen-1] = c;
			if (c == 0x40) {
				/* reset */
				cmdlen++;
//==== cmdlen now 2
				printf("reset command\n");
				err = RING_BUFFER_SPIN(softbuffer, cmdlen);
				bytesparsed +=cmdlen ; bytesleft -= cmdlen;
				continue;
			}
// correct to here
//===== cmdlen now 2
//==== offset now 1
			switch(c)
			{
				case 0x2b: /* + */
					mult = 1;
					cmdlen++;
					break;
				case 0x2d: /* - */
					mult = -1;
					cmdlen++;
					break;
				default: /* not a sign */
					mult = 0;
					break;
			} // switch

			if ( mult != 0) {
				/* move the offset pointer so we can peek ahead of the sign */
				offset++;
			}
//===== offset now 2 if sign else 1
			err = ringbuffer_peek(softbuffer, &c, offset);

			/* while we have bytes left and they are digits */
			while( bytesleft && ( c >= 0x30 ) && (c <= 0x39 ) ) {
//===== offset now 2 if sign else 1
				cmdlen++;
				cmdbuf[offset-1] = c;
				offset++;
				err = ringbuffer_peek(softbuffer, &c, offset);
			} // while bytesleft and digit

			/* if we have run out of bytes before the command is completed by the last alpha character, break out of the parse loop and leave the command for next time */
			if (bytesleft <= cmdlen)
				break;

			/* now get the actual command character */
// we should have a struct for a command and just put the c in 'type'
			switch(c)
			{
				case 0x42: /* B */
				case 0x62: /* b */
					dtlkcmd->type = c;
					break;
				case 0x46: /* F */
				case 0x66: /* f */
					dtlkcmd->type = c;
					break;
				case 0x4f: /* O */
				case 0x6f: /* o */
					dtlkcmd->type = c;
					break;
				case 0x50: /* P * */
				case 0x70: /* p */
					dtlkcmd->type = c;
					break;
				case 0x53: /* S */
				case 0x73: /* s */
					dtlkcmd->type = c;
				case 0x56: /* V */
				case 0x76: /* v */
					dtlkcmd->type = c;
					break;
				case 0x58: /* X */
				case 0x78: /* x */
					dtlkcmd->type = c;
					break;
				default:
					/* what */
		} // switch

		/* finally we have hit the end of the command, spin the ring buffer by the length of the command string */
		err = RING_BUFFER_SPIN(softbuffer, cmdlen);
		bytesparsed += cmdlen; bytesleft -= cmdlen;
		continue;
		} // c == DTLK_COMMAND

		/* something other than a command */
		err = RING_BUFFER_SPIN(softbuffer, 1);
		bytesparsed++; bytesleft--;

	} // while(bytesleft)

	return bytesparsed;

} // end parse_softsynth_buffer

