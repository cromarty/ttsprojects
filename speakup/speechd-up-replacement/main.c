#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include "net.h"
#include "speakup.h"
#include "speechd.h"

#define BUFFER_SIZE 1024
#define SS_NONBLOCK 1
#define SS_SEC_TIMEOUT 0
#define SS_USEC_TIMEOUT 500000

#define SD_COMM_METHOD_ERROR -1
#define SD_COMM_METHOD_UNKNOWN 0
#define SD_COMM_METHOD_UNIX 1
#define SD_COMM_METHOD_INET 2


int main()
{
	int ss, err, bytesRead;
	int nMethod, nPort;
	char host[1024];

	memset(host, 0, 1024);
	nPort = 0;

	nMethod = read_speechd_address_var(host, &nPort);
	if ( nMethod == SD_COMM_METHOD_ERROR )
	{
		printf("error in read_speechd_address_var\n");
		return 1;
	}

	fd_set readFDS, errorFDS;
	struct timeval ssTimeOut;
	char *buf = malloc(BUFFER_SIZE);

	ss = open_softsynth(SS_NONBLOCK);
	if (ss == -1)
	{
		perror("open_softsynth");
		return 1;
	}

	printf("Successfully opened soft synth\n");

	ssTimeOut.tv_sec = SS_SEC_TIMEOUT;
	ssTimeOut.tv_usec = SS_USEC_TIMEOUT;

	FD_ZERO(&readFDS);
	FD_SET(0, &readFDS);
	FD_ZERO(&errorFDS);
	FD_SET(0, &errorFDS);

	err = select(1, &readFDS, NULL, &errorFDS, &ssTimeOut);
	if (err = -1)
	{
		perror("select");
		close_softsynth(ss);
	}
	if (FD_ISSET(0, &errorFDS))
	{
		printf("Some kind of error in select\n");
		close_softsynth(ss);
		return 1;
	}
	if (err == 0)
	{
		printf("No data available after five seconds\n");
		close_softsynth(ss);
		return 0;
	}
	printf("There is data\n");
	bytesRead = read(ss, buf, 32);
	printf("Read %d bytes from soft synth\n", bytesRead);
	printf("Data: %s\n", buf);
	close_softsynth(ss);
	return 0;
}
