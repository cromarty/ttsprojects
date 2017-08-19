
## Rendering text read from Standard Input ##

The code in this test reads from standard input and renders the tts.

Usage: testlib <wpm>

wpm is a number for the speech rate.

For example to speak the boot messages:

	dmesg | ./testlib 160


