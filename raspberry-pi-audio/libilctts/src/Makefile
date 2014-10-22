CC = gcc
VERSION = 0.1.0
TARGETLIB = libilctts.so
INSTALLDIR = /usr/lib
INCLUDES = -I$(SDKSTAGE)/opt/vc/include \
        -I$(SDKSTAGE)/opt/vc/include/interface/vcos/pthreads \
        -I$(SDKSTAGE)/opt/vc/include/interface/vmcs_host/linux \
        -I$(SDKSTAGE)/opt/vc/src/hello_pi/libs/ilclient \
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
LDFLAGS = -L$(SDKSTAGE)/opt/vc/lib -shared \
        -L$(SDKSTAGE)/opt/vc/src/hello_pi/libs/ilclient \
        -L$(SDKSTAGE)/opt/vc/src/hello_pi/libs/vgfont \
        -lopenmaxil -lilclient \
        -lbcm_host -lvcos -lvchiq_arm -lpthread \
        -lpthread -lespeak -lrt

RM = rm -f

SRCS = core.c utils.c list.c queue.c espeak.c
OBJS = $(SRCS:.c=.o)

all : ${TARGETLIB}.${VERSION}

$(TARGETLIB).$(VERSION): $(OBJS)
	$(CC) ${LDFLAGS} -o $@ $^

$(SRCS:.c=.d):%.d:%.c
	$(CC) $(CFLAGS) -MM $< >$@

include $(SRCS:.c=.d)

install :
	install ${TARGETLIB}.${VERSION} ${INSTALLDIR}
	ln -s ${INSTALLDIR}/${TARGETLIB}.${VERSION} ${INSTALLDIR}/${TARGETLIB}	

uninstall :
	rm ${INSTALLDIR}/${TARGETLIB}
	rm ${INSTALLDIR}/${TARGETLIB}.${VERSION}

clean :
	-${RM} ${TARGETLIB}.${VERSION} ${OBJS} $(SRCS:.c=.d)

