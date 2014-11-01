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

typedef struct {
	long num_samples;
	short *audio_chunk;
} PBQ_AUDIO_CHUNK_T;


typedef struct {
	PBQ_ENTRY_TYPE_T type;
	union {
		char *markId;
		PBQ_AUDIO_CHUNK_T audio;
		char *sound_icon_filename;
	} data;
} PBQ_ENTRY_T;







