#ifndef NET_H
#define NET_H



int unix_connect(const char *path, int socktype);
int inet_connect(const char *host, const char *service, int port, int socktype);


#endif



