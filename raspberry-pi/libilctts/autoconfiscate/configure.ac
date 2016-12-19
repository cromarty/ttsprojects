AC_PREREQ([2.69])
AC_INIT([libilctts], [1.0.0], [mike.ray@btinternet.com])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

CPPFLAGS="-I/opt/vc/include -I/opt/vc/include/interface/vcos/pthreads -I/opt/vc/include/interface/vmcs_host/linux -I/opt/vc/src/hello_pi/libs/ilclient -I/opt/vc/src/hello_pi/libs/vgfont -I/opt/vc/include"
LDFLAGS="-L/opt/vc/lib -L/opt/vc/src/hello_pi/libs/ilclient"

eval LIBTOOL_VERSION_INFO="1:0:0"

AC_SUBST(LIBTOOL_VERSION_INFO)

AC_PROG_CC
AM_PROG_AR
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_LIBTOOL


AC_CHECK_HEADERS([IL/OMX_Audio.h], [], [AC_MSG_ERROR(['could not find IL/OMX_Audio.h'])])
AC_CHECK_HEADERS([IL/OMX_Broadcom.h],[],[AC_MSG_ERROR([could not find IL/OMX_Broadcom.h'])])
AC_CHECK_HEADERS([IL/OMX_Component.h],[],[AC_MSG_ERROR(['could not find IL/OMX_Component.h'])])
AC_CHECK_HEADERS([bcm_host.h],[],[AC_MSG_ERROR(['could not find bcm_host.h'])])
AC_CHECK_HEADERS([interface/vcos/vcos_semaphore.h],[],[AC_MSG_ERROR(['could not find interface/vcos/vcos_semaphore.h'])])
AC_CHECK_HEADERS([interface/vmcs_host/vchost.h],[],[AC_MSG_ERROR(['could not find interface/vmcs_host/vchost.h'])])

AC_CHECK_HEADERS([ilclient.h],[],[AC_MSG_ERROR(['could not find ilclient.h'])])

#AC_CHECK_HEADER([errno.h])
#AC_CHECK_HEADER([malloc.h])
#AC_CHECK_HEADER([pthread.h])
#AC_CHECK_HEADER([semaphore.h])
#AC_CHECK_HEADER([stdarg.h])
#AC_CHECK_HEADER([stdio.h])
#AC_CHECK_HEADER([sys/resource.h])
#AC_CHECK_HEADER([sys/time.h])
#AC_CHECK_HEADER([unistd.h])


AC_CHECK_LIB([bcm_host], [bcm_host_init])
AC_CHECK_LIB([openmaxil], [OMX_Init])

AC_CHECK_LIB([vchiq_arm],[vchiq_connect])
AC_CHECK_LIB([vcos],[vcos_dlopen])

AC_CHECK_LIB([pthread],[pthread_mutex_init])
AC_CHECK_LIB([rt],[fork])

AC_CONFIG_HEADERS([src/config.h])

AC_CONFIG_FILES([
 Makefile
 src/Makefile
])
AC_OUTPUT
