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

Using the OpenMAX IL to render audio directly on the Broadcom GPU 
(Graphics Processing Unit) will completely bypass ALSA, pulseaudio, any 
other user-space sound library and the snd-bcm2835 driver.

Also espeak text-to-speech stutters very badly even before it crashes the kernel.

### The Library ###

The library is called 

* LIBILCTTS

For integration layer client text-to-speech.

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

In the first implementation of the library it is intended to write a new 
audio driver source file to link into espeak which uses the library.

In the espeak source tree there are *.cpp files prefixed with 'wave'. 
Each of these files provides the code to interface to a different audio 
library.

There files called:

* wave.cpp

wave.cpp is a special case in that it contains code for both portaudio and pulseaudio in one file.

Changes will need to be made to the Makefile for espeak. It is intended 
to provide a new sound driver in the file 'wave_rpi.cpp' and to provide 
patches for the Makefile.

