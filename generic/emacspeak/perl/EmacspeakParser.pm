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
			"S" => 35,
			'' => 32,
			"TTS_SPLIT_CAPS" => 11,
			"TTS_CAPITALIZE" => 40,
			"SH" => 37,
			"T" => 36,
			"TTS_SET_PUNCTUATIONS" => 14,
			"L" => 43,
			"TTS_PAUSE" => 46,
			"TTS_SAY" => 44,
			"TTS_RESET" => 17,
			"VERSION" => 16,
			"D" => 23,
			"TTS_SET_CHARACTER_SCALE" => 21,
			"TTS_SET_SPEECH_RATE" => 22,
			"TTS_SYNC_STATE" => 19,
			"B" => 2,
			"C" => 18,
			"TTS_ALLCAPS_BEEP" => 24,
			"Q" => 29,
			"TTS_RESUME" => 28,
			"A" => 26
		},
		GOTOS => {
			'tts_set_speech_rate' => 15,
			'tts_set_character_scale' => 45,
			'speech' => 12,
			'stop' => 13,
			'tts_allcaps_beep' => 42,
			'beep' => 7,
			'code' => 41,
			'tts_split_caps' => 39,
			'sound' => 10,
			'cmd' => 9,
			'tts_sync_state' => 38,
			'character' => 8,
			'tts_resume' => 33,
			'immediate_speech' => 31,
			'tts_pause' => 6,
			'tts_reset' => 30,
			'tone' => 34,
			'version' => 5,
			'tts_capitalize' => 27,
			'tts_set_punctuations' => 25,
			'queued_speech' => 3,
			'silence' => 4,
			'dispatch' => 20
		}
	},
	{#State 2
		ACTIONS => {
			'INTEGER' => 48,
			"{" => 47
		}
	},
	{#State 3
		DEFAULT => -25
	},
	{#State 4
		DEFAULT => -8
	},
	{#State 5
		DEFAULT => -7
	},
	{#State 6
		DEFAULT => -12
	},
	{#State 7
		DEFAULT => -9
	},
	{#State 8
		DEFAULT => -26
	},
	{#State 9
		DEFAULT => -2
	},
	{#State 10
		DEFAULT => -11
	},
	{#State 11
		ACTIONS => {
			"{" => 50,
			'FLAG' => 49
		}
	},
	{#State 12
		DEFAULT => -4
	},
	{#State 13
		DEFAULT => -6
	},
	{#State 14
		ACTIONS => {
			"SOME" => 51,
			"{" => 55,
			"NONE" => 54,
			"ALL" => 53
		},
		GOTOS => {
			'punctlevel' => 52
		}
	},
	{#State 15
		DEFAULT => -19
	},
	{#State 16
		ACTIONS => {
			"\n" => 56
		}
	},
	{#State 17
		ACTIONS => {
			"\n" => 57
		}
	},
	{#State 18
		ACTIONS => {
			'TEXT' => 59,
			"{" => 58
		}
	},
	{#State 19
		ACTIONS => {
			"SOME" => 51,
			"NONE" => 54,
			"ALL" => 53,
			"{" => 60
		},
		GOTOS => {
			'punctlevel' => 61
		}
	},
	{#State 20
		DEFAULT => -5
	},
	{#State 21
		ACTIONS => {
			"{" => 62,
			'DOUBLE' => 63
		}
	},
	{#State 22
		ACTIONS => {
			'INTEGER' => 64,
			"{" => 65
		}
	},
	{#State 23
		ACTIONS => {
			"\n" => 66
		}
	},
	{#State 24
		ACTIONS => {
			"{" => 68,
			'FLAG' => 67
		}
	},
	{#State 25
		DEFAULT => -18
	},
	{#State 26
		ACTIONS => {
			'TEXT' => 70,
			"{" => 69
		}
	},
	{#State 27
		DEFAULT => -16
	},
	{#State 28
		ACTIONS => {
			"\n" => 71
		}
	},
	{#State 29
		ACTIONS => {
			"{" => 73,
			'TEXT' => 72
		}
	},
	{#State 30
		DEFAULT => -13
	},
	{#State 31
		DEFAULT => -24
	},
	{#State 32
		DEFAULT => 0
	},
	{#State 33
		DEFAULT => -14
	},
	{#State 34
		DEFAULT => -10
	},
	{#State 35
		ACTIONS => {
			"\n" => 74
		}
	},
	{#State 36
		ACTIONS => {
			"{" => 75,
			'INTEGER' => 76
		}
	},
	{#State 37
		ACTIONS => {
			'INTEGER' => 78,
			"{" => 77
		}
	},
	{#State 38
		DEFAULT => -21
	},
	{#State 39
		DEFAULT => -20
	},
	{#State 40
		ACTIONS => {
			'FLAG' => 80,
			"{" => 79
		}
	},
	{#State 41
		DEFAULT => -3
	},
	{#State 42
		DEFAULT => -15
	},
	{#State 43
		ACTIONS => {
			"{" => 82,
			'CHAR' => 81
		}
	},
	{#State 44
		ACTIONS => {
			"{" => 84,
			'TEXT' => 83
		}
	},
	{#State 45
		DEFAULT => -17
	},
	{#State 46
		ACTIONS => {
			"\n" => 85
		}
	},
	{#State 47
		ACTIONS => {
			'INTEGER' => 86
		}
	},
	{#State 48
		ACTIONS => {
			'INTEGER' => 87
		}
	},
	{#State 49
		ACTIONS => {
			"\n" => 88
		}
	},
	{#State 50
		ACTIONS => {
			'FLAG' => 89
		}
	},
	{#State 51
		DEFAULT => -62
	},
	{#State 52
		ACTIONS => {
			"\n" => 90
		}
	},
	{#State 53
		DEFAULT => -63
	},
	{#State 54
		DEFAULT => -61
	},
	{#State 55
		ACTIONS => {
			"SOME" => 51,
			"ALL" => 53,
			"NONE" => 54
		},
		GOTOS => {
			'punctlevel' => 91
		}
	},
	{#State 56
		DEFAULT => -34
	},
	{#State 57
		DEFAULT => -45
	},
	{#State 58
		ACTIONS => {
			'TEXT' => 92
		}
	},
	{#State 59
		ACTIONS => {
			"\n" => 93
		}
	},
	{#State 60
		ACTIONS => {
			"NONE" => 54,
			"ALL" => 53,
			"SOME" => 51
		},
		GOTOS => {
			'punctlevel' => 94
		}
	},
	{#State 61
		ACTIONS => {
			'FLAG' => 95
		}
	},
	{#State 62
		ACTIONS => {
			'DOUBLE' => 96
		}
	},
	{#State 63
		ACTIONS => {
			"\n" => 97
		}
	},
	{#State 64
		ACTIONS => {
			"\n" => 98
		}
	},
	{#State 65
		ACTIONS => {
			'INTEGER' => 99
		}
	},
	{#State 66
		DEFAULT => -33
	},
	{#State 67
		ACTIONS => {
			"\n" => 100
		}
	},
	{#State 68
		ACTIONS => {
			'FLAG' => 101
		}
	},
	{#State 69
		ACTIONS => {
			'TEXT' => 102
		}
	},
	{#State 70
		ACTIONS => {
			"\n" => 103
		}
	},
	{#State 71
		DEFAULT => -46
	},
	{#State 72
		ACTIONS => {
			"\n" => 104
		}
	},
	{#State 73
		ACTIONS => {
			'TEXT' => 105
		}
	},
	{#State 74
		DEFAULT => -35
	},
	{#State 75
		ACTIONS => {
			'INTEGER' => 106
		}
	},
	{#State 76
		ACTIONS => {
			'INTEGER' => 107
		}
	},
	{#State 77
		ACTIONS => {
			'INTEGER' => 108
		}
	},
	{#State 78
		ACTIONS => {
			"\n" => 109
		}
	},
	{#State 79
		ACTIONS => {
			'FLAG' => 110
		}
	},
	{#State 80
		ACTIONS => {
			"\n" => 111
		}
	},
	{#State 81
		ACTIONS => {
			"\n" => 112
		}
	},
	{#State 82
		ACTIONS => {
			'CHAR' => 113
		}
	},
	{#State 83
		ACTIONS => {
			"\n" => 114
		}
	},
	{#State 84
		ACTIONS => {
			'TEXT' => 115
		}
	},
	{#State 85
		DEFAULT => -44
	},
	{#State 86
		ACTIONS => {
			'INTEGER' => 116
		}
	},
	{#State 87
		ACTIONS => {
			"\n" => 117
		}
	},
	{#State 88
		DEFAULT => -58
	},
	{#State 89
		ACTIONS => {
			"}" => 118
		}
	},
	{#State 90
		DEFAULT => -54
	},
	{#State 91
		ACTIONS => {
			"}" => 119
		}
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
			'FLAG' => 121
		}
	},
	{#State 95
		ACTIONS => {
			'FLAG' => 122
		}
	},
	{#State 96
		ACTIONS => {
			"}" => 123
		}
	},
	{#State 97
		DEFAULT => -52
	},
	{#State 98
		DEFAULT => -56
	},
	{#State 99
		ACTIONS => {
			"}" => 124
		}
	},
	{#State 100
		DEFAULT => -48
	},
	{#State 101
		ACTIONS => {
			"}" => 125
		}
	},
	{#State 102
		ACTIONS => {
			"}" => 126
		}
	},
	{#State 103
		DEFAULT => -43
	},
	{#State 104
		DEFAULT => -32
	},
	{#State 105
		ACTIONS => {
			"}" => 127
		}
	},
	{#State 106
		ACTIONS => {
			'INTEGER' => 128
		}
	},
	{#State 107
		ACTIONS => {
			"\n" => 129
		}
	},
	{#State 108
		ACTIONS => {
			"}" => 130
		}
	},
	{#State 109
		DEFAULT => -37
	},
	{#State 110
		ACTIONS => {
			"}" => 131
		}
	},
	{#State 111
		DEFAULT => -50
	},
	{#State 112
		DEFAULT => -30
	},
	{#State 113
		ACTIONS => {
			"}" => 132
		}
	},
	{#State 114
		DEFAULT => -28
	},
	{#State 115
		ACTIONS => {
			"}" => 133
		}
	},
	{#State 116
		ACTIONS => {
			"}" => 134
		}
	},
	{#State 117
		DEFAULT => -39
	},
	{#State 118
		ACTIONS => {
			"\n" => 135
		}
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
			'FLAG' => 138
		}
	},
	{#State 122
		ACTIONS => {
			'FLAG' => 139
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
			"}" => 145
		}
	},
	{#State 129
		DEFAULT => -41
	},
	{#State 130
		ACTIONS => {
			"\n" => 146
		}
	},
	{#State 131
		ACTIONS => {
			"\n" => 147
		}
	},
	{#State 132
		ACTIONS => {
			"\n" => 148
		}
	},
	{#State 133
		ACTIONS => {
			"\n" => 149
		}
	},
	{#State 134
		ACTIONS => {
			"\n" => 150
		}
	},
	{#State 135
		DEFAULT => -57
	},
	{#State 136
		DEFAULT => -53
	},
	{#State 137
		DEFAULT => -22
	},
	{#State 138
		ACTIONS => {
			'FLAG' => 151
		}
	},
	{#State 139
		ACTIONS => {
			'INTEGER' => 152
		}
	},
	{#State 140
		DEFAULT => -51
	},
	{#State 141
		DEFAULT => -55
	},
	{#State 142
		DEFAULT => -47
	},
	{#State 143
		DEFAULT => -42
	},
	{#State 144
		DEFAULT => -31
	},
	{#State 145
		ACTIONS => {
			"\n" => 153
		}
	},
	{#State 146
		DEFAULT => -36
	},
	{#State 147
		DEFAULT => -49
	},
	{#State 148
		DEFAULT => -29
	},
	{#State 149
		DEFAULT => -27
	},
	{#State 150
		DEFAULT => -38
	},
	{#State 151
		ACTIONS => {
			'INTEGER' => 154
		}
	},
	{#State 152
		ACTIONS => {
			"\n" => 155
		}
	},
	{#State 153
		DEFAULT => -40
	},
	{#State 154
		ACTIONS => {
			"}" => 156
		}
	},
	{#State 155
		DEFAULT => -60
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
#line 37 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 4
		 'cmd', 1,
sub
#line 38 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 5
		 'cmd', 1,
sub
#line 39 "../parser/parser.yp"
{ $_[1]; &tts_d(); }
	],
	[#Rule 6
		 'cmd', 1,
sub
#line 40 "../parser/parser.yp"
{ $_[1]; &tts_s(); }
	],
	[#Rule 7
		 'cmd', 1,
sub
#line 41 "../parser/parser.yp"
{ $_[1]; &tts_version(); }
	],
	[#Rule 8
		 'cmd', 1,
sub
#line 42 "../parser/parser.yp"
{ $_[1]; &tts_silence($1); }
	],
	[#Rule 9
		 'cmd', 1,
sub
#line 43 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 10
		 'cmd', 1,
sub
#line 44 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 11
		 'cmd', 1,
sub
#line 45 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 12
		 'cmd', 1,
sub
#line 46 "../parser/parser.yp"
{ $_[1]; &tts_pause(); }
	],
	[#Rule 13
		 'cmd', 1,
sub
#line 47 "../parser/parser.yp"
{ $_[1]; &tts_reset(); }
	],
	[#Rule 14
		 'cmd', 1,
sub
#line 48 "../parser/parser.yp"
{ $_[1]; &tts_reset(); }
	],
	[#Rule 15
		 'cmd', 1,
sub
#line 49 "../parser/parser.yp"
{ $_[1]; &tts_allcaps_beep($1); }
	],
	[#Rule 16
		 'cmd', 1,
sub
#line 50 "../parser/parser.yp"
{ $_[1]; &tts_capitalize($1)}
	],
	[#Rule 17
		 'cmd', 1,
sub
#line 51 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 18
		 'cmd', 1,
sub
#line 52 "../parser/parser.yp"
{ $_[1]; &tts_set_punctuations($_[1]); }
	],
	[#Rule 19
		 'cmd', 1,
sub
#line 53 "../parser/parser.yp"
{ $_[1]; &tts_set_speech_rate($_[1]); }
	],
	[#Rule 20
		 'cmd', 1,
sub
#line 54 "../parser/parser.yp"
{ $_[1]; &tts_split_caps($_[1]); }
	],
	[#Rule 21
		 'cmd', 1,
sub
#line 55 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 22
		 'code', 5,
sub
#line 60 "../parser/parser.yp"
{
			$_[1];
			&tts_c($_[3]);
		}
	],
	[#Rule 23
		 'code', 3,
sub
#line 65 "../parser/parser.yp"
{
			$_[1];
			&tts_c($_[2]);
		}
	],
	[#Rule 24
		 'speech', 1,
sub
#line 72 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 25
		 'speech', 1,
sub
#line 73 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 26
		 'speech', 1,
sub
#line 74 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 27
		 'immediate_speech', 5,
sub
#line 79 "../parser/parser.yp"
{
			$_[1];
			&tts_say($_[3]);
		}
	],
	[#Rule 28
		 'immediate_speech', 3,
sub
#line 84 "../parser/parser.yp"
{
			$_[1];
			&tts_say($_[2]);
		}
	],
	[#Rule 29
		 'character', 5,
sub
#line 92 "../parser/parser.yp"
{
			$_[1];
			&tts_l($_[3]);
		}
	],
	[#Rule 30
		 'character', 3,
sub
#line 97 "../parser/parser.yp"
{
			$_[1];
			&tts_l($_[2]);
		}
	],
	[#Rule 31
		 'queued_speech', 5,
sub
#line 105 "../parser/parser.yp"
{
			$_[1];
			&tts_q($_[3]);
		}
	],
	[#Rule 32
		 'queued_speech', 3,
sub
#line 110 "../parser/parser.yp"
{
			$_[1];
			&tts_q($_[2]);
		}
	],
	[#Rule 33
		 'dispatch', 2,
sub
#line 117 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 34
		 'version', 2,
sub
#line 121 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 35
		 'stop', 2,
sub
#line 125 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 36
		 'silence', 5,
sub
#line 129 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 37
		 'silence', 3,
sub
#line 130 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 38
		 'beep', 6,
sub
#line 135 "../parser/parser.yp"
{
			$_[1];
			&tts_b($_[3], $_[4]);
		}
	],
	[#Rule 39
		 'beep', 4,
sub
#line 140 "../parser/parser.yp"
{
			$_[1];
			&tts_b($_[2], $_[3]);
		}
	],
	[#Rule 40
		 'tone', 6,
sub
#line 148 "../parser/parser.yp"
{
			$_[1];
			&tts_t($_[3], $_[4]);
		}
	],
	[#Rule 41
		 'tone', 4,
sub
#line 153 "../parser/parser.yp"
{
			$_[1];
			&tts_t($_[2], $_[3]);
		}
	],
	[#Rule 42
		 'sound', 5,
sub
#line 161 "../parser/parser.yp"
{
			$_[1];
			&tts_a($_[3]);
		}
	],
	[#Rule 43
		 'sound', 3,
sub
#line 166 "../parser/parser.yp"
{
			$_[1];
			&tts_a($_[2]);
		}
	],
	[#Rule 44
		 'tts_pause', 2,
sub
#line 173 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 45
		 'tts_reset', 2,
sub
#line 177 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 46
		 'tts_resume', 2,
sub
#line 181 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 47
		 'tts_allcaps_beep', 5,
sub
#line 185 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 48
		 'tts_allcaps_beep', 3,
sub
#line 186 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 49
		 'tts_capitalize', 5,
sub
#line 190 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 50
		 'tts_capitalize', 3,
sub
#line 191 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 51
		 'tts_set_character_scale', 5,
sub
#line 196 "../parser/parser.yp"
{
			$_[1];
			&tts_set_character_scale($_[3]);
		}
	],
	[#Rule 52
		 'tts_set_character_scale', 3,
sub
#line 201 "../parser/parser.yp"
{
			$_[1];
			&tts_set_character_scale($_[2]);
		}
	],
	[#Rule 53
		 'tts_set_punctuations', 5,
sub
#line 208 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 54
		 'tts_set_punctuations', 3,
sub
#line 209 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 55
		 'tts_set_speech_rate', 5,
sub
#line 213 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 56
		 'tts_set_speech_rate', 3,
sub
#line 214 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 57
		 'tts_split_caps', 5,
sub
#line 218 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 58
		 'tts_split_caps', 3,
sub
#line 219 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 59
		 'tts_sync_state', 9,
sub
#line 224 "../parser/parser.yp"
{ 
			$_[1];
			&tts_sync_state($_[3], $_[4], $_[5], $_[6], $_[7]);
		}
	],
	[#Rule 60
		 'tts_sync_state', 7,
sub
#line 229 "../parser/parser.yp"
{
			$_[1];
			&tts_sync_state($_[2],$_[3], $_[4], $_[5], $_[6]);
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

#line 241 "../parser/parser.yp"


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

my $p = new MyParser;
$p->Run;





1;
