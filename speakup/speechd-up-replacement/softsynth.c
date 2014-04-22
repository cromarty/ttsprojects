#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include "softsynth.h"


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
	char buf[BUFFER_SIZE];
	int bytesread;
	int err;

	memset(buf, 0, BUFFER_SIZE);

	bytesread = read(softsynthfd, buf, BUFFER_SIZE - 1);
	if (bytesread < 0)
		return -1;

	if (bytesread == 0)
	{
		/* end of file, not likely with the soft synth */
		return 0;
	}
	/* we have bytesread bytes */
	parse_buffer(buf);
	return bytesread;
} // end read_soft_synth


int parse_buffer(const char *buf)
{
	int buflen, i;
	buflen = strlen(buf);

	for ( i = 0 ; i < buflen ; i++ )
	{
	}

} // end parse_buffer
