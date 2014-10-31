#ifndef DEBUG_H
#define DEBUG_H

#define DEBUG_ENABLED

#ifdef DEBUG_ENABLED

#define LOGFILE 1
#define LOGSTDOUT 2

#define LOGTYPE (LOGFILE|LOGSTDOUT)

#define LOGLEVEL 5

#define LOGLEVEL_0 0
#define LOGLEVEL_1 1
#define LOGLEVEL_2 2
#define LOGLEVEL_3 3
#define LOGLEVEL_4 4
#define LOGLEVEL_5 5

#define ENTER(ll, text) ilctts_debug_enter(ll, text)
#define INFO(ll, text) ilctts_debug_info(ll, text)
#define SHOW(ll, format,...) ilctts_debug_show(ll, format,__VA_ARGS__);
#define SHOW_TIME(ll, text) ilctts_debug_time(text);

void ilctts_debug_enter(int loglevel, const char* text);
void ilctts_debug_info(int loglevel, const char* text);
void ilctts_debug_show(int loglevel, const char* format,...);
void ilctts_debug_time(int loglevel, const char* text);

#else

#define SHOW(ll, format,...)
#define SHOW_TIME(ll, text)
#define ENTER(ll, text)

#endif


#endif
