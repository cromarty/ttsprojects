
## Sequence ##

1. autoreconf --install
2. autoconf
3. ./configure

The above sequence will create src/conf.h among other stuff


Had to add AM_PROG_AR when moved to RPI.  Not sure why
but without it src/Makefile.in was not being created because
something was failing.

Presumably LDFLAGS in configure.ac can be passed on to src/Makefile.am?

Don't yet understand how to re-create situation after failed ./configure
or after changes to configure.ac/Makefile.am in top level.



