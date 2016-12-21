#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
AC_CONFIG_SRCDIR([test03/testlib.c])
AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_PROG_CC

# Checks for libraries.
# FIXME: Replace `main' with a function in `-lbcm_host':
AC_CHECK_LIB([bcm_host], [main])
# FIXME: Replace `main' with a function in `-lespeak':
AC_CHECK_LIB([espeak], [main])
# FIXME: Replace `main' with a function in `-lilctts':
AC_CHECK_LIB([ilctts], [main])
# FIXME: Replace `main' with a function in `-lopenmaxil':
AC_CHECK_LIB([openmaxil], [main])
# FIXME: Replace `main' with a function in `-lpthread':
AC_CHECK_LIB([pthread], [main])
# FIXME: Replace `main' with a function in `-lrt':
AC_CHECK_LIB([rt], [main])
# FIXME: Replace `main' with a function in `-lvchiq_arm':
AC_CHECK_LIB([vchiq_arm], [main])
# FIXME: Replace `main' with a function in `-lvcos':
AC_CHECK_LIB([vcos], [main])

# Checks for header files.
AC_CHECK_HEADERS([stdlib.h string.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_INT32_T
AC_TYPE_UINT8_T

# Checks for library functions.
AC_FUNC_MALLOC
AC_CHECK_FUNCS([memset])

AC_CONFIG_FILES([test00/Makefile
                 test01/Makefile
                 test02/Makefile
                 test03/Makefile
                 test04/Makefile])
AC_OUTPUT
