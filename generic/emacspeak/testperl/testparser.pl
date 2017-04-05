#!/usr/bin/perl -w

use strict;
use warnings;

use EmacspeakParser;

my $debug = shift || 0;

my $parser = new EmacspeakParser();
$parser->YYData->{STATE} = 0;
my $value = $parser->YYParse(
		yylex => \&EmacspeakParser::_Lexer,
		yyerror => \&EmacspeakParser::_Error,
		yydebug => $debug
	);

my $nberr = $parser->YYNberr();

$parser->Run;
