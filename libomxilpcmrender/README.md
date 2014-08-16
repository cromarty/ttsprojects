### libomxilpcmrender

This code is an attempt to write a new audio driver for eSpeak, using the 
OpenMax Integration Layer.

espeak is the software speech-synthesiser best for language support, speed 
and small size.

I am doing this for some very good reasons:

1. In about April 2013 there was a modification to the snd-bcm2835 sound-driver 
for the Raspberry Pi which resulted in eSpeak stuttering very badly.  The 
modification was to add DMA to the driver.
2. There is a problem with using eSpeak in the asynchronous mode that espeakup, 
speech-dispatcher and emacspeak use.  The VCHIQ (Video Core Hardware Interface 
Queue) mechanism used to queue audio into the Raspberry Pi GPU frequently causes 
a kernel oops by passing the kernel a null-pointer.

It is hoped this code, which will render PCM audio directly on the GPU, 
bypassing the snd-bcm2835 driver, will solve these problems.

Also, there are frequent conflicts between pulseaudio and alsa which make 
desktop and console mode difficult to make accessible at the same time.  The 
Gnome screen-reader, Orca, uses pulse (yuck).

I am directly modifying eSpeak because to do so will fix espeakup and emacspeak 
in one hit.

It will be necessary to write anew driver for speech-dispatcher as well.  This 
libomxilpcmrender library should make that task easier.

I have drawn heavily on code from other GPL projects using the OMX IL.

### How eSpeak works for rendering PCM

eSpeak can be used in a couple of different ways:

AUDIO_OUTPUT_PLAYBACK

An asynchronous mode in which text-to-speech is rendered in PCM and played back 
by the sound-driver selected in eSpeak.  Currently it will work with ALSA, 
pulseaudio, libao and, I think OSS.

AUDIO_OUTPUT_RETRIEVAL

In this mode, a program linking to the eSpeak API supplies a callback function 
which is passed the PCM when text-to-speech has been rendered.  The program then 
plays the PCM in whatever way it likes.

### Tools that currently use eSpeak to provide tts to access technology:

#### espeakup

espeakup is a program that connects the kernel-mode screen-reader 'speakup' to 
espeak. Hence the hybrid name.

It uses espeak in the AUDIO_OUTPUT_PLAYBACK mode, hence espeak plays the tts via 
the selected sound-system.

This library should make it easy to also convert espeakup to 
AUDIO_OUTPUT_RETRIEVAL, leaving espeak untouched.

#### speechd-up

speechd-up connects the kernel-mode screen-reader 'speakup' to 
speech-dispatcher, which includes an espeak sound-driver which uses the 
AUDIO_OUTPUT_RETRIEVAL mode.

#### Emacspeak

Emacspeak has a tts server which links to espeak.

#### Synchronous Mode

espeak includes synchronous mode on the command-line to render strings.  This 
does not stutter or appear to crash the kernel.


