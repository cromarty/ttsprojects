#ifndef DEBUG_H
#define DEBUG_H

#include <stdarg.h>

#define DEBUG_ENABLED

#ifdef DEBUG_ENABLED
#define DEBUG_SHOW_ARGS(format,...) debug_printf_args(format,__VA_ARGS__)
#define DEBUG_SHOW(format)  debug_printf(format)
#else
#define DEBUG_SHOW_ARGS(format,...)
#define DEBUG_SHOW(format)
#endif

#endif
