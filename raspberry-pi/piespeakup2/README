
# piespeakup2

This is an adaptation of the espeakup program specifically for the
Raspberry Pi.

It uses the OpenMAX Integration Layer Client library I have written to
render text-to-speech directly on the Broadcom GPU and thus avoid
ALSA, pulseaudio etc.

I did this because at the time of writing the Broadcom sound-driver on
the Raspberry Pi is seriously broken for eSpeak TTS.  It stutters very
badly and regularly crashes the kernel.

See:

git clone https://github.com/cromarty/ttsprojects.git/

Mike Ray, November 2014.

## Changes of June 2019

Some time in 2018, or very early in 2019, the problems with the ALSA
driver must have been fixed, because the stuttering problem
disappeared.

But in June 2019, I was revisiting this repository because using both
espeak and espeak-ng with espeakup was 'clipping' very badly.

This is not the same stuttering problem which was solved, but
utterances were clipped very badly and TTS was unusable.

Below are instructions to build `piespeakup2`

I have added a patch file to make it possible to use `espeak-ng`
instead of vanilla `espeak`.

To patch `configure.ac`:

```
$ patch < configure.ac.ng.patch
```

The above changes the library check for libespeak to libespeak-ng, and
of course the Makefile produced will then link the newer library.

After running the patch, if you want to use libespeak-ng that is, you
then need to run:

```
$ autoreconf -f
```

And then the usual sequence:

```
$ ./configure
$ make
$ sudo make install
```

See the documentation in `../libpipcmrender` for details of how to
build the library this program uses to send PCM TTS data to the GPU on
the Raspberry Pi.

## Enabling and Starting `piespeakup2`

Before `piespeakup2` can be started, the `speakup` kernel modules need
to be loaded.

To do this for this session:

```
$ sudo modprobe speakup_soft
```

To make this persistent between boots, you need to create the file:

```
/etc/modules-load.d/speakup.conf
```

Which contains:

```

speakup_soft

```

(obviously ignore the three grave characters top and bottom, these are
`markdown` formatting and are not intended to be in the file.

The install will have created a systemd service file for piespeakup2,
and the service can be enabled and started like this:

```
$ sudo systemctl enable piespeakup2
$ sudo systemctl start piespeakup2
```

Again, note that the service will not start unless the kernel modules
for speakup are loaded.

If for some reason the service fails to start, run it at the
command-line to see more errors:

```
$ sudo piespeakup2
```

You can then kill it with:

```
$ sudo kill `pgrep piespeakup2`
```


## Original espeakup

Below here is the original espeakup author's README file:

espeakup connector
=======================

espeakup is a program which makes it possible for speakup to use
the espeak software synthesizer.  It does this by reading speakup's
softsynth device and passing the text to espeak which actually speaks.

Requirements
============

This program works with the speakup screen reader, which can be obtained
from http://linux-speakup.org, and the espeak software speech
synthesizer which can be obtained from http://espeak.sourceforge.net.
You must have both of these installed and operational.  Setting them up
is beyond the scope of this document.

Installation
============

The preferred way to install espeakup is using your distribution's
packaging system, but if your distribution does not have a package for
espeakup yet, espeakup just uses a Makefile, so you should be able to
change to the source directory, then type make, then as root, make
install.

Starting Up
===========

This program should be run after speakup is set up to communicate with a
software synthesizer and after /dev/softsynth exists.  The way this is
done is distribution specific, so it is beyond the scope of this
documentation.

Command Line Options
====================

Espeakup currently accepts the following command line options:

  --default-voice=voice, -V voice	Set default voice.
    --device=device, -D device	Set the output device, either 'local' or 'hdmi'
  --debug, -d				Debug mode (stay in the foreground).
  --help, -h				Show this help.
  --version, -v				Display the software version.

Getting the Latest Version
==========================

It is possible to download a tarball from github of any released version
as follows:

wget http://www.github.com/williamh/espeakup/tarball/vx.y

If you need a tarball for packaging purposes, one is available from
ftp://ftp.linux-speakup.org/pub/linux/goodies/espeakup-x.y.tar.bz2.

The url for the git repository is git://github.com/williamh/espeakup.git.

Acknowledgements
================

I would like to thank Marc Mulcahy, the author of the speakup to
TTSynth connector, on which this work is based.  Also, I would like
to thank Kirk Reiser and Jonathan Duddington, the
authors of Speakup and Espeak, respectively, for their work.

Questions
=========

You can contact me with questions, bugs, patches, etc, at
w.d.hubbs@gmail.com or on the speakup mailing list.  I hope you find
this software to be useful.
