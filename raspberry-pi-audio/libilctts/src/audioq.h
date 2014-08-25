
typedef struct {
	long num_samples;
	short *audio_chunk;
} PLAYBACK_QUEUE_AUDIO_CHUNK_T;


typedef struct {
	PLAYBACK_QUEUE_ENTRY_TYPE_T type;
	union {
		char *markId;
		PLAYBACK_QUEUE_AUDIO_CHUNK_T audio;
		char *sound_icon_filename;
	} data;
} PLAYBACK_QUEUE_ENTRY_T;







