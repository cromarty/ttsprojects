#!/usr/bin/perl -w

use strict;
use warnings;

use EmacspeakParser;

my $parser = new EmacspeakParser();

my $value = $parser->YYParse(
		yylex => \&EmacspeakParser::_Lexer,
		yyerror => \&EmacspeakParser::_Error
	);

my $nberr = $parser->YYNberr();

$parser->Run;
