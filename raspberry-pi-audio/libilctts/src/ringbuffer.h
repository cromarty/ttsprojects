/*
*
* ringbuffer.h - Header file for ringbuffer.c
*
* Header file for ringbuffer.c. As described in ringbuffer.c, this is a data
* buffer that is pure bytes and not a FIFO of complex data type pointers.
*
* Copyright (C) 2014, Mike Ray, <mike.ray@btinternet.com>
*
* This is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1, or (at your option) any later
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
#ifndef RING_BUFFER_H
#define RING_BUFFER_H


typedef struct {
    void *buffer;
    int length;
    int head;
    int tail;
} RINGBUFFER_T;

RINGBUFFER_T *ringbuffer_init(int length);
void ringbuffer_destroy(RINGBUFFER_T *buffer);
int ringbuffer_freespace(RINGBUFFER_T *buffer);
int ringbuffer_used_space(RINGBUFFER_T *buffer);
int ringbuffer_read(RINGBUFFER_T *buffer, void *target, int amount);
int ringbuffer_write(RINGBUFFER_T *buffer, void *data, int length);
int ringbuffer_slurp(RINGBUFFER_T *buffer, void *buf);
int ringbuffer_spin(RINGBUFFER_T *buffer, int offset);
int ringbuffer_isfull(RINGBUFFER_T *buffer);
int ringbuffer_isempty(RINGBUFFER_T *buffer);

#endif

