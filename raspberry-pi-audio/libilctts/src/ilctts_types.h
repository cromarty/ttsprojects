/*
*
* <file> - <description>
*
* <short_description>
*
* Copyright (C) 2014, Mike Ray, <mike.ray@btinternet.com>
*
* This is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1, or (at your option) any later
* version.
*
* This software is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this package; see the file COPYING.  If not, write to the Free
* Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
* 02110-1301, USA.
*
*--code--*/
#ifndef ILCTTS_TYPES_H
#define ILCTTS_TYPES_H

typedef enum {
	ILCTTS_PUNCT_ALL = 0,
	ILCTTS_PUNCT_NONE = 1,
	ILCTTS_PUNCT_SOME = 2
} ILCTTSPunctuation_T;

typedef enum {
	ILCTTS_CAP_NONE = 0,
	ILCTTS_CAP_SPELL = 1,
	ILCTTS_CAP_ICON = 2
} ILCTTS_CAPITAL_LETTERS_T;

typedef enum {
	ILCTTS_SPELL_OFF = 0,
	ILCTTS_SPELL_ON = 1
} ILCTTS_SPELLING_T;

typedef enum {
	ILCTTS_MALE1 = 1,
	ILCTTS_MALE2 = 2,
	ILCTTS_MALE3 = 3,
	ILCTTS_FEMALE1 = 4,
	ILCTTS_FEMALE2 = 5,
	ILCTTS_FEMALE3 = 6,
	ILCTTS_CHILD_MALE = 7,
	ILCTTS_CHILD_FEMALE = 8
} ILCTTS_VOICE_TYPE_T;

typedef struct {
	char *name;		// Name of the voice (id)
	char *language;		// 2-letter ISO language code
	char *variant;		// a not-well defined string describing dialect etc.
} ILCTTS_VOICE_T;

typedef enum {
	ILCTTS_DATA_TEXT = 0,
	ILCTTS_DATA_SSML = 1
} ILCTTS_DATA_MODE_T;

typedef enum {
	ILCTTS_IMPORTANT = 1,
	ILCTTS_MESSAGE = 2,
	ILCTTS_TEXT = 3,
	ILCTTS_NOTIFICATION = 4,
	ILCTTS_PROGRESS = 5
} ILCTTS_PRIORITY_T;

typedef enum {
	ILCTTS_BEGIN = 1,
	ILCTTS_END = 2,
	ILCTTS_INDEX_MARKS = 4,
	ILCTTS_CANCEL = 8,
	ILCTTS_PAUSE = 16,
	ILCTTS_RESUME = 32,

	ILCTTS_ALL = 0x3f
} ILCTTS_NOTIFICATION_T;

typedef enum {
	ILCTTS_EVENT_BEGIN,
	ILCTTS_EVENT_END,
	ILCTTS_EVENT_INDEX_MARK,
	ILCTTS_EVENT_CANCEL,
	ILCTTS_EVENT_PAUSE,
	ILCTTS_EVENT_RESUME
} ILCTTS_NOTIFICATION_TYPE_T;

typedef enum {
	SORT_BY_TIME = 0,
	SORT_BY_ALPHABET = 1
} ESORT_T;

typedef enum {
	ILCTTS_MSGTYPE_TEXT = 0,
	ILCTTS_MSGTYPE_SOUND_ICON = 1,
	ILCTTS_MSGTYPE_CHAR = 2,
	ILCTTS_MSGTYPE_KEY = 3,
	ILCTTS_MSGTYPE_SPELL = 99
} ILCTTSMESSAGE_TYPE_T;

typedef struct {
	signed int rate;
	signed int pitch;
	signed int volume;

	ILCTTS_PUNCTUATION punctuation_mode;
	ILCTTS_SPELLING spelling_mode;
	ILCTTS_CAPITAL_LETTERS cap_let_recogn;

	ILCTTS_VOICE_TYPE voice_type;
	ILCTTS_VOICE voice;
} ILCTTS_MSG_SETTINGS_T;

#endif


