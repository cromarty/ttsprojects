#
# Copyright (C) 2017 Mike Ray <mike.ray@btinternet.com>
#
# Emacspeak speech server functions for use with the parser.yp Parse::Yapp
# grammar/parser/lexer elsewhere in this repository.
#
# This is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this package; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301, USA.
#
#--code--

#
# Work in progress, not working yet.
#
package Emacspeak;

use Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(
		tts_d tts_s tts_version
		tts_silence tts_pause tts_reset
		tts_resume tts_allcaps_beep tts_capitalize
		tts_set_punctuations tts_set_speech_rate tts_split_caps
		tts_c tts_say tts_l
		tts_q tts_b tts_t
		tts_a tts_set_character_scale tts_sync_state
	);
 
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

1;


