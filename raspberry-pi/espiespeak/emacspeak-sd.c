
#include <stdio.h>
#include <stdlib.h>
#include "emacspeak-module.h"
 
/* called when we get tts_all_caps_beep */
int esp_allcaps_beep(void)
{
	printf("Called esp_allcaps_beep\n");
	return 0;
} /* end tts_allcaps_beep */

/* called when we get a tts_set_character_scale */
int esp_set_character_scale(int scale)
{
	printf("Called esp_set_character_scale: %d\n", scale);
	return 0;
} /* end tts_set_character_scale */

/* called when we get a tts_split_caps */
int esp_split_caps(int split)
{
	printf("Called esp_split_caps: %d\n", split);
	return 0;
} /* end tts_split_caps */

/* called when we get a 'tts_sync_state command */
int esp_sync_state(
		int punct_level,
		int pitch_rise,
		int caps_beep,
		int split_caps,
		int speech_rate)
{
		printf("Called esp_Sync state: %d %d %d %d %d\n", punct_level, pitch_rise, caps_beep, split_caps, speech_rate);
		return 0;
} /* end tts_sync_state */

/* called to set the speech rate */
int esp_set_speech_rate(int speech_rate)
{
		printf("Called esp_set_speech_rate: %d\n", speech_rate);
	return 0;
} /* end tts_set_speech_rate */

/* called to set punctuation to 'all', 'some' or 'none' */
int esp_set_punctuations(int punct_level)
{
		printf("Called set punct level: %d\n", punct_level);
		return 0;
} /* end tts_set_punctuations */

/* initialize the speech engine */
int esp_initialize(void)
{
		printf("Called esp_initialize\n");
	return 0;
} /* end tts_initialize */

/* pause speech but do not flush the queue */
int esp_pause(void)
{
		printf("Called esp_pause\n");
		return 0;
} /* end tts_pause */

/* reset? */
int esp_reset(void)
{
		printf("Called esp_reset\n");
		return 0;
} /* end tts_reset */

/* resume speaking the contents of the queue after a non-flushing pause */
int esp_resume(void)
{
		printf("Called esp_resume\n");
		return 0;
} /* end tts_resume */

/* queue a chunk of text for synthesis */
int esp_q(char *text)
{
		printf("Called esp_q to queue text: %s\n", text);
		return 0;
} /* end tts_q */

/* immediately say the string of text */
int esp_say(char *text)
{
		printf("Called esp_say: %s\n", text);
		return 0;
} /* end tts_say */

/* the dispatch function, called in response to a 'd' which is intended 
* to dispatch queued text for tts
*/
int esp_dispatch(void)
{
		printf("Called esp_dispatch function\n");
		return 0;
} /* end tts_dispatch */

/* silence function.  called to queue a chunk of silence */
int esp_silence(int duration_milliseconds)
{
		printf("Called esp_silence: %d\n", 
duration_milliseconds);
		return 0;
} /* end tts_silence */

/* play a tone of pitch and duration */
int esp_tone(int pitch, int duration)
{
		printf("Called esp_tone function: %d %d\n", pitch, duration);
		return 0;
} /* end tts_tone */

/* flush the queue and shut up */
int esp_flush(void)
{
		printf("Called esp_flush function\n");
		return 0;
} /* end tts_flush */

/* say a single character */
int esp_letter(char *c)
{
		printf("Called esp_letter\n");
			return 0;
} /* end tts_letter */

/* called to play a wav file */
int esp_play_file(char *filename)
{
		printf("Called esp_play_file: %s\n", filename);
		return 0;
} /* end tts_play_file */

int esp_version(void)
{
		printf("Called esp_version\n");
		return 0;
} /* end tts_version */

int esp_code(char *code)
{
		printf("Called esp_code: %s\n", code);
		return 0;
} /* end tts_code */




