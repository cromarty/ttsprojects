CC = gcc
LDFLAGS = 
LDLIBS = -lfl -lespeak

all:
	bison -d emacspeak.y
	flex emacspeak.l
	$(CC) -o emspk emacspeak.tab.c lex.yy.c tts_espeak.c $(LDFLAGS) $(LDLIBS)

