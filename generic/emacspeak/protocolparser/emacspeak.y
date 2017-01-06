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
        int number;
        char *string;
}

%token <number> TTS_ALLCAPS_BEEP
%token <number> TTS_CAPITALIZE
%token <number> TTS_INITIALIZE
%token <number> TTS_PAUSE
%token <number> TTS_RESET
%token <number> TTS_RESUME
%token <number> TTS_SAY
%token <number> TTS_SET_CHARACTER_SCALE
%token <number> TTS_SET_PUNCTUATIONS
%token <number> TTS_SET_SPEECH_RATE
%token <number> TTS_SPLIT_CAPS
%token <number> TTS_SYNC_STATE
%token <string> NAME
%token <number> QSPEECH
%token <number> NUM
%token <number> EOL
%token <number> SILENCE
%token <string> CTEXT
%token <number> LETTER
%token <number> FLUSH
%token <number> DISPATCH
%token <number> VERSION
%token <number> PLAYFILE
%token <number> TONE
%token <number> PUNCTLEVEL
%token <number> LANGUAGE
%token <number> VOICE
%token <number> CODE

%%

 /* rules */

commands : /* empty */ 
| commands command 
;

command : EOL { /* do nothing */ }
			| TTS_ALLCAPS_BEEP NUM			{ esp_tts_allcaps_beep($2); }
		| TTS_INITIALIZE					{ esp_initialize(); }
		| TTS_PAUSE					{ esp_tts_pause(); }
		| TTS_RESET					{ esp_tts_reset(); }
		| TTS_RESUME					{ esp_tts_resume(); }
		| TTS_SAY CTEXT					{ esp_tts_say($2); }
		| TTS_SET_CHARACTER_SCALE NUM					{ esp_tts_set_character_scale($2); }
		| TTS_SET_PUNCTUATIONS identifier					{ esp_tts_set_punctuations(sync_punct_level); }
		| TTS_SET_SPEECH_RATE NUM					{ esp_tts_set_speech_rate($2); }
		| TTS_SPLIT_CAPS NUM					{ esp_tts_split_caps($2); }
		| TTS_SYNC_STATE identifier NUM NUM NUM NUM 
				{
					sync_dtk_caps_pitch_rise = $3;
					sync_dtk_allcaps_beep = $4;
					sync_dtk_split_caps = $5;
					sync_speech_rate = $6;
					esp_tts_sync_state(sync_punct_level, sync_dtk_caps_pitch_rise, sync_dtk_allcaps_beep, sync_dtk_split_caps, sync_speech_rate);
				}
		| FLUSH					{ esp_s(); }
		| SILENCE NUM					{ esp_sh($2); }
		| QSPEECH CTEXT					{ esp_q($2); }
		| LETTER CTEXT					{ esp_l($2); }
		| DISPATCH					{ esp_d(); }
		| TONE NUM NUM					{ esp_t($2, $3); }
		| PLAYFILE CTEXT					{ esp_a($2); }
		| VERSION					{ esp_version(); }
		| CODE CTEXT			{ esp_c($2); }
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

