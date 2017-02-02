/*
*
* Copyright (C) 2017 Mike Ray <mike.ray@btinternet.com>
*
* Flex lexer for the Emacspeak text-to-speech protocol. Requires parser.y
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

#include "parser.h"
#include "server.h"

//char *buf;

%}


%x XA XC XD XL XPL XQ XS XSAY XSH XSYNC XT XTTS XSCALE XVERSION

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
		BEGIN XC;
		return C;
	}

{letter} {
		yyless(yyleng-1);
		BEGIN XL;
		return L;
	}

{queue} {
		yyless(yyleng-1);
		BEGIN XQ;
		return Q;
	}

{say}	{
		yyless(yyleng-1);
		BEGIN XSAY;
		return TTS_SAY;
	}

{tone}	{
		yyless(yyleng-1);
		BEGIN XT;
		return T;
	}

{sound} {
		yyless(yyleng-1);
		BEGIN XA;
		return A;
	}
{silence}	{
		yyless(yyleng-1);
		BEGIN XSH;
		return S;
	}

<XPL,XSYNC>{none} {
		yylval.n = PUNCT_LEVEL_NONE;
		return PUNCT_NONE;
	}

<XPL,XSYNC>{some} {
		yylval.n = PUNCT_LEVEL_SOME;
		return PUNCT_SOME;
	}

<XPL,XSYNC>{all} {
		yylval.n = PUNCT_LEVEL_ALL;
		return PUNCT_ALL;
	}

	/* Beginning of Perl generated rules */

{pause} {
		BEGIN XTTS;
		return TTS_PAUSE;
	}

{reset} {
		BEGIN XTTS;
		return TTS_RESET;
	}

{resume} {
		BEGIN XTTS;
		return TTS_RESUME;
	}

{allcapsbeep}	{
		yyless(yyleng-1);
		BEGIN XTTS;
		return TTS_ALLCAPS_BEEP;
	}

{capitalize}	{
		yyless(yyleng-1);
		BEGIN XTTS;
		return TTS_CAPITALIZE;
	}

{setcharacterscale}	{
		yyless(yyleng-1);
		BEGIN XSCALE;
		return TTS_SET_CHARACTER_SCALE;
	}

{setpunctuations}	{
		yyless(yyleng-1);
		BEGIN XPL;
		return TTS_SET_PUNCTUATIONS;
	}

{setspeechrate}	{
		yyless(yyleng-1);
		BEGIN XTTS;
		return TTS_SET_SPEECH_RATE;
	}

{splitcaps}	{
		yyless(yyleng-1);
		BEGIN XTTS;
		return TTS_SPLIT_CAPS;
	}

{syncstate} {
		yyless(yyleng-1);
		BEGIN XSYNC;
		return TTS_SYNC_STATE;
	}

	/* End of Perl generated rules */


<XC,XQ,XSAY,XSYNC,XT,XA,XSH,XTTS,XSCALE>"{" {
		return yytext[0];
	}

<XC,XQ,XSAY,XT,XA,XSH,XTTS,XPL,XSYNC,XSCALE>("}"|"\n") {
		if (yytext[0] == '}') {
			/* do nothing */
		} else {
			BEGIN INITIAL;
		}
		return yytext[0];
	}

<XS,XD,XVERSION>"\n" {
		BEGIN INITIAL;
		return yytext[0];
	}

<XC>[^{}\n]+ {
		return TEXT;
	}

<XQ,XSAY,XA>[^{}\n]+ {
		yylval.s = malloc(yyleng);
		strcpy(yylval.s, yytext);
		return TEXT;
	}

<XL>[^{}\n] {
		yylval.c = yytext[0];
		return CHAR;
	}

<XL>"{" {
		return yytext[0];
	}

<XL>("}"|"\n") {
		if (yytext[0] == '}') {
			/* do nothing */
		} else {
			BEGIN INITIAL;
		}
		return yytext[0];
	}


<XTTS,XSYNC>{flag}	{
		yylval.n = atoi(yytext);
		if (yylval.n > 1)
			yylval.n = 1;
		return FLAG;
	}

<XSH,XT,XTTS,XSYNC>{integer}	{
		yylval.n = atoi(yytext);
		return INTEGER;
	}

<XSCALE>{double} {
		yylval.d = atof(yytext);
		return DOUBLE;
	}

^d\n {
		BEGIN XD;
		yyless(1);
		return yytext[0];
	}

^s\n {
		BEGIN XS;
		yyless(1);
		return yytext[0];
	}

{version} {
		BEGIN XVERSION;
		yyless(yyleng-1);
		return VERSION;
	}

. ;
