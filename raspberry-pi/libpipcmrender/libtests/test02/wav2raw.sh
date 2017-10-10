#!/bin/bash
#
# Converts wav files into raw pcm.
# Give the file name with no extension on the command line.
#

avconv -i ${1}.wav -f s16le -ar 22050 -acodec pcm_s16le ${1}.raw


s16be indicates that the output format is signed 16-bit big-endian. The audio rate is changed to 22050 Hz.

You can import and play raw PCM using Audacity.


