### librpipcmrender

This code is an attempt to write a new audio driver for eSpeak, using the 
OpenMax Integration Layer.

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

I am directly modifying eSpeak because to do so will fix espeakup and emacspeak 
in one hit.

It will be necessary to write anew driver for speech-dispatcher as well.  This 
librpipcmrender library should make that task easier.

I have drawn heavily on code from other GPL projects using the OMX IL.


### How eSpeak works for rendering PCM

