CC = gcc
LDFLAGS = -lfl

all:
	bison -d emacspeak.y
	flex emacspeak.l
	$(CC) -o emspk emacspeak.tab.c lex.yy.c emacspeak-sd.c $(LDFLAGS)

clean:
	rm emacspeak.tab.c
	rm emacspeak.tab.h
	rm lex.yy.c
	

