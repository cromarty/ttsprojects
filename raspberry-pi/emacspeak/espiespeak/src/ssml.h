#ifndef SSML_H
#define SSML_H

typedef struct ssml_tag
{
	char tag[100];
	int tag_len;
} SSML_TAG_T;

int ssml_voice_tag(char *tag, const char *xml_lang, const char *gender, int variant);
int ssml_voice_tag_close(char *tag);
int ssml_prosody_tag(char *tag, int pitch);
int ssml_prosody_tag_close(char *tag);
int ssml_say_as_tag(char *tag);
int ssml_say_as_tag_close(char *tag);

#endif

