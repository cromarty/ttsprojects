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

#include "queue.h"

#define NO_SYNC -1

#define PUNCT_LEVEL_NONE 0
#define PUNCT_LEVEL_SOME 1
#define PUNCT_LEVEL_ALL 2

typedef struct tts_queue_entry
{
	int			type;
	int length;
	void			*speech;
} TTS_QUEUE_ENTRY_T;

void tts_version(void);
void tts_say(char*);
void tts_l(const char ch);
void tts_d(void);
void tts_pause(void);
void tts_resume(void);
void tts_s(void);
void tts_q(char *text);
void tts_c(const char *code);
void tts_a(const char *filename);
void tts_t(int freq, int length);
void tts_sh(int durationms);

void tts_reset(void);
void tts_set_punctuations(int);
void tts_set_speech_rate(int);
void tts_set_character_scale(double factor);
void tts_split_caps(int flag);
void tts_capitalize(int flag);
void tts_allcaps_beep(int flag);

void tts_sync_state(int, int, int, int, int);

int tts_initialize(void);
int tts_terminate(void);


#endif




