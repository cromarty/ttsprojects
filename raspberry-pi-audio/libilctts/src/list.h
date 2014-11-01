/*
*
* list.h - Header file for list.c
*
* Header file for the code that implements a singly linked-list.
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
#ifndef LIST_H
#define LIST_H
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


typedef struct LLIST_ENTRY_ {
void               *data;
struct LLIST_ENTRY_   *next;
} LLIST_ENTRY_T;


typedef struct LLIST_ {
int                size;
void               (*destroy)(void *data);
LLIST_ENTRY_T           *head;
LLIST_ENTRY_T           *tail;
} LLIST_T;


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


#endif

