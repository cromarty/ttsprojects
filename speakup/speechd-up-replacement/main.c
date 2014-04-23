#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <unistd.h>

#include "main.h"
#include "net.h"
#include "softsynth.h"
#include "speechd.h"
#include "ringbuffer.h"

ringbuffer *softbuffer;
ringbuffer *sockreadbuffer;
ringbuffer *sockwritebuffer;


int main()
{
	int softsynthfd;
	int sdsock;
	int i, sockstate = 0;
	int err, bytesread;
	int nSDMethod, nPort;
	struct timeval softsynthtimeout;
	//char buf[BUFFER_SIZE];

	/* will receive either host name or path to unix socket */
	char host[1024];
	memset(host, 0, 1024);

	/* read, write  and error file descriptors for select */
	fd_set readFDS, writeFDS, errorFDS;

	/* only for inet_socket */
	nPort = 0;

	softbuffer = ringbuffer_init(SOFT_SYNTH_BUFFER_SIZE);
	sockreadbuffer = ringbuffer_init(SOCK_READ_BUFFER_SIZE);
	sockwritebuffer = ringbuffer_init(SOCK_WRITE_BUFFER_SIZE);
	/* get the communication method from the SPEECHD_ADDRESS environment variable */
	nSDMethod = read_speechd_address_var(host, &nPort);
	if ( ( nSDMethod == SD_COMM_METHOD_ERROR ) || ( nSDMethod == SD_COMM_METHOD_UNKNOWN ) )
	{
		printf("error in read_speechd_address_var\n");
		return 1;
	}

	softsynthfd = open_softsynth(SS_NONBLOCK);
	if (softsynthfd == -1)
	{
		perror("open_softsynth");
		return 1;
	}

	softsynthtimeout.tv_sec = SS_SEC_TIMEOUT;
	softsynthtimeout.tv_usec = SS_USEC_TIMEOUT;

	/*
	* zero and set read and error file descriptors for select
	*
	* readFDS - will watch softsynth fd and sd socket
	* writeFDS - will watch sd socket
	* errorFDS - will watch softsynth and sd sock
	*/
	FD_ZERO(&readFDS);
	FD_SET(softsynthfd, &readFDS);
	//FD_SET(sdsock, &readFDS);
	//FD_ZERO(&writeFDS);
	//FD_SET(sdsock, &writeFDS);
	FD_ZERO(&errorFDS);
	FD_SET(softsynthfd, &errorFDS);
	//FD_SET(sdsock, &errorFDS);

	/* start the read loop */
	while(1)
	{
		/*
		* select returns 0 if timeout, 1 if activity possible, -1 if error.
		* note that -1 means error in the select function call, not the same as checking the errorFDS for error conditions
		*/
		err = select(FD_SETSIZE, &readFDS, NULL, &errorFDS, NULL);
		if (err < 0)
		{
			perror("select");
			close_softsynth(softsynthfd);
			/* should close socket here too */
			return 1;
		}
		if (err == 0)
		{
			/* time out, continue the loop */
			continue;
		}
		/* activity possible */
		for ( i = 0 ; i < FD_SETSIZE ; ++i )
		{
			/* check the error set first */
			if (FD_ISSET(i, &errorFDS))
			{
				if (i == softsynthfd)
				{
					/* some kind of error associated with the soft synth file descriptor */
				}
				if (i == sdsock)
				{
					/* some kind of error with the server socket */
				}
			} // check error set
			/* check read set */
			if (FD_ISSET(i, &readFDS))
			{
				if ( i == softsynthfd)
				{
					bytesread = read_softsynth(softsynthfd);
					if (bytesread < 0)
					{
						/* bad juju */
					}
					err = parse_softsynth_buffer(bytesread);
				}
				if ( i == sdsock)
				{
					/* read from server socket possible */
				}
			} // readfds set
			//if (FD_ISSET(i, &writeFDS))
			//	/* write to server socket possible */
		} // for
	} // while
	close_softsynth(softsynthfd);
	// close the socket here too
	return 0;
}
