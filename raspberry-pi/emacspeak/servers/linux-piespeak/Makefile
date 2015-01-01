#$Id: Makefile 6198 2009-08-25 15:19:03Z tv.raman.tv $

INSTALL = install
PREFIX = /usr
LIBPARENTDIR = ${PREFIX}/share/emacs/site-lisp
SERVERDIR = $(LIBPARENTDIR)/emacspeak/servers
LIBDIR =$(LIBPARENTDIR)/emacspeak/servers/linux-piespeak
TCL_VERSION = 8.4
TCL_INCLUDE= /usr/include/tcl$(TCL_VERSION)
CXXFLAGS+= -g -O2 -fPIC -DPIC -pedantic -ansi -Wall -Wno-long-long -I$(TCL_INCLUDE) \
        -I/opt/vc/include \
        -I/opt/vc/include/interface/vcos/pthreads \
        -I/opt/vc/include/interface/vmcs_host/linux \
        -I/opt/vc/hello_pi/libs/vgfont -I.

LIBS= -ltcl$(TCL_VERSION) -lespeak -lilctts

TTS=tclpiespeak.so

all:   $(TTS)

$(TTS): tclpiespeak.o
	$(CXX) $(LDFLAGS) -shared -o $@ $< $(LIBS)

clean:
	rm -f *.so *.o

install: $(TTS)
	$(INSTALL) -d $(LIBDIR)
	$(INSTALL) $< $(LIBDIR)
	$(INSTALL) ../piespeak $(SERVERDIR)

