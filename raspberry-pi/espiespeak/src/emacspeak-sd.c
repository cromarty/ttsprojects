#include <stdio.h>
#include <stdlib.h>
#include "emacspeak-module.h"
 
int esp_version(void)
{
	printf("Called version\n");
	return 0;
}

int esp_tts_say(char *text)
{
	printf("Called esp_say: %s\n", text);
	return 0;
} /* end tts_say */

int esp_l(const char *ch)
{
	printf("Called esp_l: %s\n", ch);
	return 0;
} /* end tts_l */

int esp_d(void)
{
	printf("Called esp_d function\n");
	return 0;
} /* end tts_d */

int esp_tts_pause(void)
{
	printf("Called esp_tts_pause\n");
	return 0;
} /* end esp_tts_pause */

int esp_tts_resume(void)
{
	printf("Called esp_tts_resume\n");
	return 0;
} /* end esp_tts_resume */

int esp_s(void)
{
	printf("Called esp_s function\n");
	return 0;
} /* end tts_s */

int esp_q(const char *text)
{
	printf("Called esp_q to queue text: %s\n", text);
	return 0;
} /* end esp_q */

int esp_c(const char *code)
{
	printf("Called esp_c: %s\n", code);
	return 0;
} /* end tts_c */

int esp_a(const char *filename)
{
	printf("Called esp_a: %s\n", filename);
	return 0;
} /* end tts_a */

int esp_t(int pitch, int duration)
{
	printf("Called esp_t function: %d %d\n", pitch, duration);
	return 0;
} /* end tts_t */

int esp_sh(int duration_milliseconds)
{
	printf("Called esp_sh: %d\n", duration_milliseconds);
	return 0;
} /* end tts_sh */

int esp_tts_reset(void)
{
	printf("Called esp_tts_reset\n");
	return 0;
} /* end esp_tts_reset */

int esp_tts_set_punctuations(int punct_level)
{
	printf("Called set punct level: %d\n", punct_level);
	return 0;
} /* end tts_set_punctuations */

int esp_tts_set_speech_rate(int speech_rate)
{
	printf("Called esp_tts_set_speech_rate: %d\n", speech_rate);
	return 0;
} /* end esp_tts_set_speech_rate */

int esp_tts_set_character_scale(double factor)
{
	printf("Called esp_tts_set_character_scale: %f\n", factor);
	return 0;
} /* end tts_set_character_scale */

int esp_tts_split_caps(int split)
{
	printf("Called esp_tts_split_caps: %d\n", split);
	return 0;
} /* end esp_tts_split_caps */

int esp_tts_capitalize(int flag)
{
	printf("Called esp_tts_capitalize: %d\n", flag);
	return 0;
} /* end esp_tts_capitalize */

int esp_tts_allcaps_beep(int flag)
{
	printf("Called esp_tts_allcaps_beep: %d\n", flag);
	return 0;
} /* end esp_tts_allcaps_beep */



int esp_tts_sync_state(
	int punct_level,
	int pitch_rise,
	int caps_beep,
	int split_caps,
	int speech_rate)
{
	printf("Called esp_tts_sync_state: %d %d %d %d %d\n", punct_level, pitch_rise, caps_beep, split_caps, speech_rate);
	return 0;
} /* end esp_tts_sync_state */


int esp_initialize(void)
{
	printf("Called esp_initialize\n");
	return 0;
} /* end tts_initialize */

int esp_finalize(void)
{
	printf("Called esp_finalize\n");
	return 0;
} /* end esp_finalize */

