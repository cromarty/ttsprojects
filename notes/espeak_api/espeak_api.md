
# espeak API Functions

ESPEAK_API int espeak_Initialize(espeak_AUDIO_OUTPUT output, int buflength, const char *path, int options);

ESPEAK_API void espeak_SetSynthCallback(t_espeak_callback* SynthCallback);

ESPEAK_API void espeak_SetUriCallback(int (*UriCallback)(int, const char*, const char*));

ESPEAK_API void espeak_SetPhonemeCallback(int (*PhonemeCallback)(const char *));

ESPEAK_API espeak_ERROR espeak_Synth(const void *text,
	size_t size,
	unsigned int position,
	espeak_POSITION_TYPE position_type,
	unsigned int end_position,
	unsigned int flags,
	unsigned int* unique_identifier,
	void* user_data);

ESPEAK_API espeak_ERROR espeak_Synth_Mark(const void *text,
	size_t size,
	const char *index_mark,
	unsigned int end_position,
	unsigned int flags,
	unsigned int* unique_identifier,
	void* user_data);

ESPEAK_API espeak_ERROR espeak_Key(const char *key_name);

ESPEAK_API espeak_ERROR espeak_Char(wchar_t character);

ESPEAK_API espeak_ERROR espeak_SetParameter(espeak_PARAMETER parameter, int value, int relative);

ESPEAK_API int espeak_GetParameter(espeak_PARAMETER parameter, int current);

ESPEAK_API espeak_ERROR espeak_SetPunctuationList(const wchar_t *punctlist);

ESPEAK_API void espeak_SetPhonemeTrace(int phonememode, FILE *stream);

ESPEAK_API const char *espeak_TextToPhonemes(const void **textptr, int textmode, int phonememode);

ESPEAK_API void espeak_CompileDictionary(const char *path, FILE *log, int flags);

ESPEAK_API const espeak_VOICE **espeak_ListVoices(espeak_VOICE *voice_spec);

ESPEAK_API espeak_ERROR espeak_SetVoiceByFile(const char *filename);

ESPEAK_API espeak_ERROR espeak_SetVoiceByName(const char *name);

ESPEAK_API espeak_ERROR espeak_SetVoiceByProperties(espeak_VOICE *voice_spec);

ESPEAK_API espeak_VOICE *espeak_GetCurrentVoice(void);

ESPEAK_API espeak_ERROR espeak_Cancel(void);

ESPEAK_API int espeak_IsPlaying(void);

ESPEAK_API espeak_ERROR espeak_Synchronize(void);

ESPEAK_API espeak_ERROR espeak_Terminate(void);

ESPEAK_API const char *espeak_Info(const char **path_data);
