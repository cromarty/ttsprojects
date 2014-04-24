ttsprojects
===========

Miscellaneous code, notes and other stuff about text-to-speech systems
----------------------------------------------------------------------

The file notes/speech_manual.txt seems to be a text copy of the original
Double-Talk hardware speech-synthesiser manual.  It contains information
which is useful for decoding the protocol used by SpeakUp.

The SpeakUp soft-synth kernel module, which generates /dev/softsynth uses a
sub-set of the Double-Talk commands.

In Emacspeak/ I am working on a program to connect Emacspeak to speech-dispatcher.

It uses Flex and Bison to generate a parser for the commands which Emacspeak writes to STDOUT.

In speakup/ there is an attempt to write a replacement for speechd-up, the
only current SpeakUp to speech-dispatcher connector, as far as I know.

There are things about speechd-up that I don't like.  In particular the fact
that in it's current state it uses a function in the speech-dispatcher API that has 'autospawn' hard-coded.

Read more about SpeakUp, speechd-up and speech-dispatcher in the speech-dispatcher
directory.





