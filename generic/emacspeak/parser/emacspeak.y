/*
*
* Copyright (C) 2017 Mike Ray <mike.ray@btinternet.com>
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
* $Id: emspk-sd.h
*--code--*/

%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "tts_engine.h"

#define YYDEBUG 1

int yylex();
void yyerror(const char *s);

%}

%union
{
	int n;
	double d;
	char *s;
}


%token <n>C
%token <n>L
%token <n>Q

%token <n>S
%token <n>T
%token <n>VERSION

%token <s>TEXT
%token <n>TTS_SAY

%token <n>TTS_PAUSE
%token <n>TTS_RESET
%token <n>TTS_RESUME

%token <n>TTS_ALLCAPS_BEEP
%token <n>TTS_CAPITALIZE
%token <n>TTS_SET_CHARACTER_SCALE
%token <n>TTS_SET_PUNCTUATIONS
%token <n>TTS_SET_SPEECH_RATE
%token <n>TTS_SPLIT_CAPS
%token TTS_SYNC_STATE

%token <d>DOUBLE
%token <n>INTEGER
%token <n>FLAG

%token <n>PUNCT_NONE
%token <n>PUNCT_SOME
%token <n>PUNCT_ALL

%type <s>speech immediate_speech queued_speech
%type <n>silence tone tts_allcaps_beep tts_capitalize tts_set_punctuations tts_set_speech_rate tts_split_caps punctlevel
%type <d>tts_set_character_scale tts_pause tts_reset tts_resume

%%

cmdlist
	: 
	| cmdlist cmd
	;

cmd
	: code
	| speech
	| dispatch { tts_d(); }
	| flush { tts_s(); }
	| version { tts_version(); }
	| silence
	| tone
		| tts_pause { tts_pause(); }
	| tts_reset { tts_reset(); }
	| tts_resume { tts_resume(); }
	| tts_allcaps_beep { tts_allcaps_beep($1); }
	| tts_capitalize { tts_capitalize($1); }
	| tts_set_character_scale { tts_set_character_scale($1); }
	| tts_set_punctuations { tts_set_punctuations($1); }
	| tts_set_speech_rate { tts_set_speech_rate($1); }
	| tts_split_caps { tts_split_caps($1); }
	| tts_sync_state { printf("Got set sync state\n"); }
	;

code
	: C '{' TEXT '}' '\n'
	| C TEXT '\n'
	;

speech
	: immediate_speech { $$ = $1; tts_say($1); }
	| queued_speech { $$ = $1; tts_q($1); }
	;

immediate_speech
	: TTS_SAY '{' TEXT '}' '\n' { $$ = $3; }
	| TTS_SAY TEXT '\n' { $$ = $2; }
	| L '{' TEXT '}' '\n' { $$ = $3; }
	| L TEXT '\n' { $$ = $2; }
	;

queued_speech
	: Q '{' TEXT '}' '\n' { $$ = $3; }
	| Q TEXT '\n' { $$ = $2; }
	;

dispatch
	: 'd' '\n'
	;

version
	: VERSION '\n'
	;

flush
	: 's' '\n'
	;

silence
	: S '{' INTEGER '}' '\n' { $$ = $3; }
	| S INTEGER '\n' { $$ = $2; }
	;

tone
	: T '{' INTEGER INTEGER '}' '\n' { tts_t($3, $4); $$ = $1; }
	| T INTEGER INTEGER '\n' { tts_t($2, $3); $$ = $1; }
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
	: TTS_SET_CHARACTER_SCALE '{' DOUBLE '}' '\n' { $$ = $3; }
	| TTS_SET_CHARACTER_SCALE DOUBLE '\n' { $$ = $2; }
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
	: TTS_SYNC_STATE '{' punctlevel FLAG FLAG FLAG INTEGER '}' '\n' { tts_sync_state($3, $4, $5, $6, $7); }
	| TTS_SYNC_STATE punctlevel FLAG FLAG FLAG INTEGER '\n' { tts_sync_state($2,$3, $4, $5, $6); }
	;

punctlevel
	: PUNCT_NONE { $$ = PUNCT_LEVEL_NONE; }
	| PUNCT_SOME { $$ = PUNCT_LEVEL_SOME; }
	| PUNCT_ALL { $$ = PUNCT_LEVEL_ALL; }
	;

%%

int main()
{
	yydebug = 0;

	yyparse();
}

void yyerror(const char *s)
{
	fprintf(stderr, "%s\n", s);
}

