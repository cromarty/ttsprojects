
include ../Makefile.include

LDLIBS += -lespeak

testlib : testlib.o
	$(CC) -o testlib testlib.o $(LDFLAGS) $(LDLIBS)  

testlib.o : testlib.c
	$(CC) $(CFLAGS) -c testlib.c


clean :
	rm testlib testlib.o
