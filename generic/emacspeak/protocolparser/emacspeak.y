
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
%type <d>tts_set_character_scale

%%

cmdlist
	: 
	| cmdlist cmd
	;

cmd
	: code
	| speech
	| dispatch { printf("Got dispatch\n"); }
	| flush { printf("Got flush\n"); }
	| silence
	| tone
		| tts_pause { printf("Got pause\n"); }
	| tts_reset { printf("Got reset\n"); }
	| tts_resume { printf("Got resume\n"); }
	| tts_allcaps_beep { printf("Got all caps beep: %d\n", $1); }
	| tts_capitalize { printf("Got capitalize: %d\n", $1); }
	| tts_set_character_scale { printf("Got set character scale: %f\n", $1); }
	| tts_set_punctuations { printf("Got set punctuations: %d\n", $1); }
	| tts_set_speech_rate { printf("Got set speech rate: %d\n", $1); }
	| tts_split_caps { printf("Got split caps: %d\n", $1); }
	| tts_sync_state { printf("Got set sync state\n"); }
	;
code
	: C '{' TEXT '}' '\n'
	| C TEXT '\n'
	;

speech
	: immediate_speech { $$ = $1; printf("Got immediate speech\n"); }
	| queued_speech { $$ = $1; printf("Got queued speech\n"); }
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

flush
	: 's' '\n'
	;

silence
	: S '{' INTEGER '}' '\n' { $$ = $3; }
	| S INTEGER '\n' { $$ = $2; }
	;

tone
	: T '{' INTEGER INTEGER '}' '\n' { printf("Got tone: %d %d\n", $3, $4); $$ = $1; }
	| T INTEGER INTEGER '\n' { printf("Got tone: %d %d\n", $2, $3); $$ = $1; }
	;

tts_pause
	: TTS_PAUSE '\n'
	;

tts_reset
	: TTS_RESET '\n'
	;

tts_resume
	: TTS_RESUME '\n'
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
	: TTS_SYNC_STATE '{' punctlevel FLAG FLAG FLAG INTEGER '}' '\n'
	| TTS_SYNC_STATE punctlevel FLAG FLAG FLAG INTEGER '\n'
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

