#ifndef QUEUE_H
#define QUEUE_H

#include <stdlib.h>

#include "list.h"


typedef LLIST_T QUEUE_T;


#define queue_init list_init
#define queue_destroy list_destroy

int queue_enqueue(QUEUE_T *queue, const void *data);
int queue_dequeue(QUEUE_T *queue, void **data);

#define queue_peek(queue) ((queue)->head == NULL ? NULL : (queue)->head->data)
#define queue_size list_size

#endif
