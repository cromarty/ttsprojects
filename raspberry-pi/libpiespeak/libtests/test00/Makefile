CC = gcc
INCLUDES = -I$(SDKSTAGE)/opt/vc/include \
        -I$(SDKSTAGE)/opt/vc/include/interface/vcos/pthreads \
        -I$(SDKSTAGE)/opt/vc/include/interface/vmcs_host/linux \
        -I$(SDKSTAGE)/opt/vc/src/hello_pi/libs/ilclient \
        -I$(SDKSTAGE)/opt/vc/hello_pi/libs/vgfont \
        -I$(SDKSTAGE)/opt/vc/include -I$(SRCDIR) -I.

CFLAGS = $(INCLUDES)
LDFLAGS = -L$(SDKSTAGE)/opt/vc/lib \
        -L$(SDKSTAGE)/opt/vc/src/hello_pi/libs/ilclient \
        -L$(SDKSTAGE)/opt/vc/src/hello_pi/libs/vgfont
LDLIBS = -lpiespeak -lopenmaxil \
        -lbcm_host -lvcos -lvchiq_arm -lpthread \
        -lrt

testlib : testlib00.o
	$(CC) -o testlib00 testlib00.o $(LDFLAGS) $(LDLIBS)  

testlib00.o : testlib00.c
	$(CC) $(CFLAGS) -c testlib00.c


clean :
	rm testlib00 testlib00.o
