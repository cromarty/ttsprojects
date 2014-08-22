#ifndef AUDIOQ_H
#define AUDIOQ_H

typedef struct {
	long num_samples;
	short *audio_chunk;
} PLAYBACK_QUEUE_AUDIO_CHUNK_T;

typedef enum {
	ESPEAK_QET_AUDIO,	// Chunk of audio.
	ESPEAK_QET_INDEX_MARK,	// Index mark event.
	ESPEAK_QET_SOUND_ICON,	// A Sound Icon
	ESPEAK_QET_BEGIN,	// Beginning of speech.
	ESPEAK_QET_END		// Speech completed.
} PLAYBACK_QUEUE_ENTRY_TYPE;


typedef struct {
	PLAYBACK_QUEUE_ENTRY_TYPE type;
	union {
		char *markId;
		PLAYBACK_QUEUE_AUDIO_CHUNK_T audio;
		char *sound_icon_filename;
	} data;
} PLAYBACK_QUEUE_ENTRY_T;


#endif


