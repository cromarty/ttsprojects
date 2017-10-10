AC_PREREQ([2.69])
AC_INIT([piespeakup], [2.0.0], [mike.ray@btinternet.com])
AM_INIT_AUTOMAKE
AC_PREFIX_DEFAULT(/usr/local)
AC_CONFIG_SRCDIR([src/piespeakup.c])
AC_CONFIG_HEADERS([config.h])

dnl *************************************************
dnl current:revision:age
dnl change (without API) = c:r+1:a
dnl change API = c+1:0:a
dnl add API = c+1:0:a+1
dnl remove API = c+1:0:0
dnl *************************************************


dnl Checks for programs.

AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_SED
AC_PROG_MAKE_SET

dnl Checks for libraries.

# FIXME: Replace `main' with a function in `-lespeak':
AC_CHECK_LIB([espeak], [espeak_Initialize], [], [AC_MSG_ERROR([espeak_Initialize was not found in libespeak])])
AC_CHECK_LIB([pipcmrender], [pipcmrender_initialize], [], [AC_MSG_ERROR([pipcmrender_initialize was not found in libpipcmrender])])
AC_CHECK_LIB([pthread], [pthread_mutex_init], [], [AC_MSG_ERROR([pthread_mutex_init was not found in libpthread])])

dnl Checks for header files.

AC_CHECK_HEADERS([fcntl.h stddef.h stdlib.h string.h unistd.h])

dnl Checks for typedefs, structures, and compiler characteristics.

AC_TYPE_PID_T
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T

dnl Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_CHECK_FUNCS([memmove memset select strdup strrchr])

modulesloaddir='/etc/modules-load.d'
AC_SUBST([modulesloaddir])

systemdunitdir='/lib/systemd/system'
AC_SUBST([systemdunitdir])

piespeakupunitconfdir='/etc/systemd/system'
AC_SUBST([piespeakupunitconfdir])

piespeakupldconfigdir='/etc/ld.so.conf.d'
AC_SUBST([piespeakupldconfigdir])

AC_CONFIG_FILES([
 Makefile
 src/Makefile
 config/Makefile
 doc/Makefile
])
AC_OUTPUT
