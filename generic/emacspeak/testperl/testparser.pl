#!/usr/bin/perl -w

use strict;
use warnings;

use EmacspeakParser;

my $debug = shift || 0;

my $parser = new EmacspeakParser();

# Preset state to zero
$parser->YYData->{STATE} = 0;

# Load references to semantic action subroutines
$parser->YYData->{SA}->{tts_d} = \&tts_d;
$parser->YYData->{SA}->{tts_s} = \&tts_s;
$parser->YYData->{SA}->{tts_version} = \&tts_version;
$parser->YYData->{SA}->{tts_silence} = \&tts_silence;
$parser->YYData->{SA}->{tts_pause} = \&tts_pause;
$parser->YYData->{SA}->{tts_reset} = \&tts_reset;
$parser->YYData->{SA}->{tts_resume} = \&tts_resume;
$parser->YYData->{SA}->{tts_allcaps_beep} = \&tts_allcaps_beep;
$parser->YYData->{SA}->{tts_capitalize} = \&tts_capitalize;
$parser->YYData->{SA}->{tts_set_punctuations} = \&tts_set_punctuations;
$parser->YYData->{SA}->{tts_set_speech_rate} = \&tts_set_speech_rate;
$parser->YYData->{SA}->{tts_split_caps} = \&tts_split_caps;
$parser->YYData->{SA}->{tts_c} = \&tts_c;
$parser->YYData->{SA}->{tts_say} = \&tts_say;
$parser->YYData->{SA}->{tts_l} = \&tts_l;
$parser->YYData->{SA}->{tts_q} = \&tts_q;
$parser->YYData->{SA}->{tts_b} = \&tts_b;
$parser->YYData->{SA}->{tts_t} = \&tts_t;
$parser->YYData->{SA}->{tts_a} = \&tts_a;
$parser->YYData->{SA}->{tts_set_character_scale} = \&tts_set_character_scale;
$parser->YYData->{SA}->{tts_sync_state} = \&tts_sync_state;


my $value = $parser->YYParse(
		yylex => \&EmacspeakParser::_Lexer,
		yyerror => \&EmacspeakParser::_Error,
		yydebug => $debug
	);

my $nberr = $parser->YYNberr();

$parser->Run;


#-- Semantic action subroutines

# These subs are called by the semantic actions in the parser.
# See the load of semantic actions above.
#
# They are called in the parser like this, for example to call tts_say:
#
# &{$_[0]->YYData->{SA}->{tts_say}}($_[n]);
#
 
sub tts_d() {
	print "Called tts_d\n";
}

sub tts_s() {
	print "Called tts_s\n";
}

sub tts_version() {
	print "Called tts_version\n";
}

sub tts_silence() {
	my ($duration) = @_;
	print "Called tts_silence: >$duration<\n";
}


sub tts_pause() {
	print "Called tts_pause\n";
}


sub tts_reset() {
	print "Called tts_reset\n";
}


sub tts_resume() {
	print "Called tts_resume\n";
}


sub tts_allcaps_beep() {
	my ($flag) = @_;
	print "Called tts_allcaps_beep: >$flag<\n";
}


sub tts_capitalize() {
	my ($flag) = @_;
	print "Called tts_capitalize: >$flag<\n";
}

sub tts_set_punctuations() {
	my ($punctuations) = @_;
	print "Called tts_set_punctuations: >$punctuations<\n";
}

sub tts_set_speech_rate() {
	my ($rate) = @_;
	print "Called tts_set_speech_rate: >$rate<\n";
}

sub tts_split_caps() {
	my ($flag) = @_;
print "Called tts_split_caps: >$flag<\n";
}


sub tts_c() {
	my ($code) = @_;
	print "Called tts_c: >$code<\n";
}


sub tts_say() {
	my ($speech) = @_;
	print "Called tts_say: >$speech<\n";
}


sub tts_l() {
	my ($letter) = @_;
	print "Called tts_l: >$letter<\n";
}


sub tts_q() {
	my ($speech) = @_;
	print "Called tts_q: >$speech<\n";
}


sub tts_b() {
	my ($pitch, $duration) = @_;
	print "Called tts_b: >$pitch<, >$duration<\n";
}

sub tts_t() {
	my ($pitch, $duration) = @_;
	print "Called tts_t: >$pitch<, >$duration<\n";
}


sub tts_a() {
	my ($sound) = @_;
	print "Called tts_a: >$sound<\n";
}


sub tts_set_character_scale() {
	my ($scale) = @_;
	print "Called tts_set_character_scale: >$scale<\n";
}

sub tts_sync_state() {
	my ($punc,$capitalize, $allcapsbeep,$splitcaps,$rate) = @_;
	print "Called tts_sync_state: $punc, $capitalize, $allcapsbeep,$splitcaps,$rate\n";
}

