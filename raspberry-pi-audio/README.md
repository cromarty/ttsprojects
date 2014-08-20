### Rendering text-to-speech audio on the Raspberry Pi GPU

In this sub-directory is code to implement a library to render text-to-speech 
audio, as produced by the eSpeak software speech-synthesiser, on the GPU in the 
RaspberryPi.

I have done this for a number of reasons:

I discovered early in 2013 that the speakup, console-mode screen-reader 
which is designed to run on Linux was not reliable on the Raspberry Pi.

With the speakup kernel modules speakup and speakup_soft loaded, text-to-speech 
via espeak is regularly causing a kernel oops.

This is because the mechanism for queueing chunks of PCM audio into the 
rendering engine, the Video Core Hardware Interface Queue (VCHIQ), is frequently 
passing the kernel a null-pointer.

This has only been the case since a modification to the snd-bcm2835 sound-driver 
in early 2013, to introduce DMA was made.

Using the OpenMAX IL to render audio directly on the Broadcom GPU (Graphics 
Processing Unit) will completely bypass ALSA, pulseaudio, any other user-space 
sound library and the snd-bcm2835 driver.

### The Library

The library is called LIBILCTTS, for integration layer text-to-speech.

### how the library will be used

The library can be used in a number of ways.

The way espeak produces synthesised speech is important here.

espeak can be used in a number of ways.  Two major modes are synchronous and 
asynchronous.  Here we are only interested in asynchronous modes as used by 
screen-readers and supporting software.

Furthermore, espeak can either be made to play the rendered speech itself by the 
use of a common Linux sound library, like ALSA, pulseaudio or libao, or it can 
be made to pass the PCM data back to the calling program via a callback 
function.

The library intends to use the second method, referred to by espeak as 
AUDIO_OUTPUT_RETRIEVAL.

The reason for doing this is to make it unnecessary to modify espeak.  espeak is 
a dependancy of several applications and forking or otherwise modifying the 
source code will complicate things for programs which depend on it, including 
the Orca screen-reader used in graphical desktops.

### espeakup becomes piespeakup

There is a program called espeakup, which is commonly used to connect the 
kernel-space screen-reader speakup with the espeak speech-synthesiser.

It is intended to modify espeakup to make piespeakup.  espeakup is not a 
dependancy of any other program that I know of, so a name change will not have 
any knock-on effects.

### espiespeak for Emacspeak

The Emacspeak complete audio desktop currently has a speech-server written in 
Tcl, which interfaces with espeak.

It is intended to create espiespeak, a new server which will again use the audio 
retrieval method to pass PCM audio to the GPU.

### speech-dispatcher and sd

The program speech-dispatcher is used by Orca in the graphical desktop to 
connect to espeak.  It can also be used as a dispatcher of tts for speakup by 
using speechd-up.

speech-dispatcher includes loadable modules which function as audio-drivers.  
One of these is called sd_espeak and again uses the audio retrieval method 
highlighted above.

It is intended to write sd_piespeak, using the LIBILCTTS library to connect 
speech-dispatcher, and hence Orca, to the GPU.






