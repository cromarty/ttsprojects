/*
*
* logging.h - Header file for logging.c
*
* Header file for the logging functions source file. See logging.c
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

#ifndef LOGGING_H
#define LOGGING_H
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "pipcmrender_lib.h"


#define LOGGING

#ifdef LOGGING

#define LOGMESSAGE(a,b,c) log_message(a,b,c)
#else
#define LOGMESSAGE
#endif


void open_log(PCMRENDER_STATE_T *st);
int log_message(int level, const char *message, PCMRENDER_STATE_T *st);
	
#endif

