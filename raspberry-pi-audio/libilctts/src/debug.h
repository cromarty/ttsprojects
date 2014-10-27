#ifndef DEBUG_H
#define DEBUG_H

//#define DEBUG_ENABLED

#ifdef DEBUG_ENABLED
#define ENTER(text) ilctts_debug_enter(text)
#define SHOW(format,...) ilctts_debug_show(format,__VA_ARGS__);
#define SHOW_TIME(text) ilctts_debug_time(text);

void ilctts_debug_enter(const char* text);
void ilctts_debug_show(const char* format,...);
void ilctts_debug_time(const char* text);

#else

#define SHOW(format,...)
#define SHOW_TIME(text)
#define ENTER(text)

#endif


#endif
