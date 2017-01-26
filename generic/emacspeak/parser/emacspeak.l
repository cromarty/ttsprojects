/*
*
* Copyright (C) 2017 Mike Ray <mike.ray@btinternet.com>
*
* Flex lexer for the Emacspeak text-to-speech protocol. Requires emacspeak.y.
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

#include "emacspeak.tab.h"
#include "tts_engine.h"

char *buf;

%}


%x CODE LETTER QUEUE SAY TONE SND SILENCE SYNC PUNCTLEVEL TTS SCALE DISPATCH FLUSH VRSN

	/* code */
code 	^(c[ ]+[^{\n]|c[ ]+"{")

	/* single letter */
letter 	^(l[ ]+[^{\n]|l[ ]+"{")

	/* queued speech */
queue 	^(q[ ]+[^{\n]|q[ ]+"{")

	/* tts_say, immediate speech */
say 	^(tts_say[ ]+[^{\n]|tts_say[ ]+"{")

	/* tone */
tone 	^(t[ ]+[^{\n]|t[ ]+"{")

	/* sound file */
sound 	^(a[ ]+[^{\n]|a[ ]+"{")

	/* silence */
silence 	^(sh[ ]+[^{\n]|sh[ ]+"{")

	/* Version */
version		^version\n

	/* punctuation levels */
none	none
some	some
all	all

	/* Beginning of Perl generated patterns */

pause ^tts_pause
reset ^tts_reset
resume ^tts_resume

allcapsbeep		^(tts_allcaps_beep[ ]+[^{\n]|tts_allcaps_beep[ ]+"{")
capitalize		^(tts_capitalize[ ]+[^{\n]|tts_capitalize[ ]+"{")
setcharacterscale		^(tts_set_character_scale[ ]+[^{\n]|tts_set_character_scale[ ]+"{")
setpunctuations		^(tts_set_punctuations[ ]+[^{\n]|tts_set_punctuations[ ]+"{")
setspeechrate		^(tts_set_speech_rate[ ]+[^{\n]|tts_set_speech_rate[ ]+"{")
splitcaps		^(tts_split_caps[ ]+[^{\n]|tts_split_caps[ ]+"{")
syncstate		^(tts_sync_state[ ]+[^{\n]|tts_sync_state[ ]+"{")
	
/* End of Perl generated patterns */

flag [01]
integer [0-9][0-9]+
double			[-+]?([0-9]*\.?[0-9]+|[0-9]+\.)

ws [ \t\r\f\v]

%%

{code} {
		yyless(yyleng-1);
		BEGIN CODE;
		return C;
	}

{letter} {
		yyless(yyleng-1);
		BEGIN LETTER;
		return L;
	}

{queue} {
		yyless(yyleng-1);
		BEGIN QUEUE;
		return Q;
	}

{say}	{
		yyless(yyleng-1);
		BEGIN SAY;
		return TTS_SAY;
	}

{tone}	{
		yyless(yyleng-1);
		BEGIN TONE;
		return T;
	}

{sound} {
		yyless(yyleng-1);
		BEGIN SND;
		return A;
	}
{silence}	{
		yyless(yyleng-1);
		BEGIN SILENCE;
		return S;
	}

<PUNCTLEVEL,SYNC>{none} {
		yylval.n = PUNCT_LEVEL_NONE;
		return PUNCT_NONE;
	}

<PUNCTLEVEL,SYNC>{some} {
		yylval.n = PUNCT_LEVEL_SOME;
		return PUNCT_SOME;
	}

<PUNCTLEVEL,SYNC>{all} {
		yylval.n = PUNCT_LEVEL_ALL;
		return PUNCT_ALL;
	}

	/* Beginning of Perl generated rules */

{pause} {
		BEGIN TTS;
		return TTS_PAUSE;
	}

{reset} {
		BEGIN TTS;
		return TTS_RESET;
	}

{resume} {
		BEGIN TTS;
		return TTS_RESUME;
	}

{allcapsbeep}	{
		yyless(yyleng-1);
		BEGIN TTS;
		return TTS_ALLCAPS_BEEP;
	}

{capitalize}	{
		yyless(yyleng-1);
		BEGIN TTS;
		return TTS_CAPITALIZE;
	}

{setcharacterscale}	{
		yyless(yyleng-1);
		BEGIN SCALE;
		return TTS_SET_CHARACTER_SCALE;
	}

{setpunctuations}	{
		yyless(yyleng-1);
		BEGIN PUNCTLEVEL;
		return TTS_SET_PUNCTUATIONS;
	}

{setspeechrate}	{
		yyless(yyleng-1);
		BEGIN TTS;
		return TTS_SET_SPEECH_RATE;
	}

{splitcaps}	{
		yyless(yyleng-1);
		BEGIN TTS;
		return TTS_SPLIT_CAPS;
	}

{syncstate} {
		yyless(yyleng-1);
		BEGIN SYNC;
		return TTS_SYNC_STATE;
	}

	/* End of Perl generated rules */

<CODE,LETTER,QUEUE,SAY,SYNC,TONE,SND,SILENCE,TTS,SCALE>"{" {
		return yytext[0];
	}

<CODE,LETTER,QUEUE,SAY,TONE,SND,SILENCE,TTS,PUNCTLEVEL,SYNC,SCALE>("}"|"\n") {
		if (yytext[0] == '}') {
			/* do nothing */
		} else {
			BEGIN 0;
		}
		return yytext[0];
	}

<FLUSH,DISPATCH,VRSN>"\n" {
		BEGIN 0;
		return yytext[0];
	}

<CODE>[^{}\n]+ {
		return TEXT;
	}

<QUEUE,SAY,SND>[^{}\n]+ {
		yylval.s = malloc(yyleng);
		strcpy(yylval.s, yytext);
		return TEXT;
	}

<LETTER>[^{}\n] {
		return TEXT;
	}

<TTS,SYNC>{flag}	{
		yylval.n = atoi(yytext);
		return FLAG;
	}

<SILENCE,TONE,TTS,SYNC>{integer}	{
		yylval.n = atoi(yytext);
		return INTEGER;
	}

<SCALE>{double} {
		yylval.d = atof(yytext);
		return DOUBLE;
	}

^d\n {
		BEGIN DISPATCH;
		yyless(1);
		return yytext[0];
	}

^s\n {
		BEGIN FLUSH;
		yyless(1);
		return yytext[0];
	}

{version} {
		BEGIN VRSN;
		yyless(yyleng-1);
		return VERSION;
	}

. ;