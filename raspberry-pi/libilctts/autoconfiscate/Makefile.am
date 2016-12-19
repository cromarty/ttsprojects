ACLOCAL_AMFLAGS = -I m4
SUBDIRS = include src
dist_doc_DATA = README.md
EXTRA_DIST=COPYING ChangeLog configure libtool depcomp
AM_CPPFLAGS=$(top_srcdir)/include -I/opt/vc/include -I/opt/vc/include/interface/vcos/pthreads -I/opt/vc/include/interface/vmcs_host/linux -I/opt/vc/src/hello_pi/libs/ilclient -I/opt/vc/src/hello_pi/libs/vgfont -I/opt/vc/include
AM_LDFLAGS="-Wl,--verbose -L/opt/vc/lib -shared"

