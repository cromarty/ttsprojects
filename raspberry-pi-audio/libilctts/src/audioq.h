
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







