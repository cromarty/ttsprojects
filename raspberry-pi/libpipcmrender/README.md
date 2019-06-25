
# `libpipcmrender`

This is the directory where the libpipcmrender library code and
additional stuff is to be found.

## What is it?

The Raspberry Pi currently has a nasty problem with the ALSA driver.
Text-to-speech using the speakup screen-reader and the eSpeak software
speech-synthesizer stutters very badly and causes a regular kernel
oops.

NOTE: 'Currently' is some time in 2014.

The Raspberry Pi has a mechanism known as the 'VCHIQ', for 'video core
hardware interface queue'.  It is this mechanism which regularly tries
to pass the kernel a null-pointer from the ALSA driver.  The cause of
the stuttering is not exactly known.

The Pi has a GPU (Graphics Processing Unit) which is responsible for
both video and audio rendering.

This library uses the OpenMAX library, via the 'integration layer' to
render audio from eSpeak directly on the GPU, thus bypassing the ALSA
driver.

`espeak` has a mode in which it can be asked to return the PCM (pulse
code modulation) data of rendered text-to-speech back to a callback
function.

That's what this library does before queueing the audio PCM into the GPU.

## `piespeakup2`

Elsewhere in the same github repository you will find a fork of espeakup, the
SpeakUp to eSpeak connector.

`piespeakup2` uses this library to read the console and pass PCM
passed back from eSpeak into the GPU for rendering.

## Library Name Change

August 2017.

This library was originally called `libilctts`, but that name was never very 
descriptive.

When I needed to make changes to the library in August 2017 before writing a 
speech-dispatcher audio driver which used it, I decided to change the name to 
`libpipcmrender`.

Note that to date, June 2019, I have not written the
`speech-dispatcher` module.

## Additions in June 2019

Some time in 2018, or ery early in 2019, the problems in the ALSA
driver were fixed and the stuttering problem disappeared.

But when revisiting `speakup` and the use of `espeak` and the newer
`espeak-ng` with `espeakup`, it was discovered that the text-to-speech
was clipping very badly.

This is not the same problem as the stuttering, but renders
text-to-speech unusable.

## How to build this library

This is the sequence:

```
$ autoreconf -fi
$ ./configure
$ make
$ sudo make install
$ ldconfig
```

If you do not run `autoreconf -fi` before you run `./configure`, you
will get complaints about the version of `aclocal`.

After the `make` and `sudo make install`, running `ldconfig` updates
the list of where libraries are located, which is necessary for
`piespeakup2` (see ../piespeakup2) to start successfully.

## Bug

There is some kind of bug in this library, or in `piespeakup2` which
makes it fall silent after the Pi has been running for a few days.

This may be a memory leak, a thread deadlock, or some other problem.

As it is an infrequent crash, I have not tried very hard to find it,
and to do so would need a lot of logging code added to the library to
try to find where the deadlock is.

I suspect it is a deadlock, as the memory footprint does not seem to
change over time.

