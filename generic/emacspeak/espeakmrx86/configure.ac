AC_PREREQ([2.69])
AC_INIT([espeakmrx86], [1.0.0], [mike.ray@btinternet.com])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_CONFIG_SRCDIR([src/server.c])
AC_CONFIG_HEADERS([config.h])

dnl Checks for programs.

AC_PROG_YACC
AC_PROG_CC
# Sometimes Flex is installed as Lex, e.g., NetBSD.
AC_CHECK_PROG([FLEX], [flex lex], [flex])

AM_PROG_LEX

dnl Checks for libraries.

AC_CHECK_LIB([espeak], [espeak_Initialize], [], [AC_MSG_ERROR([espeak_Initialize was not found in libespeak])])
AC_CHECK_LIB([pthread], [pthread_mutex_init], [], [AC_MSG_ERROR([pthread_mutex_init was not found in libpthread])])
AC_CHECK_LIB([pcre], [pcre_compile], [], [AC_MSG_ERROR([pcre_compile was not found in libpcre])])
AC_CHECK_LIB([fl], [yywrap])


dnl Checks for header files.

AC_FUNC_ALLOCA
AC_CHECK_HEADERS([inttypes.h libintl.h malloc.h stddef.h stdlib.h string.h unistd.h])

dnl Checks for typedefs, structures, and compiler characteristics.

AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT8_T
AC_TYPE_SIZE_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT8_T

# Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_CHECK_FUNCS([memset])

AC_CONFIG_FILES([
	Makefile
	src/Makefile
])

AC_OUTPUT
