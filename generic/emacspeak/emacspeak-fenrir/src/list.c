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
* $Id: emspk-sd.h
*--code--*/

#include <stdlib.h>
#include <string.h>

#include "list.h"

void list_init(List *list, void (*destroy)(void *data)) {
	list->size = 0;
	list->destroy = destroy;
	list->head = NULL;
	list->tail = NULL;
	return;
} /* list_init */

void list_destroy(List *list) {
	void               *data;
	while (list_size(list) > 0) {
		if (list_rem_next(list, NULL, (void **)&data) == 0 && list->destroy !=       NULL) {
			list->destroy(data);
		}
	}
	memset(list, 0, sizeof(List));
	return;
} /* list_destroy */

int list_ins_next(List *list, ListElmt *element, const void *data) {
	ListElmt           *new_element;
	if ((new_element = (ListElmt *)malloc(sizeof(ListElmt))) == NULL)
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
} /* list_ins_next */

int list_rem_next(List *list, ListElmt *element, void **data) {
	ListElmt           *old_element;
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
} /* list_rem_next */
