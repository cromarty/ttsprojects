#include <stdlib.h>

#include "ilctts_lib.h"

int queue_push(QUEUE_T *queue, const void *data) {
	return list_insert_next(queue, list_tail(queue), data);
} // end queue_push


int queue_pop(QUEUE_T *queue, void **data) {
	return list_remove_next(queue, NULL, data);
} // end 	queue_pop
