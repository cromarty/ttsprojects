#ifndef LIST_H
#define LIST_H

#include <stdlib.h>


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
