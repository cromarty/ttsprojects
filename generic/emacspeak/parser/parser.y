/*
*
* Copyright (C) 2017 Mike Ray <mike.ray@btinternet.com>
*
* Bison parser for the Emacspeak text-to-speech protocol. Requires lexer.l
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
*--code--*/

%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "server.h"


int yylex();
void yyerror(const char *s);

//extern int input_for_lexer(char*buf, int *num_bytes_read, int max_bytes_to_read);

%}

%union
{
	int n;
	double d;
	char *s;
	char c;
}

%token <d>DOUBLE

%token <n>A
%token <n>C
%token <n>D
%token <n>FLAG
%token <n>INTEGER
%token <n>L
%token <n>S
%token <n>SH

%token <n>PUNCT_ALL
%token <n>PUNCT_NONE
%token <n>PUNCT_SOME

%token <n>Q
%token <n>B
%token <n>T

%token <n>TTS_ALLCAPS_BEEP
%token <n>TTS_CAPITALIZE
%token <n>TTS_PAUSE
%token <n>TTS_RESET
%token <n>TTS_RESUME
%token <n>TTS_SAY
%token <n>TTS_SET_CHARACTER_SCALE
%token <n>TTS_SET_PUNCTUATIONS
%token <n>TTS_SET_SPEECH_RATE
%token <n>TTS_SPLIT_CAPS
%token <n>TTS_SYNC_STATE

/* suffixed with _ to prevent conflict in config.h */
%token <n>VERSION_

%token <c>CHAR
%token <s>TEXT


%type <d>tts_set_character_scale

%type <n>beep
%type <n>character
%type <n>cmd
%type <n>code
%type <n>dispatch
%type <n>immediate_speech
%type <n>punctlevel
%type <n>queued_speech
%type <n>silence
%type <n>sound
%type <n>speech
%type <n>stop
%type <n>tone
%type <n>version

%type <n>tts_allcaps_beep
%type <n>tts_capitalize
%type <n>tts_set_punctuations
%type <n>tts_set_speech_rate
%type <n>tts_split_caps
%type <n>tts_sync_state
%type <n>tts_pause
%type <n>tts_reset
%type <n>tts_resume


%%

cmdlist
	: 
	| cmdlist cmd
	;

cmd
	: code { $$ = $1; }
	| speech { $$ = $1; }
	| dispatch { $$ = $1; tts_d(); }
	| stop { $$ = $1; tts_s(); }
	| version { $$ = $1; tts_version(); }
	| silence { $$ = $1; tts_sh($1); }
	| beep { $$ = $1; }
	| tone { $$ = $1; }
	| sound { $$ = $1; }
		| tts_pause { $$ = $1; tts_pause(); }
	| tts_reset { $$ = $1; tts_reset(); }
	| tts_resume { $$ = $1; tts_resume(); }
	| tts_allcaps_beep { $$ = $1; tts_allcaps_beep($1); }
	| tts_capitalize { $$ = $1; tts_capitalize($1); }
	| tts_set_character_scale { $$ = $1; }
	| tts_set_punctuations { $$ = $1; tts_set_punctuations($1); }
	| tts_set_speech_rate { $$ = $1; tts_set_speech_rate($1); }
	| tts_split_caps { $$ = $1; tts_split_caps($1); }
	| tts_sync_state { $$ = $1; }
	;

code
	: C '{' TEXT '}' '\n'
		{
			$$ = $1;
			tts_c($3);
		}
	| C TEXT '\n'
		{
			$$ = $1;
			tts_c($2);
		}
	;

speech
	: immediate_speech { $$ = $1; }
	| queued_speech { $$ = $1; }
	| character { $$ = $1; }
	;

immediate_speech
	: TTS_SAY '{' TEXT '}' '\n'
		{
			$$ = $1;
			tts_say($3);
		}
	| TTS_SAY TEXT '\n'
		{
			$$ = $1;
			tts_say($2);
		}
	;

character
	: L '{' CHAR '}' '\n'
		{
			$$ = $1;
			tts_l($3);
		}
	| L CHAR '\n'
		{
			$$ = $1;
			tts_l($2);
		}
	;

