## ttsprojects

### Miscellaneous code, notes and other stuff about text-to-speech systems

The file notes/speech_manual.txt seems to be a text copy of the original 
Double-Talk hardware speech-synthesiser manual.  It contains information which 
is useful for decoding the protocol used by SpeakUp.

The SpeakUp soft-synth kernel module, which generates /dev/softsynth uses a
sub-set of the Double-Talk commands.

In Emacspeak/ I am working on a program to connect Emacspeak to 
speech-dispatcher.

It uses Flex and Bison to generate a parser for the commands which Emacspeak 
writes to STDOUT.

In speakup/ there is an attempt to write a replacement for speechd-up, the only 
current SpeakUp to speech-dispatcher connector, as far as I know.

There are things about speechd-up that I don't like.  In particular the fact 
that in it's current state it uses a function in the speech-dispatcher API that 
has 'autospawn' hard-coded.

Read more about SpeakUp, speechd-up and speech-dispatcher in the 
speech-dispatcher directory.

In raspberry-pi is a project to write a sound-driver to render PCM 
text-to-speech directly on the Raspberry Pi GPU.  Read more about that and 
connected stuff in the README.md in that directory.

Also in the raspberry-pi-audio/ directory are:

1. piespeak/
2. piespeakup
3. espiespeak/

Read all about those things in the README.md files in those directories.

### License ###

Everything in this repository is released under the GNU General Public License, 
version 3, unless otherwise specifically stated.








