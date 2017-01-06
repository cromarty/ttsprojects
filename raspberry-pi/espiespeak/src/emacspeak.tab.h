/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_EMACSPEAK_TAB_H_INCLUDED
# define YY_YY_EMACSPEAK_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TTS_ALLCAPS_BEEP = 258,
    TTS_CAPITALIZE = 259,
    TTS_INITIALIZE = 260,
    TTS_PAUSE = 261,
    TTS_RESET = 262,
    TTS_RESUME = 263,
    TTS_SAY = 264,
    TTS_SET_CHARACTER_SCALE = 265,
    TTS_SET_PUNCTUATIONS = 266,
    TTS_SET_SPEECH_RATE = 267,
    TTS_SPLIT_CAPS = 268,
    TTS_SYNC_STATE = 269,
    NAME = 270,
    QSPEECH = 271,
    NUM = 272,
    EOL = 273,
    SILENCE = 274,
    CTEXT = 275,
    LETTER = 276,
    FLUSH = 277,
    DISPATCH = 278,
    VERSION = 279,
    PLAYFILE = 280,
    TONE = 281,
    PUNCTLEVEL = 282,
    LANGUAGE = 283,
    VOICE = 284,
    CODE = 285
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 47 "emacspeak.y" /* yacc.c:1909  */

        int number;
        char *string;

#line 90 "emacspeak.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_EMACSPEAK_TAB_H_INCLUDED  */
