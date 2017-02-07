#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "debug.h"

void debug_printf_args(const char *format,...) {
	va_list args;
	va_start(args, format);
	vprintf(format,args);
}

void debug_printf(const char *format) {
	printf(format);
}
