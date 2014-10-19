CC = gcc
SRCDIR = ../src
INCLUDES = -I../src
CFLAGS = $(INCLUDES)
LDFLAGS = -Wall

all :
	$(CC) $(CFLAGS) -o testringbuffer testringbuffer.c $(SRCDIR)/ringbuffer.c

clean :
	rm testringbuffer testringbuffer.o ringbuffer.o
