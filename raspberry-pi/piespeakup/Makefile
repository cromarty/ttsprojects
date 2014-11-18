PREFIX = /usr/local
BINDIR = ${PREFIX}/bin
MANDIR = ${PREFIX}/share/man
DEFDIR = /etc/default
SYSINITDIR = /etc/init.d

DEPFLAGS = -MMD
WARNFLAGS = -Wall
CFLAGS += -I$(SDKSTAGE)/opt/vc/include \
        -I$(SDKSTAGE)/opt/vc/include/interface/vcos/pthreads \
        -I$(SDKSTAGE)/opt/vc/include/interface/vmcs_host/linux \
        -I$(SDKSTAGE)/opt/vc/src/hello_pi/libs/ilclient \
        -I$(SDKSTAGE)/opt/vc/hello_pi/libs/vgfont \
        -I$(SDKSTAGE)/opt/vc/include -I$(SRCDIR) -I. \
        ${DEPFLAGS} ${WARNFLAGS}

LDLIBS = -lespeak -lpthread -lilctts

INSTALL = install
BINMODE = 0755
DEFMODE = 0644
MANMODE = 0644

SRCS = cli.c \
	espeak.c \
	piespeakup.c  \
	queue.c \
	signal.c \
	softsynth.c \
	stringhandling.c

OBJS = ${SRCS:.c=.o}

all: piespeakup

install: piespeakup
	${INSTALL} -d ${DESTDIR}${BINDIR}
	${INSTALL} -m ${BINMODE} $< ${DESTDIR}${BINDIR}
	${INSTALL} -d ${DESTDIR}${MANDIR}/man8
	${INSTALL} -m ${MANMODE} $<.8 ${DESTDIR}${MANDIR}/man8
	${INSTALL} -m ${BINMODE} init.d/$< ${SYSINITDIR}
	${INSTALL} -m ${DEFMODE} default/$< ${DEFDIR}

uninstall: piespeakup
	rm ${DESTDIR}${BINDIR}/$<
	rm ${MANDIR}
	rm ${DEFDIR}/$<
	rm ${SYSINITDIR}/$<

piespeakup: ${OBJS}

clean:
	${RM} *.d *.o piespeakup

distclean: clean
	${RM} piespeakup

-include ${SRCS:.c=.d}
