CC = gcc
LDFLAGS = 
LDLIBS = -lfl -lpthread -lespeak

all:
	bison -d emacspeak.y
	flex emacspeak.l
	$(CC) -o emspk emacspeak.tab.c lex.yy.c tts_espeak.c list.c queue.c $(LDFLAGS) $(LDLIBS)

