/*
*
* debug.c - Debug routines
*
* Functions that provide debug messages and log entries.
*
* Copyright (C) 2014, Mike Ray, <mike.ray@btinternet.com>
*
* This is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 3, or (at your option) any later
* version.
*
* This software is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this package; see the file COPYING.  If not, write to the Free
* Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
* 02110-1301, USA.
*
*--code--*/
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

void ilctts_debug_enter(int loglevel, const char* text) {
	if (loglevel > LOGLEVEL)
		return;

	struct timeval tv;
	gettimeofday(&tv, NULL);                  

	if (LOGTYPE & LOGFILE) {
		if (!fd_log) {
			ilctts_debug_init();
		}

		if (fd_log) {
			fprintf(fd_log, "%03d.%03dms > ENTER %s\n",(int)(tv.tv_sec%1000), (int)(tv.tv_usec/1000), text);
		}
	}
	if (LOGTYPE & LOGSTDOUT)
		fprintf(stderr, "%03d.%03dms > ENTER %s\n",(int)(tv.tv_sec%1000), (int)(tv.tv_usec/1000), text);

} // end ilctts_debug_enter

void ilctts_debug_info(int loglevel, const char* text) {
	if (loglevel > LOGLEVEL)
		return;

	struct timeval tv;
	gettimeofday(&tv, NULL);                  

	if (LOGTYPE & LOGFILE) {
		if (!fd_log) {
			ilctts_debug_init();
		}

		if (fd_log) {
			fprintf(fd_log, "%03d.%03dms > %s\n",(int)(tv.tv_sec%1000), (int)(tv.tv_usec/1000), text);
		}
	}
	if (LOGTYPE & LOGSTDOUT)
		fprintf(stderr, "%03d.%03dms > %s\n",(int)(tv.tv_sec%1000), (int)(tv.tv_usec/1000), text);

} // end ilctts_debug_info


void ilctts_debug_show(int loglevel, const char *format, ...) {
	if (loglevel > LOGLEVEL)
		return;

	struct timeval tv;
	gettimeofday(&tv, NULL);                  

	va_list args;
	va_start(args, format);
	if (LOGTYPE & LOGFILE) {
		if (!fd_log) {
			ilctts_debug_init();
		}
		if (fd_log) {
			fprintf(fd_log, "%03d.%03dms > ",(int)(tv.tv_sec%1000), (int)(tv.tv_usec/1000));
			vfprintf(fd_log, format, args);
			fprintf(stderr, "\n");
		}  
	}
	if (LOGTYPE & LOGSTDOUT) {
		fprintf(stderr, "%03d.%03dms > ",(int)(tv.tv_sec%1000), (int)(tv.tv_usec/1000));
		vfprintf(stderr, format, args);
		fprintf(stderr, "\n");
	}

	va_end(args);

} // end ilctts_debug_show



void ilctts_debug_time(int loglevel, const char* text) {
	if (loglevel > LOGLEVEL)
		return;

	struct timeval tv;
	gettimeofday(&tv, NULL);                  
	if (LOGTYPE & LOGFILE) {
		if (!fd_log) {
			ilctts_debug_init();
		}
		if (fd_log) {
			fprintf(fd_log, "%03d.%03dms > %s\n",(int)(tv.tv_sec%1000), (int)(tv.tv_usec/1000), text);
		}
	}

	if (LOGTYPE & LOGSTDOUT)
		fprintf(stderr, "%03d.%03dms > %s\n",(int)(tv.tv_sec%1000), (int)(tv.tv_usec/1000), text);

} // end ilctts_debug_time 


void ilctts_debug_error(const char *format, ...) {
	va_list args;
	va_start(args, format);
	if (LOGTYPE & LOGFILE) {
		if (!fd_log) {
			ilctts_debug_init();
		}
		if (fd_log) {
			vfprintf(fd_log, format, args);
		}  
	}
	if (LOGTYPE & LOGSTDOUT)
		vfprintf(stderr, format, args);

	va_end(args);

} // end ilctts_debug_error



#endif
