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


void list_init(LLIST_T *list, void (*destroy)(void *data));
void list_destroy(LLIST_T *list);
int list_insert_next(LLIST_T *list, LLIST_ENTRY_T *element, const void *data);
int list_remove_next(LLIST_T *list, LLIST_ENTRY_T *element, void **data);

#define list_size(list) ((list)->size)
#define list_head(list) ((list)->head)
#define list_tail(list) ((list)->tail)
#define list_is_head(list, element) ((element) == (list)->head ? 1 : 0)
#define list_is_tail(element) ((element)->next == NULL ? 1 : 0)
#define list_is_empty(list) ((list)->size == 0 ? 1 : 0)
#define list_data(element) ((element)->data)
#define list_next(element) ((element)->next)
#define list_append(list, data) (list_insert_next(list, ((list)->tail), data))

#define queue_init list_init
#define queue_destroy list_destroy

int queue_push(QUEUE_T *queue, const void *data);
int queue_pop(QUEUE_T *queue, void **data);

#define queue_peek(queue) ((queue)->head == NULL ? NULL : (queue)->head->data)
#define queue_is_empty(list) (list_is_empty(list))
#define queue_size list_size

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

