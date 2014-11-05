#include <stdio.h>
#include <stdlib.h>

#include "list.h"
#include "queue.h"


static void print_queue(const QUEUE_T *queue) {
	LLIST_ENTRY_T *element;
	int *data, size, i;
	fprintf(stdout, "QUEUE_T size is %d\n", size = queue_size(queue));
	i = 0;
	element = list_head(queue);
	while (i < size) {
		data = list_data(element);
		fprintf(stdout, "queue[%03d]=%03d\n", i, *data);
		element = list_next(element);
		i++;
	}
	return;
} // end print_queue

int main(int argc, char **argv) {
	QUEUE_T              queue;
	int                *data, i;

	queue_init(&queue, free);
	if (queue_is_empty(&queue))
		fprintf(stdout, "Queue is empty\n");
	else
		fprintf(stdout, "Queue is not empty\n");

	fprintf(stdout, "Enqueuing 10 elements\n");

	for (i = 0; i < 10; i++) {
		if ((data = (int *)malloc(sizeof(int))) == NULL)
			return 1;

		*data = i + 1;

		if (queue_push(&queue, data) != 0)
			return 1;

	}

	print_queue(&queue);
	fprintf(stdout, "Checking if the queue is empty\n");
	if (queue_is_empty(&queue))
		fprintf(stdout, "Queue is empty\n");
	else
		fprintf(stdout, "Queue is not empty\n");

	fprintf(stdout, "Dequeuing 5 elements\n");

	for (i = 0; i < 5; i++) {
		if (queue_pop(&queue, (void **)&data) == 0)
			free(data);
		else
			return 1;

	}

	print_queue(&queue);
	fprintf(stdout, "Enqueuing 100 and 200\n");

	if ((data = (int *)malloc(sizeof(int))) == NULL)
		return 1;

	*data = 100;
	if (queue_push(&queue, data) != 0)
		return 1;

	if ((data = (int *)malloc(sizeof(int))) == NULL)
		return 1;

	*data = 200;
	if (queue_push(&queue, data) != 0)
		return 1;

	print_queue(&queue);
	if ((data = queue_peek(&queue)) != NULL)
		fprintf(stdout, "Peeking at the head element...Value=%03d\n", *data);
	else
		fprintf(stdout, "Peeking at the head element...Value=NULL\n");

	print_queue(&queue);
	fprintf(stdout, "Dequeuing all elements\n");

	while (queue_size(&queue) > 0) {
		if (queue_pop(&queue, (void **)&data) == 0)
			free(data);
   
	}

	if ((data = queue_peek(&queue)) != NULL)
		fprintf(stdout, "Peeking at an empty queue...Value=%03d\n", *data);
	else
		fprintf(stdout, "Peeking at an empty queue...Value=NULL\n");

	fprintf(stdout, "Checking to see if the queue is empty\n"); 
	if (queue_is_empty(&queue))
		fprintf(stdout, "Queue is empty\n");
	else
		fprintf(stdout, "Queue is not empty\n");

	fprintf(stdout, "Destroying the queue\n");
	queue_destroy(&queue);
	return 0;

} // end main

