CC = gcc
SRCDIR = ../src
INCLUDES = -I$(SDKSTAGE)/opt/vc/include \
        -I$(SDKSTAGE)/opt/vc/include/interface/vcos/pthreads \
        -I$(SDKSTAGE)/opt/vc/include/interface/vmcs_host/linux \
        -I$(SDKSTAGE)/opt/vc/src/hello_pi/libs/ilclient \
        -I$(SDKSTAGE)/opt/vc/hello_pi/libs/vgfont \
        -I$(SDKSTAGE)/opt/vc/include -I../src -I.

CFLAGS = $(INCLUDES)
LDFLAGS = -L$(SDKSTAGE)/opt/vc/lib \
        -L$(SDKSTAGE)/opt/vc/src/hello_pi/libs/ilclient \
        -L$(SDKSTAGE)/opt/vc/src/hello_pi/libs/vgfont \
                -L../src
LDLIBS = -lilctts -lopenmaxil \
        -lbcm_host -lvcos -lvchiq_arm -lpthread \
        -lespeak -lrt

testlib : testlib.o
	$(CC) -o testlib testlib.o $(LDFLAGS) $(LDLIBS)  

testlib.o : testlib.c $(SRCDIR)/ilctts_lib.h
	$(CC) $(CFLAGS) -c testlib.c


clean :
	rm testlib testlib.o
