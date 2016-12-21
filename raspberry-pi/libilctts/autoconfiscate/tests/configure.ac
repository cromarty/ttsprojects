#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
AC_CONFIG_SRCDIR([test00/testlib00.c])

CPPFLAGS="-I/opt/vc/include -I/opt/vc/include/interface/vcos/pthreads -I/opt/vc/include/interface/vmcs_host/linux"
LDFLAGS="-L/opt/vc/lib"

dnl Checks for programs

AC_PROG_CC
AC_PROG_LD


dnl Checks for libraries

AC_CHECK_LIB([bcm_host], [bcm_host_init], [], [AC_MSG_ERROR([bcm_host_init was not found in libbcm_host, do you need to get and build the userland code?])])
AC_CHECK_LIB([openmaxil], [OMX_Init], [], [AC_MSG_ERROR([OMX_Init was not found in libopenmaxil, do you need to get and build the userland code?])])
AC_CHECK_LIB([vchiq_arm],[vchiq_connect], [], [AC_MSG_ERROR([vchiq_connect was not found in libvchiq_arm, do you need to get and build the userland code?])])
AC_CHECK_LIB([vcos],[vcos_dlopen], [], [AC_MSG_ERROR([vcos_dlopen was not found in libvcos, do you need to get and build the userland code?])])
AC_CHECK_LIB([pthread],[pthread_mutex_init], [], [AC_MSG_ERROR([pthread_mutex_init was not found in libpthread])])
AC_CHECK_LIB([rt],[fork], [], [AC_MSG_ERROR([fork was not found in librt])])

AC_CHECK_LIB([pthread],[pthread_mutex_init], [], [AC_MSG_ERROR([pthread_mutex_init was not found in libpthread])])


dnl Checks for header files
AC_CHECK_HEADERS([ilctts_lib.h])
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
