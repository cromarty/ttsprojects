/*
*
* core.h - Header file for core.c
*
* Header file for the main core source file. See core.c.
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

#ifndef CORE_H
#define CORE_H
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "ilctts_lib.h"


#define PI 3.14159265

//-- ringbuffer stuff

RINGBUFFER_T *ringbuffer_init(int length);
void ringbuffer_destroy(RINGBUFFER_T *buffer);
int ringbuffer_free_space(RINGBUFFER_T *buffer);
int ringbuffer_used_space(RINGBUFFER_T *buffer);
int ringbuffer_read(RINGBUFFER_T *buffer, void *target, int amount);
int ringbuffer_write(RINGBUFFER_T *buffer, void *data, int length);
int ringbuffer_slurp(RINGBUFFER_T *buffer, void *buf);
int ringbuffer_spin(RINGBUFFER_T *buffer, int offset);
int ringbuffer_is_full(RINGBUFFER_T *buffer);
int ringbuffer_is_empty(RINGBUFFER_T *buffer);
void ringbuffer_flush(RINGBUFFER_T *buffer);

#endif

