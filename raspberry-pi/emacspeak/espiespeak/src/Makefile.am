BUILT_SOURCES = parser.c parser.h lexer.c
bin_PROGRAMS = piespeak
piespeak_SOURCES = server.c parser.y lexer.l queue.c list.c system.c pcregex.c server.h queue.h list.h debug.c debug.h system.h pcregex.h ilclient.h

AM_CPPFLAGS = -DYYDEBUG=1 -I/opt/vc/include



AM_YFLAGS = -d

