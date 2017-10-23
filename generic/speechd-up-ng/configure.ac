AC_PREREQ([2.69])
AC_INIT([speehd-up], [0.4], [BUG-REPORT-ADDRESS])
AM_INIT_AUTOMAKE
AC_PREFIX_DEFAULT(/usr)
AC_CONFIG_SRCDIR([src/speechd-up.c])
AC_CONFIG_HEADERS([config.h])



dnl Checks for programs.

AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_SED
AC_PROG_GCC_TRADITIONAL
AC_PROG_MAKE_SET


dnl Checks for header files.

AC_CHECK_HEADERS([fcntl.h stdlib.h string.h limits.h sys/ioctl.h sys/time.h unistd.h libspeechd.h])

dnl Checks for typedefs, structures, and compiler characteristics.

AC_C_CONST
AC_HEADER_TIME
AC_ARG_VAR(pidpath, Absolute path to a pid file)
AC_TYPE_SIZE_T



dnl Checks for libraries.

AC_CHECK_LIB(speechd, spd_set_data_mode,, echo "*** Required speechd library missing! See INSTALL .";exit 1)

dnl Checks for library functions.

AC_FUNC_MALLOC
AC_CHECK_FUNCS([select socket strdup strerror strtol])
AC_PROG_GCC_TRADITIONAL


dnl Paths

systemdunitdir='/usr/lib/systemd/system'
AC_SUBST([systemdunitdir])

speechdupunitconfdir='/etc/systemd/system'
AC_SUBST([speechdupunitconfdir])

mandir='/usr/share/man'
AC_SUBST([mandir])



AC_CONFIG_FILES([
		Makefile
	config/Makefile
		src/Makefile
	])

AC_OUTPUT
