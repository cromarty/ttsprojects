#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <sys/select.h>
#include <sys/un.h>
#include <unistd.h>
#include <netdb.h>
#include <errno.h>

#include <fcntl.h>

#define DEFAULT AI_ALL | AI_V4MAPPED



int unix_connect(const char *path, int socktype)
{
	struct sockaddr_un addr;
	int sock, savedErrno;

	if (path == NULL || strlen(path) >= sizeof(addr.sun_path) - 1)
	{
		errno = EINVAL;
		return -1;
	}

	memset(&addr, 0, sizeof(struct sockaddr_un));
	addr.sun_family = AF_UNIX;
	if (strlen(path) >= sizeof(addr.sun_path))
	{
		errno = ENAMETOOLONG;
		return -1;
	}

	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);

	sock = socket(AF_UNIX, socktype, 0);
	if (sock == -1)
		return -1;

	if (connect(sock, (struct sockaddr *) &addr, sizeof(struct sockaddr_un)) == -1)
	{
		savedErrno = errno;
		close(sock);                      /* Might change 'errno' */
		errno = savedErrno;
		return -1;
	}

	return sock;
} // end unix_connect

int inet_connect(const char *host, const char *service, int port, int socktype)
{
	struct addrinfo hints;
	struct addrinfo *result, *rp;

	int sock, s, errno;
	char serv[32];

	if ( (service == NULL ) && (port == 0) )
		return -1;

	if (service == NULL)
		sprintf(serv, "%d", port);
	else
		sprintf(serv, "%s", service);

	memset(&hints, 0, sizeof(struct addrinfo));
	hints.ai_canonname = NULL;
	hints.ai_addr = NULL;
	hints.ai_next = NULL;
	hints.ai_family = AF_INET;
	hints.ai_socktype = socktype;

	s = getaddrinfo(host, serv, &hints, &result);
	if (s != 0)
	{
		errno = ENOSYS;
		return -1;
	}

	/* Walk through returned list until we find an address structure that can be used to successfully connect a socket */

	for (rp = result; rp != NULL; rp = rp->ai_next )
	{
		sock = socket(rp->ai_family, rp->ai_socktype, rp->ai_protocol);
		if (sock == -1)
			continue;                   /* On error, try next address */

		if (connect(sock, rp->ai_addr, rp->ai_addrlen) != -1 )
			break;                      /* Success */

		/* Connect failed: close this socket and try next address */
		close(sock);
	}

	freeaddrinfo(result);

	return (rp == NULL) ? -1 : sock;
} // end inet_connect
