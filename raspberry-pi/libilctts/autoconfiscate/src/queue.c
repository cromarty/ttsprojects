/*
*
* queue.c - Code that implements a queue data structure (a FIFO)
*
* Code to implement a first-in-first-out (queue) data structure.
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
#include <stdlib.h>

//#include "ilctts_lib.h"
#include "list.h"
#include "queue.h"

int queue_push(QUEUE_T *queue, const void *data) {
	return list_insert_next(queue, list_tail(queue), data);
} // end queue_push


int queue_pop(QUEUE_T *queue, void **data) {
	return list_remove_next(queue, NULL, data);
} // end 	queue_pop
