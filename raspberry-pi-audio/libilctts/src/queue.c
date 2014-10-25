#include <stdlib.h>

//#include "list.h"
//#include "queue.h"
#include "ilctts_lib.h"

int queue_enqueue(QUEUE_T *queue, const void *data) {
	return list_insert_next(queue, list_tail(queue), data);
} // end queue_enqueue


int queue_dequeue(QUEUE_T *queue, void **data) {
	return list_remove_next(queue, NULL, data);
} // end 	queue_dequeue