queued_speech
	: Q '{' TEXT '}' '\n'
		{
			$$ = $1;
			tts_q($3);
		}
	| Q TEXT '\n'
		{
			$$ = $1;
			tts_q($2);
		}
	;

dispatch
	: D '\n' { $$ = $1; }
	;

version
	: VERSION_ '\n' { $$ = $1; }
	;

stop
	: S '\n' { $$ = $1; }
	;

silence
	: SH '{' INTEGER '}' '\n' { $$ = $3; }
	| SH INTEGER '\n' { $$ = $2; }
	;

beep
	: B '{' INTEGER INTEGER '}' '\n'
		{
			$$ = $1;
			tts_b($3, $4);
		}
	| B INTEGER INTEGER '\n'
		{
			$$ = $1;
			tts_b($2, $3);
		}
	;

tone
	: T '{' INTEGER INTEGER '}' '\n'
		{
			$$ = $1;
			tts_t($3, $4);
		}
	| T INTEGER INTEGER '\n'
		{
			$$ = $1;
			tts_t($2, $3);
		}
	;

sound
	: A '{' TEXT '}' '\n'
		{
			$$ = $1;
			tts_a($3);
		}
	| A TEXT '\n'
		{
			$$ = $1;
			tts_a($2);
		}
	;

tts_pause
	: TTS_PAUSE '\n' { $$ = $1; }
	;

tts_reset
	: TTS_RESET '\n' { $$ = $1; }
	;

tts_resume
	: TTS_RESUME '\n' { $$ = $1; }
	;

tts_allcaps_beep
	: TTS_ALLCAPS_BEEP '{' FLAG '}' '\n' { $$ = $3; }
	| TTS_ALLCAPS_BEEP FLAG '\n' { $$ = $2; }
	;

tts_capitalize
	: TTS_CAPITALIZE '{' FLAG '}' '\n' { $$ = $3; }
	| TTS_CAPITALIZE FLAG '\n' { $$ = $2; }
	;

tts_set_character_scale
	: TTS_SET_CHARACTER_SCALE '{' DOUBLE '}' '\n'
		{
			$$ = $1;
			tts_set_character_scale($3);
		}
	| TTS_SET_CHARACTER_SCALE DOUBLE '\n'
		{
			$$ = $1;
			tts_set_character_scale($2);
		}
	;

tts_set_punctuations
	:	TTS_SET_PUNCTUATIONS '{' punctlevel '}' '\n' { $$ = $3; }
	| TTS_SET_PUNCTUATIONS punctlevel '\n' { $$ = $2; }
	;

tts_set_speech_rate
	: TTS_SET_SPEECH_RATE '{' INTEGER '}' '\n' { $$ = $3; }
	| TTS_SET_SPEECH_RATE INTEGER '\n' { $$ = $2; }
	;

tts_split_caps
	: TTS_SPLIT_CAPS '{' FLAG '}' '\n' { $$ = $3; }
	| TTS_SPLIT_CAPS FLAG '\n' { $$ = $2; }
	;

tts_sync_state
	: TTS_SYNC_STATE '{' punctlevel FLAG FLAG FLAG INTEGER '}' '\n'
		{ 
			$$ = $1;
			tts_sync_state($3, $4, $5, $6, $7);
		}
	| TTS_SYNC_STATE punctlevel FLAG FLAG FLAG INTEGER '\n'
		{
			$$ = $1;
			tts_sync_state($2,$3, $4, $5, $6);
		}
	;

punctlevel
	: PUNCT_NONE { $$ = PUNCT_LEVEL_NONE; }
	| PUNCT_SOME { $$ = PUNCT_LEVEL_SOME; }
	| PUNCT_ALL { $$ = PUNCT_LEVEL_ALL; }
	;

%%

void yyerror(const char *s)
{
	fprintf(stderr, "%s\n", s);
}
/*
int main(int argc, char **argv) {
	if(argc > 1 && !strcmp(argv[1], "-d")) {
		yydebug = 1; argc--; argv++;
	}

	int res = tts_initialize();
	if (res == -1) {
		printf("Failed\n");
		return 1;
	}

	yyparse();
	return 0;
}


*/

