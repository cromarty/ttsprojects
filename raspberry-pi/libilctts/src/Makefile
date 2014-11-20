CC = gcc
PREFIX = /usr/local
MAJOR = 1
MINOR = 0
REVISION = 1
VERSION = $(MAJOR).$(MINOR).$(REVISION)
TARGETLIB = libilctts.so
INSTALLDIR = $(PREFIX)/lib
INCLUDEDIR = $(PREFIX)/include
INCLUDES = -I$(SDKSTAGE)/opt/vc/include \
        -I$(SDKSTAGE)/opt/vc/include/interface/vcos/pthreads \
        -I$(SDKSTAGE)/opt/vc/include/interface/vmcs_host/linux \
        -I$(SDKSTAGE)/opt/vc/hello_pi/libs/vgfont \
        -I$(SDKSTAGE)/opt/vc/include -I../src -I.

CFLAGS = $(INCLUDES) -DSTANDALONE -D__STDC_CONSTANT_MACROS \
        -D__STDC_LIMIT_MACROS -DTARGET_POSIX \
        -D_LINUX -fPIC -DPIC -D_REENTRANT \
        -D_LARGEFILE64_SOURCE \
        -D_FILE_OFFSET_BITS=64 \
        -U_FORTIFY_SOURCE -Wall -DHAVE_LIBOPENMAX=2 \
        -DOMX -DOMX_SKIP64BIT -ftree-vectorize \
        -pipe -DUSE_EXTERNAL_OMX -DHAVE_LIBBCM_HOST \
        -DUSE_EXTERNAL_LIBBCM_HOST \
        -DUSE_VCHIQ_ARM -Wno-psabi \
        -O2 -Wextra -Wno-unused-function

LDFLAGS = -Wl,--verbose \
        -L$(SDKSTAGE)/opt/vc/lib -shared

LDLIBS = -lopenmaxil \
        -lbcm_host -lvcos -lvchiq_arm -lpthread \
        -lrt

RM = rm -f

SRCS = core.c \
        utils.c \
        ringbuffer.c \
        debug.c \
        ilclient.c \
        ilcore.c

OBJS = $(SRCS:.c=.o)

all : $(TARGETLIB).$(VERSION)

$(TARGETLIB).$(VERSION): $(OBJS)
	$(CC) ${LDFLAGS} ${LDLIBS} -o $@ $^

$(SRCS:.c=.d):%.d:%.c
	$(CC) $(CFLAGS) -MM $< >$@

include $(SRCS:.c=.d)

install :
	install $(TARGETLIB).$(VERSION) $(INSTALLDIR)
	ln -s $(INSTALLDIR)/$(TARGETLIB).$(VERSION) $(INSTALLDIR)/$(TARGETLIB).$(MAJOR)
	ln -s $(INSTALLDIR)/$(TARGETLIB).$(MAJOR) $(INSTALLDIR)/$(TARGETLIB)
	install ilctts_lib.h $(INCLUDEDIR)
	ldconfig

uninstall :
	rm $(INSTALLDIR)/$(TARGETLIB)
	rm $(INSTALLDIR)/$(TARGETLIB).*
	rm $(INCLUDEDIR)/ilctts_lib.h

clean :
	$(RM) $(TARGETLIB).$(VERSION) $(OBJS) $(SRCS:.c=.d)

