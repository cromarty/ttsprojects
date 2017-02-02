#ifndef ESPEAK_H
#define ESPEAK_H


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

void free_queue_entry(void *data);
int queue_speech(Queue *queue, int entry_type, const char *speech);
int send_speech(Queue*);
int empty_queue(Queue*);
void *dispatch_thread(void *arg);

#endif


