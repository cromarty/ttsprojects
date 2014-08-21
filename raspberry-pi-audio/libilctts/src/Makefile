CC = gcc
VERSION = 0.1.0
TARGET_LIB = libilctts.so
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
        	-O2 -Wextra
LDFLAGS = -L$(SDKSTAGE)/opt/vc/lib -shared \
        -L$(SDKSTAGE)/opt/vc/src/hello_pi/libs/ilclient \
        -L$(SDKSTAGE)/opt/vc/src/hello_pi/libs/vgfont \
        -lopenmaxil -lilclient \
        -lbcm_host -lvcos -lvchiq_arm -lpthread \
        -lrt 
        	
RM = rm -f

SRCS = core.c utils.c ringbuffer.c
OBJS = $(SRCS:.c=.o)

.PHONY: all
all: ${TARGET_LIB}.${VERSION}

$(TARGET_LIB).$(VERSION): $(OBJS)
	$(CC) ${LDFLAGS} -o $@ $^

$(SRCS:.c=.d):%.d:%.c
	$(CC) $(CFLAGS) -MM $< >$@

include $(SRCS:.c=.d)
.PHONEY: install 
install:
	install ${TARGET_LIB}.${VERSION} ${INSTALLDIR}
	ln -s ${INSTALLDIR}/${TARGET_LIB}.${VERSION} ${INSTALLDIR}/${TARGET_LIB}	
	
.PHONY: clean
clean:
	-${RM} ${TARGET_LIB}.${VERSION} ${OBJS} $(SRCS:.c=.d)

