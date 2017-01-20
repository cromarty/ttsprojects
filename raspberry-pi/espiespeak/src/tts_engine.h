/*
*
* Copyright (C) 2014 Mike Ray <mike.ray@btinternet.com>
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

#ifndef TTS_ENGINE_H
#define TTS_ENGINE_H

#define NO_SYNC -1

#define PUNCT_LEVEL_NONE 0
#define PUNCT_LEVEL_SOME 1
#define PUNCT_LEVEL_ALL 2

int tts_version(void);
int tts_say(char*);
int tts_l(const char *ch);
int tts_d(void);
int tts_pause(void);
int tts_resume(void);
int tts_s(void);
int tts_q(const char *text);
int tts_c(const char *code);
int tts_a(const char *filename);
int tts_t(int freq, int length);
int tts_sh(int durationms);

int tts_reset(void);
int tts_set_punctuations(int);
int tts_set_speech_rate(int);
int tts_set_character_scale(double factor);
int tts_split_caps(int flag);
int tts_capitalize(int flag);
int tts_allcaps_beep(int flag);

int tts_sync_state(int, int, int, int, int);

int tts_initialize(void);
int tts_finalize(void);


#endif




