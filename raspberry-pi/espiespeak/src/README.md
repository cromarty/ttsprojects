## This is an Emacspeak speech server using the OMX code ##

The Bison parser file and flex lexer file in this directory are soft-links to 
files further up the tree:

* emacspeak.l -> ../../emacspeak/flex-lexer/emacspeak.l
* emacspeak.y -> ../../emacspeak/bison-parser/emacspeak.y

Other files:

* emacspeak-module.h
* emacspeak-sd.c
* Makefile
