#include <stdlib.h>
#include <stdio.h>
#include <string.h>


int ssml_voice_tag(char *tag, const char *xml_lang, const char *gender, int variant)
{
	sprintf(tag, "<voice xml:lang=\"%s\" gender=\"%s\" variant=\"%d\">", xml_lang, gender, variant);
	return strlen(tag);
} /* end ssml_voice_tag */


int ssml_voice_tag_close(char *tag)
{
	sprintf(tag, "</voice>\0");
	return strlen(tag);
} /* end ssml_voice_tag_close */


int ssml_prosody_tag(char *tag, int pitch)
{
	sprintf(tag, "<prosody pitch=\"high\">");
	return strlen(tag);
} /* end ssml_prosody_tag */

int ssml_prosody_tag_close(char *tag)
{
	sprintf(tag, "</prosody>\0");
	return strlen(tag);
} /* end ssml_prosody_tag_close */

int ssml_say_as_tag(char *tag)
{
	sprintf(tag, "<say-as interpret-as=\"characters\" format=\"characters\">\0");
	return strlen(tag);
} /* end ssml_say_as_tag */

int ssml_say_as_tag_close(char *tag)
{
	sprintf(tag, "</say-as>\0");
	return strlen(tag);
} /* end ssml_say_as_tag_close */
 
