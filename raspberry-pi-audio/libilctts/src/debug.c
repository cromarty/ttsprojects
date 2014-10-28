#include <stdio.h>
#include <stdarg.h>

#include "debug.h"

#ifdef DEBUG_ENABLED
#include <sys/time.h>
#include <unistd.h>

static FILE* fd_log=NULL;
static const char* FILENAME="/tmp/libilctts.log";

void ilctts_debug_init() {
	if((fd_log = fopen(FILENAME,"a")) != NULL)
		setvbuf(fd_log, NULL, _IONBF, 0);
} // end ilctts_debug_init

void ilctts_debug_enter(const char* text) {
	struct timeval tv;
	gettimeofday(&tv, NULL);                  
	if (!fd_log) {
		ilctts_debug_init();
	}

	if (fd_log) {
		fprintf(fd_log, "%03d.%03dms > ENTER %s\n",(int)(tv.tv_sec%1000), (int)(tv.tv_usec/1000), text);
	}
	fprintf(stderr, "%03d.%03dms > ENTER %s\n",(int)(tv.tv_sec%1000), (int)(tv.tv_usec/1000), text);
} // end ilctts_debug_enter


void ilctts_debug_show(const char *format, ...) {
	va_list args;
	va_start(args, format);
	if (!fd_log) {
		ilctts_debug_init();
	}
	if (fd_log) {
		vfprintf(fd_log, format, args);
	}  
	vfprintf(stderr, format, args);
	va_end(args);
} // end ilctts_debug_show


void ilctts_debug_time(const char* text) {
	struct timeval tv;
	gettimeofday(&tv, NULL);                  
	if (!fd_log) {
		ilctts_debug_init();
	}
	if (fd_log) {
		fprintf(fd_log, "%03d.%03dms > %s\n",(int)(tv.tv_sec%1000), (int)(tv.tv_usec/1000), text);
	}
	fprintf(stderr, "%03d.%03dms > %s\n",(int)(tv.tv_sec%1000), (int)(tv.tv_usec/1000), text);
} // end ilctts_debug_time 

#endif
