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
*--code--*/

%option noyywrap

%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include "parser.h"
#include "server.h"

#undef YY_INPUT
#define YY_INPUT(b, r, m) 	input_for_lexer(b, &r, m)

%}

/* start conditions, in most cases X plus the emacspeak proto function name */
%x XA XB XC XD XL XPL XQ XS XSAY XSH XSYNC XT XTTS XSCALE XVERSION

	/* code, with or without braces */
code 	^(c[ ]+[^{\n]|c[ ]+"{")

	/* single letter, with or without braces  */
letter 	^(l[ ]+[^{\n]|l[ ]+"{")

	/* queued speech, with or without braces */
queue 	^(q[ ]+[^{\n]|q[ ]+"{")

	/* tts_say, immediate speech, with or without braces */
say 	^(tts_say[ ]+[^{\n]|tts_say[ ]+"{")

	/* tone, with or without braces */
tone 	^(t[ ]+[^{\n]|t[ ]+"{")

	/* beep, with or without braces */
beep 	^(b[ ]+[^{\n]|b[ ]+"{")

	/* sound file, with or without braces */
sound 	^((a|p)[ ]+[^{\n]|(a|p)[ ]+"{")

	/* silence, with or without braces */
silence 	^(sh[ ]+[^{\n]|sh[ ]+"{")

	/* Version, no arguments */
version		^version\n

	/* punctuation levels */
none	none
some	some
all	all

	/* Beginning of Perl generated patterns */

/* no arguments */
pause ^tts_pause
reset ^tts_reset
resume ^tts_resume

/* with or without braces */
allcapsbeep		^(tts_allcaps_beep[ ]+[^{\n]|tts_allcaps_beep[ ]+"{")
capitalize		^(tts_capitalize[ ]+[^{\n]|tts_capitalize[ ]+"{")
setcharacterscale		^(tts_set_character_scale[ ]+[^{\n]|tts_set_character_scale[ ]+"{")
setpunctuations		^(tts_set_punctuations[ ]+[^{\n]|tts_set_punctuations[ ]+"{")
setspeechrate		^((tts_set_speech_rate|r)[ ]+[^{\n]|(tts_set_speech_rate|r)[ ]+"{")
splitcaps		^(tts_split_caps[ ]+[^{\n]|tts_split_caps[ ]+"{")

/* with or without braces but I've never seen braces */
syncstate		^(tts_sync_state[ ]+[^{\n]|tts_sync_state[ ]+"{")
	
/* End of Perl generated patterns */

/* numeric patterns */
flag [01]
integer [0-9][0-9]+
double			[-+]?([0-9]*\.?[0-9]+|[0-9]+\.)

/* whitespace, don't include newline */
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

{beep} {
		yyless(yyleng-1);
		BEGIN XB;
		return B;
	}

{sound} {
		yyless(yyleng-1);
		BEGIN XA;
		return A;
	}

{silence}	{
		yyless(yyleng-1);
		BEGIN XSH;
		return SH;
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


	/* opening brace */
<XB,XC,XQ,XSAY,XSYNC,XT,XA,XSH,XTTS,XSCALE>"{" {
		return yytext[0];
	}

	/* closing brace or newline */
<XB,XC,XQ,XSAY,XT,XA,XSH,XTTS,XPL,XSYNC,XSCALE>("}"|"\n") {
		if (yytext[0] == '}') {
			/* do nothing with closing brace */
		} else {
			BEGIN INITIAL;
		}
		return yytext[0];
	}

	/* newline after funcs with no arguments */
<XS,XD,XVERSION>"\n" {
		BEGIN INITIAL;
		return yytext[0];
	}

	/* c function payload */
<XC>[^{}\n]+ {
	yylval.s = strdup(yytext);
		return TEXT;
	}

	/* q, tts_say or audio payload */
<XQ,XSAY,XA>[^{}\n]+ {
		yylval.s = strdup(yytext);
		return TEXT;
	}

	/* single letter payload */
<XL>[^{}\n] {
		yylval.c = yytext[0];
		return CHAR;
	}

	/* single letter opening brace */
<XL>"{" {
		return yytext[0];
	}

	/* single letter closing brace or newline */
<XL>("}"|"\n") {
		if (yytext[0] == '}') {
			/* do nothing with closing brace */
		} else {
			BEGIN INITIAL;
		}
		return yytext[0];
	}


	/* tts_* or tts_sync_state flag (single digit */
<XTTS,XSYNC>{flag}	{
		yylval.n = atoi(yytext);
		/* don't think this is really necessary */
		if (yylval.n > 1)
			yylval.n = 1;
		return FLAG;
	}

	/* sh, beep, tone, tts_* or tts_sync_state integer */
<XSH,XB,XT,XTTS,XSYNC>{integer}	{
		yylval.n = atoi(yytext);
		return INTEGER;
	}

	/* tts_set_character_scale double (eg 1.2) */
<XSCALE>{double} {
		yylval.d = atof(yytext);
		return DOUBLE;
	}

	/* dispatch */
^d\n {
		BEGIN XD;
		yyless(1);
		return D;
	}

	/* stop */
^s\n {
		BEGIN XS;
		yyless(1);
		return S;
	}

{version} {
		BEGIN XVERSION;
		yyless(yyleng-1);
		return VERSION_;
	}

	/* default pattern */
. ;
