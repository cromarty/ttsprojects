/*
*
* queue.h - Header file for queue code
*
* Header file that contains data type definitions and function prototypes of the queue functionality provided by queue.c.
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
#ifndef QUEUE_H
#define QUEUE_H
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "list.h"


typedef LLIST_T QUEUE_T;



#define queue_init list_init
#define queue_destroy list_destroy

int queue_push(QUEUE_T *queue, const void *data);
int queue_pop(QUEUE_T *queue, void **data);

#define queue_peek(queue) ((queue)->head == NULL ? NULL : (queue)->head->data)
#define queue_is_empty(list) (list_is_empty(list))
#define queue_size list_size


#endif

