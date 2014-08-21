### esproxy

This is a simple bash script that I used to collect protocol data from 
Emacspeak.

To use this, copy it to somewhere in the path, like /usr/local/bin, edit the 
LOGDIR variable in the script and replace:

DTK_SERVER=espeak

In your .bashrc with:

DTK=/usr/local/bin/esproxy

What it does:

1.  Reads data from standard input, logs it and then writes it to standard 
output.  Thus it is interposed in the Emacspeak speech-server path.

Emacspeak protocol.


