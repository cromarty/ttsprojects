/*
*
* emacspeak.y - Bison parser file for the Emacspeak tts protocol
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
//#include <speech-dispatcher/libspeechd.h>

#include "emacspeak-module.h"

int sync_punct_level;

int sync_dtk_caps_pitch_rise;
int sync_dtk_allcaps_beep;
int sync_dtk_split_caps;

int sync_speech_rate;

 


%}

%union 
{
        int n;
        double d;
        char *s;
}

%token <n> TTS_ALLCAPS_BEEP
%token <n> TTS_CAPITALIZE
%token <n> TTS_INITIALIZE
%token <n> TTS_PAUSE
%token <n> TTS_RESET
%token <n> TTS_RESUME
%token <n> TTS_SAY
%token <n> TTS_SET_CHARACTER_SCALE
%token <n> TTS_SET_PUNCTUATIONS
%token <n> TTS_SET_SPEECH_RATE
%token <n> TTS_SPLIT_CAPS
%token <n> TTS_SYNC_STATE
%token <s> NAME
%token <n> QSPEECH
%token <n> INTEGER
%token <d> NONINTEGER
%token <n> EOL
%token <n> SILENCE
%token <s> CTEXT
%token <n> LETTER
%token <n> FLUSH
%token <n> DISPATCH
%token <n> VERSION
%token <n> PLAYFILE
%token <n> TONE
%token <n> PUNCTLEVEL
%token <n> LANGUAGE
%token <n> VOICE
%token <n> CODE

%%

 /* rules */

commands : /* empty */ 
| commands command 
;

command : EOL { /* do nothing */ }
			| TTS_ALLCAPS_BEEP INTEGER	EOL		{ esp_tts_allcaps_beep($2); }
		| TTS_INITIALIZE	EOL				{ esp_initialize(); }
		| TTS_PAUSE	EOL				{ esp_tts_pause(); }
		| TTS_RESET	EOL				{ esp_tts_reset(); }
		| TTS_RESUME	EOL				{ esp_tts_resume(); }
		| TTS_SAY CTEXT	EOL				{ esp_tts_say($2); }
		| TTS_SET_CHARACTER_SCALE NONINTEGER	EOL				{ esp_tts_set_character_scale($2); }
		| TTS_SET_PUNCTUATIONS identifier	EOL				{ esp_tts_set_punctuations(sync_punct_level); }
		| TTS_SET_SPEECH_RATE INTEGER	EOL				{ esp_tts_set_speech_rate($2); }
		| TTS_SPLIT_CAPS INTEGER	EOL				{ esp_tts_split_caps($2); }
		| TTS_SYNC_STATE identifier INTEGER INTEGER INTEGER INTEGER EOL
				{
					sync_dtk_caps_pitch_rise = $3;
					sync_dtk_allcaps_beep = $4;
					sync_dtk_split_caps = $5;
					sync_speech_rate = $6;
					esp_tts_sync_state(sync_punct_level, sync_dtk_caps_pitch_rise, sync_dtk_allcaps_beep, sync_dtk_split_caps, sync_speech_rate);
				}
		| FLUSH	EOL				{ esp_s(); }
		| SILENCE INTEGER	EOL				{ esp_sh($2); }
		| QSPEECH CTEXT	EOL				{ esp_q($2); }
		| LETTER CTEXT	EOL				{ esp_l($2); }
		| DISPATCH	EOL				{ esp_d(); }
		| TONE INTEGER INTEGER EOL					{ esp_t($2, $3); }
		| PLAYFILE CTEXT	EOL				{ esp_a($2); }
		| VERSION	EOL				{ esp_version(); }
		| CODE CTEXT	EOL		{ esp_c($2); }
;

identifier : PUNCTLEVEL
| LANGUAGE
| VOICE
;


%%

int main(int argc, char **argv) 
{

	yyparse(); 

} /* end main */ 

yyerror(char *s) 
{ 
	fprintf(stderr, "error: %s\n", s); 
} /* end yyerror */

