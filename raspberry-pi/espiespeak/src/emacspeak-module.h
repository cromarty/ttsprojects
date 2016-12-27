
/*
 *
 * Copyright (C) 2014 Mike Ray <mike.ray.1964@gmail.com>
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
 */

#ifndef EMSPK_SD_H
#define EMSPK_SD_H

#define NO_SYNC -1

#define PUNCT_LEVEL_NONE 0
#define PUNCT_LEVEL_SOME 1
#define PUNCT_LEVEL_ALL 2

int esp_sync_state(int, int, int, int, int);
int esp_set_speech_rate(int);
int esp_set_punctuations(int);
int esp_pause(void);
int esp_pause(void);
int esp_reset(void);
int esp_resume(void);
int esp_q(char*);
int esp_say(char*);




#endif




