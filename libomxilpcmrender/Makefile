CC = gcc
CFLAGS   = -DSTANDALONE -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -DTARGET_POSIX -D_LINUX -DPIC -D_REENTRANT -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -U_FORTIFY_SOURCE -DHAVE_LIBOPENMAX=2 -DOMX -DOMX_SKIP64BIT -ftree-vectorize -pipe -DUSE_EXTERNAL_OMX -DHAVE_LIBBCM_HOST -DUSE_EXTERNAL_LIBBCM_HOST -DUSE_VCHIQ_ARM \
		   -I/opt/vc/include -I/opt/vc/include/interface/vcos/pthreads -I/opt/vc/include/interface/vmcs_host/linux \
		   -fPIC -ftree-vectorize -pipe -Wall -O2 -g
LDFLAGS  = -L/opt/vc/lib -lopenmaxil

coretest : main.o core.o list.o queue.o
	$(CC) -o coretest main.o core.o list.o queue.o $(LDFLAGS)

main.o : main.c omxilpcmrender.h list.h queue.h debug.h
	$(CC) $(CFLAGS) -c main.c

core.o : core.c omxilpcmrender.h list.h queue.h debug.h
	$(CC) $(CFLAGS) -c core.c

list.o : list.c list.h
	$(CC) -c list.c

queue.o : queue.c list.c queue.h list.h
	$(CC) -c queue.c list.c

clean:
	rm main.o core.o list.o queue.o



