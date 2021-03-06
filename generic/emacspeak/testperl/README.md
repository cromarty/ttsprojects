
# Files

This directory contains Perl scripts and modules, and other test files used for testing the 
Emacspeak protocol parser in `../parser/parser.yp`.

## generate_parser.sh

This script does the generation of the `Parse/Emacspeak.pm` module by running:

	yapp -m Emacspeak parser.yp

After cding to the right place (`Parse`).

# testparser.pl

A Perl script to test the parser and semantic action modules.

## parser.yp

Actually a soft-link to ../parser/perl/parser.yp

## Notes

## Semantic actions in the parser

In Parse::Yapp semantic actions are called in the rules section.

The parser object contains a user-data area which resolves to an anonymous hash.

I have used the hash to contain references to semantic action subroutines to be defined in any 
program using the module.

The user-data is:

	$parser->YYData

And it is always accessed in the rules section of the grammar like this:

	$_[0]->YYData

$_[0] in any rule always contains the parser object.

And I have used the key 'SA' into the hash to store subroutine references.

So, for example to call tts_say (immediate speech), load the parser user-data with this call:

	$parser->YYData->{SA}->{tts_say} = \&tts_say;

In the rules section of the grammar (.yp) file, this action is called like this:

	&{$_[0]->YYData->{tts_say}}($_[x]);

See:

	man Parse::Yapp

For more about YYData.

