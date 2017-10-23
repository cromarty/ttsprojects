AC_PREREQ([2.69])
AC_INIT([speehd-up], [0.4], [BUG-REPORT-ADDRESS])
AM_INIT_AUTOMAKE
AC_PREFIX_DEFAULT = /usr
AC_CONFIG_SRCDIR([src/speechd-up.c])
AC_CONFIG_HEADERS([config.h])

dnl Checks for programs.

AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_SED

dnl Checks for header files.

AC_CHECK_HEADERS([fcntl.h stdlib.h string.h unistd.h])

dnl Checks for typedefs, structures, and compiler characteristics.

AC_TYPE_SIZE_T

dnl Checks for library functions.

AC_FUNC_MALLOC
AC_CHECK_FUNCS([select strdup strerror strtol])

AC_CONFIG_FILES([
		Makefile
	config/Makefile
		src/Makefile
	])

AC_OUTPUT
