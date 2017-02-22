BUILT_SOURCES = parser.c parser.h lexer.c
bin_PROGRAMS = espeakmrx86
espeakmrx86_SOURCES = server.c parser.y lexer.l queue.c list.c system.c pcregex.c server.h queue.h list.h debug.c debug.h system.h pcregex.h

AM_CPPFLAGS = -DYYDEBUG=1

if SOUNDS
	AM_CPPFLAGS += -D_SOUNDS_
	if SOUND_PLAY
		AM_CPPFLAGS += -D_PLAY_
		endif

	if SOUND_APLAY
		AM_CPPFLAGS += -D_APLAY_
	endif
endif



AM_YFLAGS = -d

