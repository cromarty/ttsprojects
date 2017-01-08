CC = gcc
LDFLAGS = 
LDLIBS = -lfl

all:
	bison -d emacspeak.y
	flex emacspeak.l
	$(CC) -o x86test emacspeak.tab.c lex.yy.c x86test.c $(LDFLAGS) $(LDLIBS)

clean:
	rm x86test
	rm *.o	

