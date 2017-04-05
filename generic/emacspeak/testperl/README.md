
# Files

This directory contains Perl scripts and modules, and other test files used for testing the 
Emacspeak protocol parser in `../parser/parser.yp`.

## EmacspeakParser.pm

This is the parser module generated thusly:

yapp -m EmacspeakParser ../parser/parser.yp

## Emacspeak.pm

Semantic action subroutines called from EmacspeakParser.pm

## generate_parser.sh

This script does the generation of the `EmacspeakParser.pm` module by running:

	yapp -m EmacspeakParser ../parser/parser.yp

## testdata.txt

File of test protocol output to pipe to `testparser.pl` thusly:

	cat testdata.txt | ./testparser.pl

# testparser.pl

A Perl script to test the parser and semantic action modules.

## Notes

The parser and semantic action modules should probably be named and installed thusly:

	Emacspeak::Parse
	Emacspeak::Semantic

At the moment I can't work out a way of putting the semantic actions in the script which `uses` the 
parser module because the parser module needs to be able to call them.

Thus the `use` line in the ../parser/parser.yp grammar would be:

	use Emacspeak::Semantic;

And the line in the server script:

	use Emacspeak::Parser;

For example a script called `espeak` (to replace existing `Emacspeak` `espeak` server:

	#!/usr/bin/perl -w

	use strict;
	use warnings;

	use Emacspeak::Parser;
	...

But it is then a fact that Emacspeak::Semantic` needs to contain server-specific subroutines.

Not ideal.


