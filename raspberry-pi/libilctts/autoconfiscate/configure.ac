AC_PREREQ([2.69])
AC_INIT([ilctts], [1.0.0], [mike.ray@btinternet.com])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_PREFIX_DEFAULT(/usr/local)
AC_CONFIG_SRCDIR([src/core.c])
AC_CONFIG_MACRO_DIR([m4])

CPPFLAGS="-I/opt/vc/include -I/opt/vc/include/interface/vcos/pthreads -I/opt/vc/include/interface/vmcs_host/linux -I./include"


eval LIBTOOL_VERSION_INFO="1:0:0"

AC_SUBST(AC_LIBTOOL_VERSION_INFO)



AC_DISABLE_STATIC

dnl Test for programs

AC_PROG_CC
AC_PROG_INSTALL
AM_PROG_AR
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_LIBTOOL

dnl Check for headers


AC_CHECK_HEADERS([IL/OMX_Audio.h], [], [AC_MSG_ERROR(['could not find IL/OMX_Audio.h'])])
AC_CHECK_HEADERS([IL/OMX_Broadcom.h],[],[AC_MSG_ERROR([could not find IL/OMX_Broadcom.h'])])
AC_CHECK_HEADERS([IL/OMX_Component.h],[],[AC_MSG_ERROR(['could not find IL/OMX_Component.h'])])
AC_CHECK_HEADERS([bcm_host.h],[],[AC_MSG_ERROR(['could not find bcm_host.h'])])
AC_CHECK_HEADERS([interface/vcos/vcos_semaphore.h],[],[AC_MSG_ERROR(['could not find interface/vcos/vcos_semaphore.h'])])
AC_CHECK_HEADERS([interface/vmcs_host/vchost.h],[],[AC_MSG_ERROR(['could not find interface/vmcs_host/vchost.h'])])
AC_CHECK_HEADERS([ilclient.h],[],[AC_MSG_ERROR(['could not find ilclient.h'])])

dnl Check for libraries

AC_CHECK_LIB([bcm_host], [bcm_host_init])
AC_CHECK_LIB([openmaxil], [OMX_Init])
AC_CHECK_LIB([vchiq_arm],[vchiq_connect])
AC_CHECK_LIB([vcos],[vcos_dlopen])
AC_CHECK_LIB([pthread],[pthread_mutex_init])
AC_CHECK_LIB([rt],[fork])


#LDFLAGS="-L/opt/vc/lib -L/opt/vc/src/hello_pi/libs/ilclient"


dnl Do not build static and shared libraries together
if test "$enable_static" = "$enable_shared" -a "$enable_static" = "yes"; then
cat <<EOF
  Please, do not try to compile static and shared libraries together.
  See INSTALL file for more details (do not use --enable-shared=yes with
  --enable-static=yes).
EOF
  exit 1
fi

AC_CONFIG_HEADERS([src/config.h])

AC_CONFIG_FILES([
 Makefile
	include/Makefile
 src/Makefile
])
AC_OUTPUT
