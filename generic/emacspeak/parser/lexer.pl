
This is work in progress, not a working Perl script.

# code, with or without braces
s/^(c[ ]+[^{\n]|c[ ]+{)//
	and return($1,$1);

# single letter, with or without braces 
s/^(l[ ]+[^{\n]|l[ ]+{)//
and return($1,$1);

# queued speech, with or without braces
s/^(q[ ]+[^{\n]|q[ ]+{)//
and return($1,$1);

# tts_say, immediate speech, with or without braces
s/^(tts_say[ ]+[^{\n]|tts_say[ ]+{)//
and return($1,$1);

# tone, with or without braces
s/^(t[ ]+[^{\n]|t[ ]+{)//
	and return($1,$1);

# beep, with or without braces
s/^(b[ ]+[^{\n]|b[ ]+{)//
and return($1,$1);

# sound file, with or without braces
s/^((a|p)[ ]+[^{\n]|(a|p)[ ]+{)//
and return($1,$1);

# silence, with or without braces
s/^(sh[ ]+[^{\n]|sh[ ]+{)//
and return($1,$1);

# Version, no arguments
s/^version\n//
and return($1,$1);

# punctuation levels
s/^none|some|all//
and return('PLEVEL',$1);

* no arguments

# pause
s/^tts_pause//
and return('PAUSE','PAUSE');

# reset 
s/^tts_reset//
and return('RESET','RESET);

# resume 
s/^tts_resume//
and return('RESUME','RESUME');


# with or without braces

# tts_allcaps_beep		
s/^(tts_allcaps_beep[ ]+[^{\n]|tts_allcaps_beep[ ]+{)//
and return();

# tts_capitalize
s/^(tts_capitalize[ ]+[^{\n]|tts_capitalize[ ]+{)//
and return();


# tts_set_character_scale
s/^(tts_set_character_scale[ ]+[^{\n]|tts_set_character_scale[ ]+{)//
and return();

# tts_set_punctuations	
s/^(tts_set_punctuations[ ]+[^{\n]|tts_set_punctuations[ ]+{)//
and return();

# tts_set_speech_rate
s/^((tts_set_speech_rate|r)[ ]+[^{\n]|(tts_set_speech_rate|r)[ ]+{)//
and return();

# tts_split_caps
s/^(tts_split_caps[ ]+[^{\n]|tts_split_caps[ ]+"{")//
and return();

# with or without braces but I've never seen braces

# tts_sync_state
s/^(tts_sync_state[ ]+[^{\n]|tts_sync_state[ ]+{)//
and return();

# numeric patterns

# flag
s^/[01]//
and return();

# integer
s/^[0-9][0-9]+//
and return();

# double
s/^[-+]?([0-9]*\.?[0-9]+|[0-9]+\.)//
and return();

# whitespace, don't include newline
s^/[ \t\r\f\v]//
and return();

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

	#/* Beginning of Perl generated rules */

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

	#/* End of Perl generated rules */


	* opening brace 
<XB,XC,XQ,XSAY,XSYNC,XT,XA,XSH,XTTS,XSCALE>"{" {
		return yytext[0];
	}

	# closing brace or newline
<XB,XC,XQ,XSAY,XT,XA,XSH,XTTS,XPL,XSYNC,XSCALE>("}"|"\n") {
		if (yytext[0] == '}') {
			/* do nothing with closing brace */
		} else {
			BEGIN INITIAL;
		}
		return yytext[0];
	}

# newline after funcs with no arguments
<XS,XD,XVERSION>"\n" {
		BEGIN INITIAL;
		return yytext[0];
	}

# c function payload
<XC>[^{}\n]+ {
	yylval.s = strdup(yytext);
		return TEXT;
	}

#	 q, tts_say or audio payload
<XQ,XSAY,XA>[^{}\n]+ {
		yylval.s = strdup(yytext);
		return TEXT;
	}

# single letter payload
<XL>[^{}\n] {
		yylval.c = yytext[0];
		return CHAR;
	}

#	/* single letter opening brace
<XL>"{" {
		return yytext[0];
	}

# single letter closing brace or newline
<XL>("}"|"\n") {
		if (yytext[0] == '}') {
			/* do nothing with closing brace */
		} else {
			BEGIN INITIAL;
		}
		return yytext[0];
	}


# tts_* or tts_sync_state flag (single digit
<XTTS,XSYNC>{flag}	{
		yylval.n = atoi(yytext);
		/* don't think this is really necessary */
		if (yylval.n > 1)
			yylval.n = 1;
		return FLAG;
	}

# sh, beep, tone, tts_* or tts_sync_state integer
<XSH,XB,XT,XTTS,XSYNC>{integer}	{
		yylval.n = atoi(yytext);
		return INTEGER;
	}

# tts_set_character_scale double (eg 1.2)
<XSCALE>{double} {
		yylval.d = atof(yytext);
		return DOUBLE;
	}

# dispatch
^d\n {
		BEGIN XD;
		yyless(1);
		return D;
	}

# stop
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

# default pattern
. ;
