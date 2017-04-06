#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "speechd.h"


int read_speechd_address_var(char *host, int *nPort)
{
	char *buf;
	int nMethod = SD_COMM_METHOD_UNKNOWN;
	unsigned long i;
	char *chMethod;

	*nPort = 0;

	buf = getenv("SPEECHD_ADDRESS");
	if (buf == NULL)
		return SD_COMM_METHOD_ERROR;

	chMethod = strstr(buf, "unix_socket");
	if ( chMethod != NULL )
	{
		nMethod = SD_COMM_METHOD_UNIX;
		/* found unix_socket so move the buffer pointer */
		if ( strlen(buf) == strlen("unix_socket"))
			return SD_COMM_METHOD_ERROR;
		buf += (strlen("unix_socket")+1);
	}

	if ( nMethod == SD_COMM_METHOD_UNKNOWN )
	{
		chMethod = strstr(buf, "inet_socket");
		if ( chMethod == NULL )
			return SD_COMM_METHOD_ERROR;

		/* here it's inet_socket */
		if ( strlen(buf) == strlen("inet_socket") )
			return SD_COMM_METHOD_ERROR;
		buf += (strlen("inet_socket") + 1);
		nMethod = SD_COMM_METHOD_INET;
	}

	/* what method did we find? */
	switch(nMethod)
	{
		case SD_COMM_METHOD_UNIX:
		{
			/* host is just rest of string and is the path to the unix domain socket */
			strcpy(host, buf);
			if (strlen(host) == 0 )
				return SD_COMM_METHOD_ERROR;
			break;
		}
		case SD_COMM_METHOD_INET:
		{
			/* we need to further split the string to extract host and port */
			i = strcspn(buf, ":");
			if ( i == strlen(buf))
				return SD_COMM_METHOD_ERROR;
			strncpy(host, buf, i);
			buf+=(i+1);
			if ( strlen(buf) == 0 )
				return SD_COMM_METHOD_ERROR;
			*nPort = atoi(buf);
			break;
		}
		default:
	{
			return SD_COMM_METHOD_ERROR;
		}
	} // end switch

//free(buf);
	return nMethod;
} // end read_speechd_address_var




