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

#include "tts_engine.h"


/* these are declared in emacspeak.y */
extern int sync_punct_level;
extern int sync_dtk_caps_pitch_rise;
extern int sync_dtk_allcaps_beep;
extern int sync_dtk_split_caps;


%}


%x C clb csp
%x Q qlb qsp
%x L llb lsp
%x SH shlb shsp





ws [ \t\r\n]+

%%

	/* [0-9]+				{ yylval.n = atoi(yytext); return INTEGER; } */
[-+]?([0-9]*\.?[0-9]+|[0-9]+\.) { yylval.d = atof(yytext); return NONINTEGER; }

{ws} /* skip */


^c { BEGIN(C); return QCODE; }
^l { BEGIN(L); return QLETTER; }
^q { BEGIN(Q); return QSPEECH; }
^sh { BEGIN(SH); return SILENCE; }


	/* start c {...} */

<C>"{" {
        BEGIN(clb);
        }
<clb>[^\}]*/"}" {
        BEGIN(csp);
     yylval.s = yytext;
    return CTEXT;
        }
<csp>"}" {
       BEGIN(INITIAL);
      }

	/* end c {...} */

	/* start q {...} */

<Q>"{" {
        BEGIN(qlb);
        }
<qlb>[^\}]*/"}" {
        BEGIN(qsp);
     yylval.s = yytext;
    return CTEXT;
        }
<qsp>"}" {
       BEGIN(INITIAL);
      }

	/* end q {...} */


	/* start l {...} */

<L>"{" {
        BEGIN(llb);
        }
<llb>[^\}]*/"}" {
        BEGIN(lsp);
     yylval.s = yytext;
    return CTEXT;
        }
<lsp>"}" {
       BEGIN(INITIAL);
      }

	/* end l {...} */

	/* start sh {...} */

<SH>"{" {
        BEGIN(shlb);
        }
     <shlb>[ \t]* /* consume and drop */   
<shlb>[0-9]+/[ \t]*"}" {
        BEGIN(shsp);
     yylval.n = atoi(yytext);
    return INTEGER;
        }
<shsp>"}" {
       BEGIN(INITIAL);
      }

	/* end sh {...} */


	/* These patterns are matched when there are no braces */
<C>[^ \{\}\t\n\r\f\v]+ { BEGIN(INITIAL); yylval.s = yytext; return CTEXT; }
<Q>[^ \{\}\t\n\r\f\v]+ { BEGIN(INITIAL); yylval.s = yytext; return CTEXT; }
<L>[^ \{\}\t\n\r\f\v]+ { BEGIN(INITIAL); yylval.s = yytext; return CTEXT; }
<SH>[^ \{\}\t\n\r\f\v]+ {
 BEGIN(INITIAL);
 yylval.n = atoi(yytext);
 return INTEGER;
 }




	/* tts_sync_state never has braces around the parameters */
tts_sync_state { return TTS_SYNC_STATE; }

tts_allcaps_beep { return TTS_ALLCAPS_BEEP; }
tts_capitalize { return TTS_CAPITALIZE; }


	/* These have no parameters at all */
tts_pause { return TTS_PAUSE; }
tts_reset { return TTS_RESET; }
tts_resume { return TTS_RESUME; }


tts_say { return TTS_SAY; }
tts_set_character_scale { return TTS_SET_CHARACTER_SCALE; }
tts_set_punctuations { return TTS_SET_PUNCTUATIONS; }
tts_set_speech_rate { return TTS_SET_SPEECH_RATE; }
tts_split_caps { return TTS_SPLIT_CAPS; }

^d { return DISPATCH; }
^s { return FLUSH; }
^t { return TONE; }

all		{ sync_punct_level = PUNCT_LEVEL_ALL; return PUNCTLEVEL; }
some		{ sync_punct_level = PUNCT_LEVEL_SOME; return PUNCTLEVEL; }
none		{ sync_punct_level = PUNCT_LEVEL_NONE; return PUNCTLEVEL; }

. ;


