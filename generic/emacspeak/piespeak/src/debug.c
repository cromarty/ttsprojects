/*
*
* Copyright (C) 2017 Mike Ray <mike.ray@btinternet.com>
*
* This is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2, or (at your option)
* any later version.
*
* This software is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this package; see the file COPYING.  If not, write to
* the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301, USA.
*
*--code--*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>

#include "debug.h"


int create_log_file(const char *basename, int flags)
{
	int fd;
	char logname[255];

	sprintf(logname, "%s%d.log",basename,getpid());
	fd = open(logname, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
	if (fd == -1)
		return -1;

	if (flags & CPF_CLOEXEC) {
		flags = fcntl(fd, F_GETFD);

		if (flags == -1)
			return -1;

		flags |= FD_CLOEXEC;

		if (fcntl(fd, F_SETFD, flags) == -1)
			return -1;
	}

	return fd;

} /* end create_log_file */


void debug_log(int fd, const char *format,...)
{
	va_list args;
	char buffer[255];
	memset(buffer, 0, sizeof(buffer));

	va_start(args, format);

	vsprintf(buffer, format, args);
	write(fd, buffer, strlen(buffer));

} /* end debug_log */
