/*
*
* debug.h - Debug routines header file.
*
* Header file for the debug function code contained in debug.c
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
#ifndef DEBUG_H
#define DEBUG_H

#define DEBUG_ENABLED

#ifdef DEBUG_ENABLED

#define LOGFILE 1
#define LOGSTDOUT 2

#define LOGTYPE (LOGFILE)

#define LOGLEVEL 5

#define LOGLEVEL_0 0
#define LOGLEVEL_1 1
#define LOGLEVEL_2 2
#define LOGLEVEL_3 3
#define LOGLEVEL_4 4
#define LOGLEVEL_5 5

#define ENTER(ll, text) ilctts_debug_enter(ll, text)
#define INFO(ll, text) ilctts_debug_info(ll, text)
#define SHOW(ll, format,...) ilctts_debug_show(ll, format,__VA_ARGS__);
#define SHOW_TIME(ll, text) ilctts_debug_time(text);
#define ERROR(format,...) ilctts_debug_error(format,__VA_ARGS__);

void ilctts_debug_enter(int loglevel, const char* text);
void ilctts_debug_info(int loglevel, const char* text);
void ilctts_debug_show(int loglevel, const char* format,...);
void ilctts_debug_time(int loglevel, const char* text);
void ilctts_debug_error(const char* format,...);

#else

#define SHOW(ll, format,...)
#define SHOW_TIME(ll, text)
#define ENTER(ll, text)
#define ERROR(ll, format,...)

#endif


#endif
