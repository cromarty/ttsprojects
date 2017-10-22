/*
*
* logging.c - Logging functions
*
* Logging function for the library libpipcmrender.so.
* See the top-level README file for details of what the library does.
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
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/types.h>

#include "pipcmrender_lib.h"
#include "logging.h"


void open_log(PCMRENDER_STATE_T *st) {
	char logname[64];
	if (geteuid() != 0) {
		st->logging.level = 0;
		return;
	}

	sprintf(logname, "%s.%d.%s", "/var/log/pipcmrender",getpid(), "log");
	st->logging.logfp = fopen(logname, "w");
	if (st->logging.logfp == NULL) {
		st->logging.level = 0;
	}

	return;
} // end open_log


int log_message(int level, const char *message, PCMRENDER_STATE_T *st) {
	time_t t = time(NULL);
	struct tm tm = *localtime(&t);
	if ((st->logging.level == 0) || (st->logging.logfp == NULL))
		return 0;

	if (st->logging.level >= level) {
 	fprintf(st->logging.logfp,
			"[%d-%d-%d %d:%d:%d][%d] %s\n",
			tm.tm_year + 1900,
			tm.tm_mon + 1,
			tm.tm_mday,
			tm.tm_hour,
			tm.tm_min,
			tm.tm_sec,
			getpid(),
			message
		);
	}

	return 0;
} // end log_message
