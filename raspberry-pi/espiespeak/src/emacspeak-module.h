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

#ifndef EMACSPEAK_PROTO_H
#define EMACSPEAK_PROTO_H

#define NO_SYNC -1

#define PUNCT_LEVEL_NONE 0
#define PUNCT_LEVEL_SOME 1
#define PUNCT_LEVEL_ALL 2

int esp_version(void);
int esp_tts_say(char*);
int esp_l(const char);
int esp_d(void);
int esp_tts_pause(void);
int esp_tts_resume(void);
int esp_s(void);
int esp_q(const *char);
int esp_c(const *char);
int esp_a(const *filename);
int esp_t(int freq, int length);
int esp_sh(int durationms);

int esp_tts_reset(void);
int esp_set_punctuations(int);
int esp_tts_set_speech_rate(int);
int esp_tts_set_character_scale factor(double scale);
int esp_tts_split_caps(int flag);
int esp_tts_capitalize(int flag);
int esp_tts_allcaps_beep(int flag);

int esp_sync_state(int, int, int, int, int);

int esp_initialize(void);
int esp_finalize(void);


#endif




