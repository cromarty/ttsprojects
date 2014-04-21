
/*
 *
 * Copyright (C) 2014 Mike Ray <mike.ray.1964@gmail.com>
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
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
 * $Id: emspk-sd.y
 */

%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <speech-dispatcher/libspeechd.h>

#include "emacspeakproxy-module.h"

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
			| TTS_ALLCAPS_BEEP			{ esp_allcaps_beep(); }
		| TTS_INITIALIZE					{ esp_initialize(); }
		| TTS_PAUSE					{ esp_pause(); }
		| TTS_RESET					{ esp_reset(); }
		| TTS_RESUME					{ esp_resume(); }
		| TTS_SAY CTEXT					{ esp_say($2); }
		| TTS_SET_CHARACTER_SCALE NUM					{ esp_set_character_scale($2); }
		| TTS_SET_PUNCTUATIONS identifier					{ esp_set_punctuations(sync_punct_level); }
		| TTS_SET_SPEECH_RATE NUM					{ esp_set_speech_rate($2); }
		| TTS_SPLIT_CAPS					{ esp_split_caps(); }
		| TTS_SYNC_STATE identifier NUM NUM NUM NUM 
				{
					sync_dtk_caps_pitch_rise = $3;
					sync_dtk_allcaps_beep = $4;
					sync_dtk_split_caps = $5;
					sync_speech_rate = $6;
					esp_sync_state(sync_punct_level, sync_dtk_caps_pitch_rise, sync_dtk_allcaps_beep, sync_dtk_split_caps, sync_speech_rate);
				}
		| FLUSH					{ esp_flush(); }
		| SILENCE NUM					{ esp_silence($2); }
		| QSPEECH CTEXT					{ esp_q($2); }
		| LETTER CTEXT					{ esp_letter($2); }
		| DISPATCH					{ esp_dispatch(); }
		| TONE NUM NUM					{ esp_tone($2, $3); }
		| PLAYFILE CTEXT					{ esp_play_file($2); }
		| VERSION					{ esp_version(); }
		| CODE CTEXT			{ esp_code($2); }
;

identifier : PUNCTLEVEL
| LANGUAGE
| VOICE
;


%%

main(int argc, char **argv) 
{

	yyparse(); 

} 

yyerror(char *s) 
{ 
	fprintf(stderr, "error: %s\n", s); 
} /* end main */

