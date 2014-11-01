/*
*
* list.c - Linked-list functions
*
* Functions that implement a singly linked-list.
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
#include <stdlib.h>
#include <string.h>

//#include "list.h"
#include "ilctts_lib.h"


void list_init(LLIST_T *list, void (*destroy)(void *data)) {
	list->size = 0;
	list->destroy = destroy;
	list->head = NULL;
	list->tail = NULL;
	return;
} // end list_init



void list_destroy(LLIST_T *list) {
	void               *data;
	while (list_size(list) > 0) {
		if (list_remove_next(list, NULL, (void **)&data) == 0 && list->destroy != NULL) {
			list->destroy(data);
		}
	}

	memset(list, 0, sizeof(LLIST_T));

	return;

} // end list_destroy


int list_insert_next(LLIST_T *list, LLIST_ENTRY_T *element, const void *data) {
	LLIST_ENTRY_T           *new_element;

	if ((new_element = (LLIST_ENTRY_T *)malloc(sizeof(LLIST_ENTRY_T))) == NULL)
		return -1;

	new_element->data = (void *)data;

	if (element == NULL) {
		if (list_size(list) == 0)
			list->tail = new_element;

		new_element->next = list->head;
		list->head = new_element;

	} else {
		if (element->next == NULL)
			list->tail = new_element;

		new_element->next = element->next;
		element->next = new_element;

	}

	list->size++;

	return 0;

} // end list_insert_next


int list_remove_next(LLIST_T *list, LLIST_ENTRY_T *element, void **data) {
	LLIST_ENTRY_T           *old_element;

	if (list_size(list) == 0)
		return -1;

	if (element == NULL) {
		*data = list->head->data;
		old_element = list->head;
		list->head = list->head->next;

		if (list_size(list) == 1)
			list->tail = NULL;

	} else {

	if (element->next == NULL)
		return -1;

	*data = element->next->data;
	old_element = element->next;
	element->next = element->next->next;

	if (element->next == NULL)
		list->tail = element;

	}

	free(old_element);
	list->size--;
	return 0;

} // end list_remove_next
