#include <stdio.h>
#include <stdlib.h>

#include "tts_engine.h"


typedef struct tts_state_
{
	int punct_level;
	int pitch_rise;
	int caps_beep;
	int split_caps;
	int speech_rate;
	int capitalize;
	double character_scale;
} TTS_STATE_T;

TTS_STATE_T tts_state;
 
int tts_version(void)
{
	printf("Called version\n");
	return 0;
}

int tts_say(char *text)
{
	printf("Called tts_say: %s\n", text);
	return 0;
} /* end tts_say */

int tts_l(const char *ch)
{
	printf("Called tts_l: %s\n", ch);
	return 0;
} /* end tts_l */

int tts_d(void)
{
	printf("Called tts_d function\n");
	return 0;
} /* end tts_d */

int tts_pause(void)
{
	printf("Called tts_pause\n");
	return 0;
} /* end tts_pause */

int tts_resume(void)
{
	printf("Called tts_resume\n");
	return 0;
} /* end tts_resume */

int tts_s(void)
{
	printf("Called tts_s function\n");
	return 0;
} /* end tts_s */

int tts_q(const char *speech)
{
	printf("Called tts_q to queue speech: ->%s<-\n", speech);
	return 0;
} /* end tts_q */

int tts_c(const char *code)
{
	printf("Called tts_c: %s\n", code);
	return 0;
} /* end tts_c */

int tts_a(const char *filename)
{
	printf("Called tts_a: %s\n", filename);
	return 0;
} /* end tts_a */

int tts_t(int pitch, int duration)
{
	printf("Called tts_t function: %d %d\n", pitch, duration);
	return 0;
} /* end tts_t */

int tts_sh(int duration_milliseconds)
{
	printf("Called tts_sh: %d\n", duration_milliseconds);
	return 0;
} /* end tts_sh */

int tts_reset(void)
{
	printf("Called tts_reset\n");
	return 0;
} /* end tts_reset */

int tts_set_punctuations(int punct_level)
{
	printf("Called set punct level: %d\n", punct_level);
	return 0;
} /* end tts_set_punctuations */

int tts_set_speech_rate(int speech_rate)
{
	tts_state.speech_rate = speech_rate;
	printf("Called tts_set_speech_rate: %d\n", speech_rate);
	return 0;
} /* end tts_set_speech_rate */

int tts_set_character_scale(double character_scale)
{
	tts_state.character_scale = character_scale;
	printf("Called tts_set_character_scale: %f\n", character_scale);
	return 0;
} /* end tts_set_character_scale */

int tts_split_caps(int split_caps)
{
	tts_state.split_caps = split_caps;
	printf("Called tts_split_caps: %d\n", split_caps);
	return 0;
} /* end tts_split_caps */

int tts_capitalize(int capitalize)
{
	tts_state.capitalize = capitalize;
	printf("Called tts_capitalize: %d\n", capitalize);
	return 0;
} /* end tts_capitalize */

int tts_allcaps_beep(int allcaps_beep)
{
	tts_state.caps_beep = allcaps_beep;
	printf("Called tts_allcaps_beep: %d\n", allcaps_beep);
	return 0;
} /* end tts_allcaps_beep */



int tts_sync_state(
	int punct_level,
	int pitch_rise,
	int caps_beep,
	int split_caps,
	int speech_rate)
{
	tts_state.punct_level = punct_level;
	tts_state.pitch_rise = pitch_rise;
	tts_state.caps_beep = caps_beep;
	tts_state.split_caps = split_caps;
	tts_state.speech_rate = speech_rate;

	printf("Called tts_sync_state: %d %d %d %d %d\n", punct_level, pitch_rise, caps_beep, split_caps, speech_rate);

	return 0;
} /* end tts_sync_state */


int tts_initialize(void)
{
	printf("Called tts_initialize\n");
	return 0;
} /* end tts_initialize */

int tts_terminate(void)
{
	printf("Called tts_terminate\n");
	return 0;
} /* end tts_terminate */

