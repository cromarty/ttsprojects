#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
AC_CONFIG_SRCDIR([test03/testlib03.c])

dnl Checks for programs

AC_PROG_CC

dnl Checks for libraries


dnl Checks for header files

AC_CHECK_HEADERS([stdlib.h string.h unistd.h])

dnl Checks for typedefs, structures, and compiler characteristics.

AC_TYPE_INT32_T
AC_TYPE_UINT8_T

dnl Checks for library functions.

AC_FUNC_MALLOC
AC_CHECK_FUNCS([memset])

AC_CONFIG_FILES([
 Makefile
 test00/Makefile
 test01/Makefile
 test02/Makefile
 test03/Makefile
 test04/Makefile
])
AC_OUTPUT
