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

#ifndef DEBUG_H
#define DEBUG_H

#include <stdarg.h>

#ifdef DEBUG_MESSAGES
#define DEBUG_SHOW_ARGS(format,...) debug_printf_args(format,__VA_ARGS__)
#define DEBUG_SHOW(format)  debug_printf(format)
#else
#define DEBUG_SHOW_ARGS(format,...)
#define DEBUG_SHOW(format)
#endif

#endif
