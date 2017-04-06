#ifndef SPEECHD_H
#define SPEECHD_H


#define SD_COMM_METHOD_ERROR -1
#define SD_COMM_METHOD_UNKNOWN 0
#define SD_COMM_METHOD_UNIX 1
#define SD_COMM_METHOD_INET 2



int read_speechd_address_var(char *host, int *nPort);

#endif


