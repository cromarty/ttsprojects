/*
*
* emacspeak.l - Flex lexer file for the Emacspeak tts protocol
*
* Copyright (C) 2014 Mike Ray <mike.ray@btinternet.com>
*
* This is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 3, or (at your option)
* any later version.
*
* This software is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this package; see the file COPYING.  If not, write to
* the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301, USA.
*
*--code--*/

%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "emacspeak.tab.h"

#include "emacspeak-module.h"


/* these are declared in emacspeak.y */
extern int sync_punct_level;
extern int sync_dtk_caps_pitch_rise;
extern int sync_dtk_allcaps_beep;
extern int sync_dtk_split_caps;


%}

%x LBRACE SPEECH RBRACE

ws [ \t\r\n]+

%%

[01] { yylval.n = atoi(yytext); return BOOLEANFLAG; }
[0-9]+				{ yylval.n = atoi(yytext); return INTEGER; }
[-+]?([0-9]*\.?[0-9]+|[0-9]+\.) { yylval.d = atof(yytext); return NONINTEGER; }

c { return QCODE; }
l { return QLETTER; }
q { return QSPEECH; }

{ws} /* skip */

	/* start stuff */

<INITIAL>"{" {
        BEGIN(LBRACE);
        }
<LBRACE>[^\}]*/"}" {
        BEGIN(SPEECH);
     yylval.s = yytext;
    return CTEXT;
        }
<SPEECH>"}" {
       BEGIN(RBRACE);
      }
<RBRACE>"\n" {
        BEGIN(INITIAL);
        }

	/* end stuff */

tts_sync_state { return TTS_SYNC_STATE; }
tts_allcaps_beep { return TTS_ALLCAPS_BEEP; }
tts_capitalize { return TTS_CAPITALIZE; }
tts_pause { return TTS_PAUSE; }
tts_reset { return TTS_RESET; }
tts_resume { return TTS_RESUME; }
tts_say { return TTS_SAY; }
tts_set_character_scale { return TTS_SET_CHARACTER_SCALE; }
tts_set_punctuations { return TTS_SET_PUNCTUATIONS; }
tts_set_speech_rate { return TTS_SET_SPEECH_RATE; }
tts_split_caps { return TTS_SPLIT_CAPS; }

d { return DISPATCH; }
s { return FLUSH; }
sh { return SILENCE; }
t { return TONE; }

all		{ sync_punct_level = PUNCT_LEVEL_ALL; return PUNCTLEVEL; }
some		{ sync_punct_level = PUNCT_LEVEL_SOME; return PUNCTLEVEL; }
none		{ sync_punct_level = PUNCT_LEVEL_NONE; return PUNCTLEVEL; }



