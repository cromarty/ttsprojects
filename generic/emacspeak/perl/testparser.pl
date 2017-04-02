#!/usr/bin/perl -w

use strict;
use warnings;

use EmacspeakParser;

my $parser = new EmacspeakParser();


my $value = $parser->YYParse(
		yylex => \&MyParser::_Lexer,
		yyerror => \&MyParser::_Error
	);

my $nberr = $parser->YYNberr();

$parser->YYData->{DATA} = [ 'Anything', 'You Want' ];

my $data = $parser->YYData->{DATA}[0];


