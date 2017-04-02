####################################################################
#
#    This file was generated using Parse::Yapp version 1.05.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package EmacspeakParser;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
use Parse::Yapp::Driver;

#line 26 "../parser/parser.yp"


# Package of functions to be called from semantic actions
use Emacspeak;



sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.05',
                                  yystates =>
[
	{#State 0
		DEFAULT => -1,
		GOTOS => {
			'cmdlist' => 1
		}
	},
	{#State 1
		ACTIONS => {
			"TTS_RESUME" => 41,
			"TTS_PAUSE" => 14,
			"D" => 45,
			"TTS_ALLCAPS_BEEP" => 20,
			"VERSION" => 19,
			"B" => 44,
			"TTS_SYNC_STATE" => 37,
			"TTS_RESET" => 36,
			"TTS_SET_CHARACTER_SCALE" => 10,
			"A" => 40,
			"TTS_SET_SPEECH_RATE" => 39,
			"TTS_SAY" => 12,
			"TTS_SET_PUNCTUATIONS" => 7,
			"TTS_CAPITALIZE" => 27,
			'' => 26,
			"L" => 35,
			"C" => 8,
			"S" => 33,
			"TTS_SPLIT_CAPS" => 22,
			"SH" => 2,
			"Q" => 21,
			"T" => 4
		},
		GOTOS => {
			'speech' => 18,
			'code' => 43,
			'tts_split_caps' => 46,
			'stop' => 15,
			'tts_capitalize' => 13,
			'tone' => 17,
			'immediate_speech' => 42,
			'tts_allcaps_beep' => 16,
			'silence' => 38,
			'character' => 11,
			'beep' => 34,
			'tts_set_speech_rate' => 9,
			'tts_sync_state' => 29,
			'sound' => 28,
			'tts_set_punctuations' => 6,
			'queued_speech' => 32,
			'cmd' => 31,
			'tts_reset' => 30,
			'version' => 3,
			'tts_resume' => 23,
			'dispatch' => 25,
			'tts_set_character_scale' => 5,
			'tts_pause' => 24
		}
	},
	{#State 2
		ACTIONS => {
			'INTEGER' => 48,
			"{" => 47
		}
	},
	{#State 3
		DEFAULT => -7
	},
	{#State 4
		ACTIONS => {
			"{" => 49,
			'INTEGER' => 50
		}
	},
	{#State 5
		DEFAULT => -17
	},
	{#State 6
		DEFAULT => -18
	},
	{#State 7
		ACTIONS => {
			"SOME" => 51,
			"NONE" => 55,
			"{" => 53,
			"ALL" => 52
		},
		GOTOS => {
			'punctlevel' => 54
		}
	},
	{#State 8
		ACTIONS => {
			'TEXT' => 57,
			"{" => 56
		}
	},
	{#State 9
		DEFAULT => -19
	},
	{#State 10
		ACTIONS => {
			'DOUBLE' => 59,
			"{" => 58
		}
	},
	{#State 11
		DEFAULT => -26
	},
	{#State 12
		ACTIONS => {
			"{" => 61,
			'TEXT' => 60
		}
	},
	{#State 13
		DEFAULT => -16
	},
	{#State 14
		ACTIONS => {
			"\n" => 62
		}
	},
	{#State 15
		DEFAULT => -6
	},
	{#State 16
		DEFAULT => -15
	},
	{#State 17
		DEFAULT => -10
	},
	{#State 18
		DEFAULT => -4
	},
	{#State 19
		ACTIONS => {
			"\n" => 63
		}
	},
	{#State 20
		ACTIONS => {
			'FLAG' => 65,
			"{" => 64
		}
	},
	{#State 21
		ACTIONS => {
			'TEXT' => 66,
			"{" => 67
		}
	},
	{#State 22
		ACTIONS => {
			"{" => 68,
			'FLAG' => 69
		}
	},
	{#State 23
		DEFAULT => -14
	},
	{#State 24
		DEFAULT => -12
	},
	{#State 25
		DEFAULT => -5
	},
	{#State 26
		DEFAULT => 0
	},
	{#State 27
		ACTIONS => {
			'FLAG' => 70,
			"{" => 71
		}
	},
	{#State 28
		DEFAULT => -11
	},
	{#State 29
		DEFAULT => -21
	},
	{#State 30
		DEFAULT => -13
	},
	{#State 31
		DEFAULT => -2
	},
	{#State 32
		DEFAULT => -25
	},
	{#State 33
		ACTIONS => {
			"\n" => 72
		}
	},
	{#State 34
		DEFAULT => -9
	},
	{#State 35
		ACTIONS => {
			'CHAR' => 74,
			"{" => 73
		}
	},
	{#State 36
		ACTIONS => {
			"\n" => 75
		}
	},
	{#State 37
		ACTIONS => {
			"ALL" => 52,
			"SOME" => 51,
			"NONE" => 55,
			"{" => 77
		},
		GOTOS => {
			'punctlevel' => 76
		}
	},
	{#State 38
		DEFAULT => -8
	},
	{#State 39
		ACTIONS => {
			'INTEGER' => 78,
			"{" => 79
		}
	},
	{#State 40
		ACTIONS => {
			"{" => 81,
			'TEXT' => 80
		}
	},
	{#State 41
		ACTIONS => {
			"\n" => 82
		}
	},
	{#State 42
		DEFAULT => -24
	},
	{#State 43
		DEFAULT => -3
	},
	{#State 44
		ACTIONS => {
			'INTEGER' => 83,
			"{" => 84
		}
	},
	{#State 45
		ACTIONS => {
			"\n" => 85
		}
	},
	{#State 46
		DEFAULT => -20
	},
	{#State 47
		ACTIONS => {
			'INTEGER' => 86
		}
	},
	{#State 48
		ACTIONS => {
			"\n" => 87
		}
	},
	{#State 49
		ACTIONS => {
			'INTEGER' => 88
		}
	},
	{#State 50
		ACTIONS => {
			'INTEGER' => 89
		}
	},
	{#State 51
		DEFAULT => -62
	},
	{#State 52
		DEFAULT => -63
	},
	{#State 53
		ACTIONS => {
			"SOME" => 51,
			"NONE" => 55,
			"ALL" => 52
		},
		GOTOS => {
			'punctlevel' => 90
		}
	},
	{#State 54
		ACTIONS => {
			"\n" => 91
		}
	},
	{#State 55
		DEFAULT => -61
	},
	{#State 56
		ACTIONS => {
			'TEXT' => 92
		}
	},
	{#State 57
		ACTIONS => {
			"\n" => 93
		}
	},
	{#State 58
		ACTIONS => {
			'DOUBLE' => 94
		}
	},
	{#State 59
		ACTIONS => {
			"\n" => 95
		}
	},
	{#State 60
		ACTIONS => {
			"\n" => 96
		}
	},
	{#State 61
		ACTIONS => {
			'TEXT' => 97
		}
	},
	{#State 62
		DEFAULT => -44
	},
	{#State 63
		DEFAULT => -34
	},
	{#State 64
		ACTIONS => {
			'FLAG' => 98
		}
	},
	{#State 65
		ACTIONS => {
			"\n" => 99
		}
	},
	{#State 66
		ACTIONS => {
			"\n" => 100
		}
	},
	{#State 67
		ACTIONS => {
			'TEXT' => 101
		}
	},
	{#State 68
		ACTIONS => {
			'FLAG' => 102
		}
	},
	{#State 69
		ACTIONS => {
			"\n" => 103
		}
	},
	{#State 70
		ACTIONS => {
			"\n" => 104
		}
	},
	{#State 71
		ACTIONS => {
			'FLAG' => 105
		}
	},
	{#State 72
		DEFAULT => -35
	},
	{#State 73
		ACTIONS => {
			'CHAR' => 106
		}
	},
	{#State 74
		ACTIONS => {
			"\n" => 107
		}
	},
	{#State 75
		DEFAULT => -45
	},
	{#State 76
		ACTIONS => {
			'FLAG' => 108
		}
	},
	{#State 77
		ACTIONS => {
			"ALL" => 52,
			"NONE" => 55,
			"SOME" => 51
		},
		GOTOS => {
			'punctlevel' => 109
		}
	},
	{#State 78
		ACTIONS => {
			"\n" => 110
		}
	},
	{#State 79
		ACTIONS => {
			'INTEGER' => 111
		}
	},
	{#State 80
		ACTIONS => {
			"\n" => 112
		}
	},
	{#State 81
		ACTIONS => {
			'TEXT' => 113
		}
	},
	{#State 82
		DEFAULT => -46
	},
	{#State 83
		ACTIONS => {
			'INTEGER' => 114
		}
	},
	{#State 84
		ACTIONS => {
			'INTEGER' => 115
		}
	},
	{#State 85
		DEFAULT => -33
	},
	{#State 86
		ACTIONS => {
			"}" => 116
		}
	},
	{#State 87
		DEFAULT => -37
	},
	{#State 88
		ACTIONS => {
			'INTEGER' => 117
		}
	},
	{#State 89
		ACTIONS => {
			"\n" => 118
		}
	},
	{#State 90
		ACTIONS => {
			"}" => 119
		}
	},
	{#State 91
		DEFAULT => -54
	},
	{#State 92
		ACTIONS => {
			"}" => 120
		}
	},
	{#State 93
		DEFAULT => -23
	},
	{#State 94
		ACTIONS => {
			"}" => 121
		}
	},
	{#State 95
		DEFAULT => -52
	},
	{#State 96
		DEFAULT => -28
	},
	{#State 97
		ACTIONS => {
			"}" => 122
		}
	},
	{#State 98
		ACTIONS => {
			"}" => 123
		}
	},
	{#State 99
		DEFAULT => -48
	},
	{#State 100
		DEFAULT => -32
	},
	{#State 101
		ACTIONS => {
			"}" => 124
		}
	},
	{#State 102
		ACTIONS => {
			"}" => 125
		}
	},
	{#State 103
		DEFAULT => -58
	},
	{#State 104
		DEFAULT => -50
	},
	{#State 105
		ACTIONS => {
			"}" => 126
		}
	},
	{#State 106
		ACTIONS => {
			"}" => 127
		}
	},
	{#State 107
		DEFAULT => -30
	},
	{#State 108
		ACTIONS => {
			'FLAG' => 128
		}
	},
	{#State 109
		ACTIONS => {
			'FLAG' => 129
		}
	},
	{#State 110
		DEFAULT => -56
	},
	{#State 111
		ACTIONS => {
			"}" => 130
		}
	},
	{#State 112
		DEFAULT => -43
	},
	{#State 113
		ACTIONS => {
			"}" => 131
		}
	},
	{#State 114
		ACTIONS => {
			"\n" => 132
		}
	},
	{#State 115
		ACTIONS => {
			'INTEGER' => 133
		}
	},
	{#State 116
		ACTIONS => {
			"\n" => 134
		}
	},
	{#State 117
		ACTIONS => {
			"}" => 135
		}
	},
	{#State 118
		DEFAULT => -41
	},
	{#State 119
		ACTIONS => {
			"\n" => 136
		}
	},
	{#State 120
		ACTIONS => {
			"\n" => 137
		}
	},
	{#State 121
		ACTIONS => {
			"\n" => 138
		}
	},
	{#State 122
		ACTIONS => {
			"\n" => 139
		}
	},
	{#State 123
		ACTIONS => {
			"\n" => 140
		}
	},
	{#State 124
		ACTIONS => {
			"\n" => 141
		}
	},
	{#State 125
		ACTIONS => {
			"\n" => 142
		}
	},
	{#State 126
		ACTIONS => {
			"\n" => 143
		}
	},
	{#State 127
		ACTIONS => {
			"\n" => 144
		}
	},
	{#State 128
		ACTIONS => {
			'FLAG' => 145
		}
	},
	{#State 129
		ACTIONS => {
			'FLAG' => 146
		}
	},
	{#State 130
		ACTIONS => {
			"\n" => 147
		}
	},
	{#State 131
		ACTIONS => {
			"\n" => 148
		}
	},
	{#State 132
		DEFAULT => -39
	},
	{#State 133
		ACTIONS => {
			"}" => 149
		}
	},
	{#State 134
		DEFAULT => -36
	},
	{#State 135
		ACTIONS => {
			"\n" => 150
		}
	},
	{#State 136
		DEFAULT => -53
	},
	{#State 137
		DEFAULT => -22
	},
	{#State 138
		DEFAULT => -51
	},
	{#State 139
		DEFAULT => -27
	},
	{#State 140
		DEFAULT => -47
	},
	{#State 141
		DEFAULT => -31
	},
	{#State 142
		DEFAULT => -57
	},
	{#State 143
		DEFAULT => -49
	},
	{#State 144
		DEFAULT => -29
	},
	{#State 145
		ACTIONS => {
			'INTEGER' => 151
		}
	},
	{#State 146
		ACTIONS => {
			'FLAG' => 152
		}
	},
	{#State 147
		DEFAULT => -55
	},
	{#State 148
		DEFAULT => -42
	},
	{#State 149
		ACTIONS => {
			"\n" => 153
		}
	},
	{#State 150
		DEFAULT => -40
	},
	{#State 151
		ACTIONS => {
			"\n" => 154
		}
	},
	{#State 152
		ACTIONS => {
			'INTEGER' => 155
		}
	},
	{#State 153
		DEFAULT => -38
	},
	{#State 154
		DEFAULT => -60
	},
	{#State 155
		ACTIONS => {
			"}" => 156
		}
	},
	{#State 156
		ACTIONS => {
			"\n" => 157
		}
	},
	{#State 157
		DEFAULT => -59
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'cmdlist', 0, undef
	],
	[#Rule 2
		 'cmdlist', 2, undef
	],
	[#Rule 3
		 'cmd', 1,
sub
#line 43 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 4
		 'cmd', 1,
sub
#line 44 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 5
		 'cmd', 1,
sub
#line 45 "../parser/parser.yp"
{ &tts_d; $_[1]; }
	],
	[#Rule 6
		 'cmd', 1,
sub
#line 46 "../parser/parser.yp"
{ &tts_s; $_[1]; }
	],
	[#Rule 7
		 'cmd', 1,
sub
#line 47 "../parser/parser.yp"
{ &tts_version; $_[1]; }
	],
	[#Rule 8
		 'cmd', 1,
sub
#line 48 "../parser/parser.yp"
{ &tts_silence; $_[1]; }
	],
	[#Rule 9
		 'cmd', 1,
sub
#line 49 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 10
		 'cmd', 1,
sub
#line 50 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 11
		 'cmd', 1,
sub
#line 51 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 12
		 'cmd', 1,
sub
#line 52 "../parser/parser.yp"
{ &tts_pause; $_[1]; }
	],
	[#Rule 13
		 'cmd', 1,
sub
#line 53 "../parser/parser.yp"
{ &tts_reset; $_[1]; }
	],
	[#Rule 14
		 'cmd', 1,
sub
#line 54 "../parser/parser.yp"
{ &tts_resume; $_[1]; }
	],
	[#Rule 15
		 'cmd', 1,
sub
#line 55 "../parser/parser.yp"
{ &tts_allcaps_beep($_[1]); $_[1]; }
	],
	[#Rule 16
		 'cmd', 1,
sub
#line 56 "../parser/parser.yp"
{ &tts_capitalize($_[1]); $_[1]; }
	],
	[#Rule 17
		 'cmd', 1,
sub
#line 57 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 18
		 'cmd', 1,
sub
#line 58 "../parser/parser.yp"
{ &tts_set_punctuations($_[1]); $_[1]; }
	],
	[#Rule 19
		 'cmd', 1,
sub
#line 59 "../parser/parser.yp"
{ &tts_set_speech_rate($_[1]); }
	],
	[#Rule 20
		 'cmd', 1,
sub
#line 60 "../parser/parser.yp"
{ &tts_split_caps($_[1]); $_[1]; }
	],
	[#Rule 21
		 'cmd', 1,
sub
#line 61 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 22
		 'code', 5,
sub
#line 66 "../parser/parser.yp"
{
			&tts_c($_[3]);
			$_[1];
		}
	],
	[#Rule 23
		 'code', 3,
sub
#line 71 "../parser/parser.yp"
{
			&tts_c($_[2]);
			$_[1];
		}
	],
	[#Rule 24
		 'speech', 1,
sub
#line 78 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 25
		 'speech', 1,
sub
#line 79 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 26
		 'speech', 1,
sub
#line 80 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 27
		 'immediate_speech', 5,
sub
#line 85 "../parser/parser.yp"
{
			&tts_say($_[3]);
			$_[1];
		}
	],
	[#Rule 28
		 'immediate_speech', 3,
sub
#line 90 "../parser/parser.yp"
{
			&tts_say($_[2]);
			$_[1];
		}
	],
	[#Rule 29
		 'character', 5,
sub
#line 98 "../parser/parser.yp"
{
			&tts_l($_[3]);
			$_[1];
		}
	],
	[#Rule 30
		 'character', 3,
sub
#line 103 "../parser/parser.yp"
{
			&tts_l($_[2]);
			$_[1];
		}
	],
	[#Rule 31
		 'queued_speech', 5,
sub
#line 111 "../parser/parser.yp"
{
			&tts_q($_[3]);
			$_[1];
		}
	],
	[#Rule 32
		 'queued_speech', 3,
sub
#line 116 "../parser/parser.yp"
{
			&tts_q($_[2]);
			$_[1];
		}
	],
	[#Rule 33
		 'dispatch', 2,
sub
#line 123 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 34
		 'version', 2,
sub
#line 127 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 35
		 'stop', 2,
sub
#line 131 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 36
		 'silence', 5,
sub
#line 135 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 37
		 'silence', 3,
sub
#line 136 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 38
		 'beep', 6,
sub
#line 141 "../parser/parser.yp"
{
			&tts_b($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 39
		 'beep', 4,
sub
#line 146 "../parser/parser.yp"
{
			&tts_b($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 40
		 'tone', 6,
sub
#line 154 "../parser/parser.yp"
{
			&tts_t($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 41
		 'tone', 4,
sub
#line 159 "../parser/parser.yp"
{
			&tts_t($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 42
		 'sound', 5,
sub
#line 167 "../parser/parser.yp"
{
			&tts_a($_[3]);
			$_[1];
		}
	],
	[#Rule 43
		 'sound', 3,
sub
#line 172 "../parser/parser.yp"
{
			&tts_a($_[2]);
			$_[1];
		}
	],
	[#Rule 44
		 'tts_pause', 2,
sub
#line 179 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 45
		 'tts_reset', 2,
sub
#line 183 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 46
		 'tts_resume', 2,
sub
#line 187 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 47
		 'tts_allcaps_beep', 5,
sub
#line 191 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 48
		 'tts_allcaps_beep', 3,
sub
#line 192 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 49
		 'tts_capitalize', 5,
sub
#line 196 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 50
		 'tts_capitalize', 3,
sub
#line 197 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 51
		 'tts_set_character_scale', 5,
sub
#line 202 "../parser/parser.yp"
{
			&tts_set_character_scale($_[3]);
			$_[1];
		}
	],
	[#Rule 52
		 'tts_set_character_scale', 3,
sub
#line 207 "../parser/parser.yp"
{
			&tts_set_character_scale($_[2]);
			$_[1];
		}
	],
	[#Rule 53
		 'tts_set_punctuations', 5,
sub
#line 214 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 54
		 'tts_set_punctuations', 3,
sub
#line 215 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 55
		 'tts_set_speech_rate', 5,
sub
#line 219 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 56
		 'tts_set_speech_rate', 3,
sub
#line 220 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 57
		 'tts_split_caps', 5,
sub
#line 224 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 58
		 'tts_split_caps', 3,
sub
#line 225 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 59
		 'tts_sync_state', 9,
sub
#line 230 "../parser/parser.yp"
{ 
			&tts_sync_state($_[3], $_[4], $_[5], $_[6], $_[7]);
			$_[1];
		}
	],
	[#Rule 60
		 'tts_sync_state', 7,
sub
#line 235 "../parser/parser.yp"
{
			&tts_sync_state($_[2],$_[3], $_[4], $_[5], $_[6]);
			$_[1];
		}
	],
	[#Rule 61
		 'punctlevel', 1, undef
	],
	[#Rule 62
		 'punctlevel', 1, undef
	],
	[#Rule 63
		 'punctlevel', 1, undef
	]
],
                                  @_);
    bless($self,$class);
}

#line 247 "../parser/parser.yp"


# Bottom section

sub _Error {
	exists $_[0]->YYData->{ERRMSG}
		and do {
			print $_[0]->YYData->{ERRMSG};
			delete $_[0]->YYData->{ERRMSG};
			return;
	};
    
	print "Syntax error.\n";

} # sub _Error

sub _Lexer {
	my($parser)=shift;

	$parser->YYData->{INPUT}
		or  $parser->YYData->{INPUT} = <STDIN>
		or  return('',undef);

	#$parser->YYData->{INPUT} =~ s/^[ \t]//;

	for ($parser->YYData->{INPUT}) {
		# tts_say, immediate speech
		s/^(tts_say)// and return('TTS_SAY',$1);

		# Version, no arguments
		s/^(version)// and return('VERSION',$1);

		# punctuation levels
		s/^((none|some|all))// and return('PUNCTLEVEL',$1);

		# Pause, reset and resume have no arguments

		# pause
		s/^(tts_pause)// and return('TTS_PAUSE',$1);

		# reset 
		s/^(tts_reset)// and return('TTS_RESET',$1);

		# resume 
		s/^(tts_resume)// and return('TTS_RESUME',$1);

		# These tts_* functions either have braces or not

		# tts_allcaps_beep
		s/^(tts_allcaps_beep)// and return('TTS_ALLCAPS_BEEP',$1);

		# tts_capitalize
		s/^(tts_capitalize)// and return('TTS_CAPITALIZE',$1);

		# tts_set_character_scale
		s/^(tts_set_character_scale)// and return('TTS_SET_CHARACTER_SCALE',$1);

		# tts_set_punctuations	
		s/^(tts_set_punctuations)// and return('TTS_SET_PUNCTUATIONS',$1);

		# tts_set_speech_rate
		s/^(tts_set_speech_rate)// and return('TTS_SET_SPEECH_RATE',$1);

		# tts_split_caps
		s/^(tts_split_caps)// and return('TTS_SPLIT_CAPS',$1);

		# tts_sync_state with or without braces but I've never seen braces

		# tts_sync_state
		s/^(tts_sync_state)// and return('TTS_SYNC_STATE',$1);

	# silence 'sh'
		s/^(sh)// and return('SH',$1);

		# Start of single-character patterns

		# code 'c'
		s/^(c)// and return(uc($1),$1);

		# single letter 'l'
		s/^(l)// and return(uc($1),$1);

		# queued speech 'q'
		s/^(q)// and return(uc($1),$1);

		# tone 't' 
		s/^(t)// and return(uc($1),$1);

		# beep 'b'
		s/^(b)// and return(uc($1),$1);

		# sound file 'a' or 'p'
		s/^((a|p))// and return(uc($1),$1);

		# numeric patterns

		# integer
		s/^([0-9][0-9]+)// and return('INTEGER',$1);

		# double
		s/^([-+]?([0-9]*\.?[0-9]+|[0-9]+\.))// and return('DOUBLE',$1);

		# flag 0 or 1
		s/^([01])// and return('FLAG',$1);

		# Left-brace
		s/^({)// and return($1,$1);

		# Right-brace
		s/^(})// and return($1,$1);

		# newline
		s/^(\n)// and return($1,$1);

		# Eat white space
		s/^\s+//;

	}

} # end of _Lexer

sub Run {
	my($self)=shift;
	$self->YYParse( yylex => \&_Lexer, yyerror => \&_Error );
} # end of Run


1;
