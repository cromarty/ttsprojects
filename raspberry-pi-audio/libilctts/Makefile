CC = gcc
INCLUDES = -I$(SDKSTAGE)/opt/vc/include \
        -I$(SDKSTAGE)/opt/vc/include/interface/vcos/pthreads \
        -I$(SDKSTAGE)/opt/vc/include/interface/vmcs_host/linux \
        -I$(SDKSTAGE)/opt/vc/src/hello_pi/libs/ilclient \
        -I$(SDKSTAGE)/opt/vc/hello_pi/libs/vgfont \
        -I$(SDKSTAGE)/opt/vc/include -I.

CFLAGS = $(INCLUDES) -DSTANDALONE -D__STDC_CONSTANT_MACROS \
        -D__STDC_LIMIT_MACROS -DTARGET_POSIX \
        -D_LINUX -fPIC -DPIC -D_REENTRANT \
        -D_LARGEFILE64_SOURCE \
        -D_FILE_OFFSET_BITS=64 \
        -U_FORTIFY_SOURCE -Wall -g -DHAVE_LIBOPENMAX=2 \
        -DOMX -DOMX_SKIP64BIT -ftree-vectorize \
        -pipe -DUSE_EXTERNAL_OMX -DHAVE_LIBBCM_HOST \
        -DUSE_EXTERNAL_LIBBCM_HOST \
        -DUSE_VCHIQ_ARM -Wno-psabi

LDFLAGS = -L$(SDKSTAGE)/opt/vc/lib \
        -L$(SDKSTAGE)/opt/vc/src/hello_pi/libs/ilclient \
        -L$(SDKSTAGE)/opt/vc/src/hello_pi/libs/vgfont \
        -lopenmaxil -lilclient \
        -lbcm_host -lvcos -lvchiq_arm -lpthread \
        -lrt 

coretest : coretest.o core.o utils.o
	$(CC) -o coretest coretest.o core.o utils.o $(LDFLAGS) 

coretest.o : coretest.c ilctts_lib.h # utils.h
	$(CC) $(CFLAGS) -c coretest.c

core.o : core.c ilctts_lib.h utils.h
	$(CC) $(CFLAGS) -c core.c
	 
utils.o : utils.c utils.h
	$(CC) $(CFLAGS) -c utils.c
		 

clean :
	rm coretest coretest.o core.o utils.o
