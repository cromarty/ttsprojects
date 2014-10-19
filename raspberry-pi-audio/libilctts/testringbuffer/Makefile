CC = gcc
SRCDIR = ../src
INCLUDES = -I../src
CFLAGS = $(INCLUDES)
LDFLAGS = -Wall

testringbuffer : testringbuffer.o
	$(CC) -o testringbuffer testringbuffer.o $(LDFLAGS) 

testringbuffer.o : testringbuffer.c $(SRCDIR)/ringbuffer.c $(SRCDIR)/ringbuffer.h
	$(CC) $(CFLAGS) -c testringbuffer.c $(SRCDIR)/ringbuffer.c


clean :
	rm testringbuffer testringbuffer.o ringbuffer.o
