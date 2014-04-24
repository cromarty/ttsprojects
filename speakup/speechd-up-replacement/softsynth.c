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

	bufdatalen = RING_BUFFER_DATA_SIZE(softbuffer);
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

int parse_softsynth_command(int *bytesparsed, int *bytesleft, char head)
{
	switch(head)
	{
		case DTLK_COMMAND:
			err = parse_softsynth_command_payload(bytesparsed, bytesleft), head;
			/*
			* here err of < 0 means the end of the available buffer was reached before the command was complete,
			* so we will return the error code to parse_softsynth_buffer which will abort and leave the command prefix in the buffer for next time around the loop.
		* don't spin the buffer here
			*/
		case DTLK_IDX:
			err = RING_BUFFER_SPIN(softbuffer, 1);
		*bytesparsed++;
		*bytesleft--;
		break;
		case DTLK_STOP:
			/* execute a ssip stop */
			err = RING_BUFFER_SPIN(softbuffer, 1);
			*bytesparsed++;
			*bytesleft--;
			break;
		default:
			/* i don't know what this command means */
			err = RING_BUFFER_SPIN(softbuffer, 1);
			*bytesparsed++;
			*bytesleft--;
	}
	return err;

} // end parse_softsynth_command

int parse_softsynth_command_payload(int *bytesparsed, int *bytesleft, head)
{
	char param[32];
	int ptr = 0;
	int backup = 0;
	int err;
	memset(param, 0, 32);

	err = RING_BUFFER_SPIN(softbuffer, 1);
	/*
	* the backup counter will be used to reset the buffer head pointer,
	* and the bytesparsed and bytesleft counters
	* if we hit the end of the buffer before the command payload is complete.
	*/
	backup++;
	*bytesparsed++
	*bytesleft--;
	while( (*bytesleft > 0 ) && ( head > DTLK_SPACE ) )
	{
		param[ptr] = head;
		switch(head)
		{
			case DTLK_COMMAND:
				printf("command: %d\n", head);
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
				break;
			case DTLK_IDX:
				printf("Idx: %d\n", head);
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
			case DTLK_PUNCTUATION:
				printf("Punctuation: %c\n", head);
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
				break;
			case DTLK_FREQUENCY:
				printf("Frequency: %c\n", head);
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
				break;
			case DTLK_VOICE:
				printf("Voice: %c\n", head);
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
				break;
			case DTLK_VOLUME:
				printf("Volume: %c\n", head);
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
				break;
			case DTLK_PITCH:
				printf("Pitch: %c\n", head);
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
				break;
			case DTLK_RATE:
				printf("Rate: %c\n", head);
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
				break;
			case DTLK_UNKNOWN:
				printf("Unknown: %c\n", head);
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
				break;
			default:
				err = RING_BUFFER_SPIN(softbuffer, 1);
				bytesleft--;
				bytesparsed++;
			}



} // end parse_softsynth_command

