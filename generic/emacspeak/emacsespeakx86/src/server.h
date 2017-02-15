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
*--code--*/

#ifndef SERVER_H
#define SERVER_H

#include <espeak/speak_lib.h>

#include "queue.h"
#include "server.h"

#define NO_SYNC -1

#define PUNCT_LEVEL_NONE espeakPUNCT_NONE
#define PUNCT_LEVEL_SOME espeakPUNCT_SOME
#define PUNCT_LEVEL_ALL espeakPUNCT_ALL


typedef struct tts_state
{
	int punct_level;
	int pitch_rise;
	int caps_beep;
	int split_caps;
	int speech_rate;
	int capitalize;
	double character_scale;
} TTS_STATE_T;

typedef struct tts_queue_entry
{
	int			type;
	int length;
	void			*speech;
} TTS_QUEUE_ENTRY_T;


void free_queue_entry(void *data);
int queue_speech(int entry_type, char *speech);
int send_speech(void);
int empty_queue(void);
void *dispatch_thread(void *arg);

void tts_version(void);
void tts_say(char*);
void tts_l(const char ch);
void tts_d(void);
void tts_pause(void);
void tts_resume(void);
void tts_s(void);
void tts_q(char *text);
void tts_c(char *code);
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




