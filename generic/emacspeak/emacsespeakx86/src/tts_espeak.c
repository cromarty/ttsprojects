#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>
#include <espeak/speak_lib.h>

#include "tts_server.h"
#include "tts_espeak.h"

#include "parser.h"


TTS_STATE_T tts_state;
 
Queue tts_queue;

pthread_mutex_t queue_guard_mutex;
sem_t dispatch_semaphore;


void free_queue_entry(void *data) {
	TTS_QUEUE_ENTRY_T *qe = (TTS_QUEUE_ENTRY_T*)data;
	free((char*)qe->speech);
	free(qe);
	return;
} /* free_queue_entry */

int queue_speech(int entry_type, const char *speech) {
	TTS_QUEUE_ENTRY_T *qe;

   	if ((qe = (TTS_QUEUE_ENTRY_T *)malloc(sizeof(TTS_QUEUE_ENTRY_T))) == NULL)
		return -1;

	if ((qe->speech = (char *)malloc(strlen(speech)+1)) == NULL)
		return -1;

	qe->type = entry_type;
	qe->length = strlen(speech);
	sprintf(qe->speech, speech);

	if (queue_push(&tts_queue, qe) != 0)
		return -1;

	return 0;
} /* queue_speech */

int send_speech(void) {
	int res;
	TTS_QUEUE_ENTRY_T *qe;
	ListElmt *element;

	if (queue_size(&tts_queue) < 1)
		return -1;

	if ( (element = malloc(sizeof(ListElmt))) == NULL)
		return -1;

	queue_pop(&tts_queue, (void*)element);
	qe = (TTS_QUEUE_ENTRY_T*)list_data(element);

	res = espeak_Synth(qe->speech, qe->length+1, 0, POS_CHARACTER, 0, espeakPHONEMES, NULL, NULL);

	free(qe->speech);
	free(element);
	return 0;
} /* send_speech */


int empty_queue(void) {
	queue_destroy(&tts_queue);
	queue_init(&tts_queue, free_queue_entry);
	return 0;
} /* empty_queue */


void *dispatch_thread(void *arg) {
	TTS_QUEUE_ENTRY_T *qe;
	char *speech;
	printf("Started dispatch_thread\n");
	while(1) {
		sem_wait(&dispatch_semaphore);
		while(queue_size(&tts_queue) > 0) {
			pthread_mutex_lock(&queue_guard_mutex);
			/* Is queue size still > 0 after getting mutex lock? */
			if (queue_size(&tts_queue) > 0)
				send_speech();

			pthread_mutex_unlock(&queue_guard_mutex);
		}
	}

	return NULL;
} /* dispatch_thread */


