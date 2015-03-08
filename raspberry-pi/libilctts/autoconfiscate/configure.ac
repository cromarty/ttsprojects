AC_PREREQ([2.69])
AC_INIT([libilctts], [1.0.0], [mike.ray@btinternet.com])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

LDFLAGS="-L/opt/vc/lib -L/opt/vc/src/hello_pi/libs/ilclient"

eval LIBTOOL_VERSION_INFO="1:0:0"

AC_SUBST(LIBTOOL_VERSION_INFO)

AC_PROG_CC
AM_PROG_AR
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_LIBTOOL

AC_CHECK_LIB([bcm_host], [bcm_host_init])
AC_CHECK_LIB([openmaxil], [OMX_Init])
AC_CHECK_LIB([ilclient], [ilclient_init])

AC_CONFIG_HEADERS([src/config.h])

AC_CONFIG_FILES([
 Makefile
 src/Makefile
])
AC_OUTPUT
