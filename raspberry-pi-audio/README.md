
## Rendering text-to-speech audio on the Raspberry Pi GPU ##

In this sub-directory is code to implement a library to render text-to-speech 
audio, as produced by the eSpeak software speech-synthesiser, on the GPU in the 
RaspberryPi.

It uses the OMX Integration Layer Client code
found in 'userland', which is in /opt/vc on Raspbian and which can be downloaded and built for other distros with:

git clone https://github.com/raspberrypi/userland.git

### Why? ###

I have done this for a number of reasons:

I discovered early in 2013 that the speakup, console-mode screen-reader 
which is designed to run on Linux was not reliable on the Raspberry Pi.

With the speakup kernel modules speakup and speakup_soft loaded, text-to-speech 
via espeak is regularly causing a kernel oops.

This is because the mechanism for queueing chunks of PCM audio into the 
rendering engine, the Video Core Hardware Interface Queue (VCHIQ), is 
frequently passing the kernel a null-pointer.

This has only been the case since a modification to the snd-bcm2835 
sound-driver in early 2013, to introduce DMA was made.

In addition to the above, the speech stutters so badly as to be unusable.

Using the OpenMAX IL to render audio directly on the Broadcom GPU 
(Graphics Processing Unit) will completely bypass ALSA, pulseaudio, any 
other user-space sound library and the snd-bcm2835 driver.

### The Library ###

The library is called 

* libilctts

For integration layer client text-to-speech. In reality it can be used for other 
purposes where passing it raw PCM to render would be useful.

### how the library will be used

The library can be used in a number of ways.

The way espeak produces synthesised speech is important here.

espeak can be used in several ways.  Two major modes are synchronous and 
asynchronous.  Here we are only interested in asynchronous modes as used 
by screen-readers and supporting software.

Furthermore, espeak can either be made to play the rendered speech 
itself by the use of a common Linux sound library, like ALSA, pulseaudio 
or libao, or it can be made to pass the PCM data back to the calling 
program via a callback function.

In the first 'alpha' release of the audio code library it is intended to modify 
an existing program, called espeakup, to use the library instead of it 'asking' 
espeak to play the speech internally.

This was decided because as espeakup is not a dependency of anything, it can be 
installed from source without any other package or sub-system complaining that 
the espeakup package is not installed.

The modified version of espeakup will be called 'piespeakup'.  See the directory 
list below.

This is a rough 'diagram' of how speakup, espeakup and espeak work together to 
make the console accessible:

speakup ---> espeakup ---> espeak

Speakup is the actual screen-reader.  espeakup is a connector that reads the 
'soft-synth' created by speakup, and espeak is the actual speech-synthesiser.
Speakup is implemented as a series of kernel modules, so the espeakup connector 
is needed to connect a kernel-space process with the user-space synthesiser.

It is then intended to write a new audio driver source file to link into espeak 
which uses the library.

In the espeak source tree there are *.cpp files prefixed with 'wave'. 
Each of these files provides the code to interface to a different audio 
library.

There are files called:

* wave.cpp

wave.cpp is a special case in that it contains code for both portaudio and pulseaudio in one file.

Changes will need to be made to the Makefile for espeak. It is intended 
to provide a new sound driver in the file 'wave_rpi.cpp' and to provide 
a patch for the espeak source tree.

### Many Fixes in One ###

Modifying espeak in this way will fix a number of existing issues and pre-empt 
another:

* Fix the Speakup screen-reader whenused with espeak.
* Fix the use of Emacspeak, when that too is used with espeak.

### What that WON'T Fix ###

* Orca, the GUI screen-reader.

Currently the only real option for a screen-reader in the GUI is Orca, which 
makes use of a program called speech-dispatcher.

As speech-dispatcher uses it's own module which calls espeak and then plays the 
rendered text-to-speech itself, this won't fix potential problems with kernel 
crashes and stuttering without first writing a new speech-dispatcher module to 
use this library.

### The sub-directories to this one ###

* espiespeak/

An Emacspeak server that uses this library. Still under development.

* libilctts/

The actual library code and related stuff.

* piespeak/

Ancillary files necessary to modify espeak to work with this library.

* piespeakup/

A new version of espeakup, the speakup to espeak connector.

* sd_piespeak/

New speech-dispatcher module to use this library. Still under development.

