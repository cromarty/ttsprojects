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
			"C" => 17,
			"t" => 13,
			'TTS_PAUSE' => 36,
			"s" => 14,
			'TTS_ALLCAPS_BEEP' => 35,
			'TTS_SET_SPEECH_RATE' => 34,
			"d" => 11,
			'TTS_SET_PUNCTUATIONS' => 43,
			'VERSION' => 22,
			'SH' => 21,
			'' => 20,
			"Q" => 27,
			'TTS_SAY' => 2,
			"L" => 26,
			"b" => 24,
			'TTS_SPLIT_CAPS' => 9,
			'TTS_CAPITALIZE' => 31,
			'TTS_RESUME' => 30,
			'TTS_SYNC_STATE' => 6,
			"a" => 29,
			'TTS_RESET' => 5,
			'TTS_SET_CHARACTER_SCALE' => 28
		},
		GOTOS => {
			'queued_speech' => 4,
			'character' => 3,
			'beep' => 7,
			'tts_set_speech_rate' => 10,
			'tts_pause' => 8,
			'speech' => 32,
			'immediate_speech' => 25,
			'stop' => 38,
			'tts_resume' => 39,
			'tts_capitalize' => 40,
			'tts_split_caps' => 41,
			'version' => 42,
			'tts_allcaps_beep' => 19,
			'tts_reset' => 45,
			'tts_set_punctuations' => 46,
			'dispatch' => 44,
			'cmd' => 23,
			'silence' => 33,
			'code' => 12,
			'sound' => 15,
			'tts_set_character_scale' => 16,
			'tts_sync_state' => 37,
			'tone' => 18
		}
	},
	{#State 2
		ACTIONS => {
			'TEXT' => 47,
			"{" => 48
		}
	},
	{#State 3
		DEFAULT => -26
	},
	{#State 4
		DEFAULT => -25
	},
	{#State 5
		ACTIONS => {
			"\n" => 49
		}
	},
	{#State 6
		ACTIONS => {
			'NONE' => 54,
			"{" => 51,
			'ALL' => 50,
			'SOME' => 53
		},
		GOTOS => {
			'punctlevel' => 52
		}
	},
	{#State 7
		DEFAULT => -9
	},
	{#State 8
		DEFAULT => -12
	},
	{#State 9
		ACTIONS => {
			"{" => 55,
			'FLAG' => 56
		}
	},
	{#State 10
		DEFAULT => -19
	},
	{#State 11
		ACTIONS => {
			"\n" => 57
		}
	},
	{#State 12
		DEFAULT => -3
	},
	{#State 13
		ACTIONS => {
			"{" => 58,
			'INTEGER' => 59
		}
	},
	{#State 14
		ACTIONS => {
			"\n" => 60
		}
	},
	{#State 15
		DEFAULT => -11
	},
	{#State 16
		DEFAULT => -17
	},
	{#State 17
		ACTIONS => {
			'TEXT' => 62,
			"{" => 61
		}
	},
	{#State 18
		DEFAULT => -10
	},
	{#State 19
		DEFAULT => -15
	},
	{#State 20
		DEFAULT => 0
	},
	{#State 21
		ACTIONS => {
			"{" => 63,
			'INTEGER' => 64
		}
	},
	{#State 22
		ACTIONS => {
			"\n" => 65
		}
	},
	{#State 23
		DEFAULT => -2
	},
	{#State 24
		ACTIONS => {
			"{" => 67,
			'INTEGER' => 66
		}
	},
	{#State 25
		DEFAULT => -24
	},
	{#State 26
		ACTIONS => {
			"{" => 69,
			'CHAR' => 68
		}
	},
	{#State 27
		ACTIONS => {
			"{" => 70,
			'TEXT' => 71
		}
	},
	{#State 28
		ACTIONS => {
			'DOUBLE' => 72,
			"{" => 73
		}
	},
	{#State 29
		ACTIONS => {
			'TEXT' => 75,
			"{" => 74
		}
	},
	{#State 30
		ACTIONS => {
			"\n" => 76
		}
	},
	{#State 31
		ACTIONS => {
			"{" => 77,
			'FLAG' => 78
		}
	},
	{#State 32
		DEFAULT => -4
	},
	{#State 33
		DEFAULT => -8
	},
	{#State 34
		ACTIONS => {
			'INTEGER' => 80,
			"{" => 79
		}
	},
	{#State 35
		ACTIONS => {
			'FLAG' => 81,
			"{" => 82
		}
	},
	{#State 36
		ACTIONS => {
			"\n" => 83
		}
	},
	{#State 37
		DEFAULT => -21
	},
	{#State 38
		DEFAULT => -6
	},
	{#State 39
		DEFAULT => -14
	},
	{#State 40
		DEFAULT => -16
	},
	{#State 41
		DEFAULT => -20
	},
	{#State 42
		DEFAULT => -7
	},
	{#State 43
		ACTIONS => {
			'SOME' => 53,
			'ALL' => 50,
			'NONE' => 54,
			"{" => 85
		},
		GOTOS => {
			'punctlevel' => 84
		}
	},
	{#State 44
		DEFAULT => -5
	},
	{#State 45
		DEFAULT => -13
	},
	{#State 46
		DEFAULT => -18
	},
	{#State 47
		ACTIONS => {
			"\n" => 86
		}
	},
	{#State 48
		ACTIONS => {
			'TEXT' => 87
		}
	},
	{#State 49
		DEFAULT => -45
	},
	{#State 50
		DEFAULT => -63
	},
	{#State 51
		ACTIONS => {
			'SOME' => 53,
			'NONE' => 54,
			'ALL' => 50
		},
		GOTOS => {
			'punctlevel' => 88
		}
	},
	{#State 52
		ACTIONS => {
			'FLAG' => 89
		}
	},
	{#State 53
		DEFAULT => -62
	},
	{#State 54
		DEFAULT => -61
	},
	{#State 55
		ACTIONS => {
			'FLAG' => 90
		}
	},
	{#State 56
		ACTIONS => {
			"\n" => 91
		}
	},
	{#State 57
		DEFAULT => -33
	},
	{#State 58
		ACTIONS => {
			'INTEGER' => 92
		}
	},
	{#State 59
		ACTIONS => {
			'INTEGER' => 93
		}
	},
	{#State 60
		DEFAULT => -35
	},
	{#State 61
		ACTIONS => {
			'TEXT' => 94
		}
	},
	{#State 62
		ACTIONS => {
			"\n" => 95
		}
	},
	{#State 63
		ACTIONS => {
			'INTEGER' => 96
		}
	},
	{#State 64
		ACTIONS => {
			"\n" => 97
		}
	},
	{#State 65
		DEFAULT => -34
	},
	{#State 66
		ACTIONS => {
			'INTEGER' => 98
		}
	},
	{#State 67
		ACTIONS => {
			'INTEGER' => 99
		}
	},
	{#State 68
		ACTIONS => {
			"\n" => 100
		}
	},
	{#State 69
		ACTIONS => {
			'CHAR' => 101
		}
	},
	{#State 70
		ACTIONS => {
			'TEXT' => 102
		}
	},
	{#State 71
		ACTIONS => {
			"\n" => 103
		}
	},
	{#State 72
		ACTIONS => {
			"\n" => 104
		}
	},
	{#State 73
		ACTIONS => {
			'DOUBLE' => 105
		}
	},
	{#State 74
		ACTIONS => {
			'TEXT' => 106
		}
	},
	{#State 75
		ACTIONS => {
			"\n" => 107
		}
	},
	{#State 76
		DEFAULT => -46
	},
	{#State 77
		ACTIONS => {
			'FLAG' => 108
		}
	},
	{#State 78
		ACTIONS => {
			"\n" => 109
		}
	},
	{#State 79
		ACTIONS => {
			'INTEGER' => 110
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
			'FLAG' => 113
		}
	},
	{#State 83
		DEFAULT => -44
	},
	{#State 84
		ACTIONS => {
			"\n" => 114
		}
	},
	{#State 85
		ACTIONS => {
			'SOME' => 53,
			'ALL' => 50,
			'NONE' => 54
		},
		GOTOS => {
			'punctlevel' => 115
		}
	},
	{#State 86
		DEFAULT => -28
	},
	{#State 87
		ACTIONS => {
			"}" => 116
		}
	},
	{#State 88
		ACTIONS => {
			'FLAG' => 117
		}
	},
	{#State 89
		ACTIONS => {
			'FLAG' => 118
		}
	},
	{#State 90
		ACTIONS => {
			"}" => 119
		}
	},
	{#State 91
		DEFAULT => -58
	},
	{#State 92
		ACTIONS => {
			'INTEGER' => 120
		}
	},
	{#State 93
		ACTIONS => {
			"\n" => 121
		}
	},
	{#State 94
		ACTIONS => {
			"}" => 122
		}
	},
	{#State 95
		DEFAULT => -23
	},
	{#State 96
		ACTIONS => {
			"}" => 123
		}
	},
	{#State 97
		DEFAULT => -37
	},
	{#State 98
		ACTIONS => {
			"\n" => 124
		}
	},
	{#State 99
		ACTIONS => {
			'INTEGER' => 125
		}
	},
	{#State 100
		DEFAULT => -30
	},
	{#State 101
		ACTIONS => {
			"}" => 126
		}
	},
	{#State 102
		ACTIONS => {
			"}" => 127
		}
	},
	{#State 103
		DEFAULT => -32
	},
	{#State 104
		DEFAULT => -52
	},
	{#State 105
		ACTIONS => {
			"}" => 128
		}
	},
	{#State 106
		ACTIONS => {
			"}" => 129
		}
	},
	{#State 107
		DEFAULT => -43
	},
	{#State 108
		ACTIONS => {
			"}" => 130
		}
	},
	{#State 109
		DEFAULT => -50
	},
	{#State 110
		ACTIONS => {
			"}" => 131
		}
	},
	{#State 111
		DEFAULT => -56
	},
	{#State 112
		DEFAULT => -48
	},
	{#State 113
		ACTIONS => {
			"}" => 132
		}
	},
	{#State 114
		DEFAULT => -54
	},
	{#State 115
		ACTIONS => {
			"}" => 133
		}
	},
	{#State 116
		ACTIONS => {
			"\n" => 134
		}
	},
	{#State 117
		ACTIONS => {
			'FLAG' => 135
		}
	},
	{#State 118
		ACTIONS => {
			'FLAG' => 136
		}
	},
	{#State 119
		ACTIONS => {
			"\n" => 137
		}
	},
	{#State 120
		ACTIONS => {
			"}" => 138
		}
	},
	{#State 121
		DEFAULT => -41
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
		DEFAULT => -39
	},
	{#State 125
		ACTIONS => {
			"}" => 141
		}
	},
	{#State 126
		ACTIONS => {
			"\n" => 142
		}
	},
	{#State 127
		ACTIONS => {
			"\n" => 143
		}
	},
	{#State 128
		ACTIONS => {
			"\n" => 144
		}
	},
	{#State 129
		ACTIONS => {
			"\n" => 145
		}
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
		DEFAULT => -27
	},
	{#State 135
		ACTIONS => {
			'FLAG' => 150
		}
	},
	{#State 136
		ACTIONS => {
			'INTEGER' => 151
		}
	},
	{#State 137
		DEFAULT => -57
	},
	{#State 138
		ACTIONS => {
			"\n" => 152
		}
	},
	{#State 139
		DEFAULT => -22
	},
	{#State 140
		DEFAULT => -36
	},
	{#State 141
		ACTIONS => {
			"\n" => 153
		}
	},
	{#State 142
		DEFAULT => -29
	},
	{#State 143
		DEFAULT => -31
	},
	{#State 144
		DEFAULT => -51
	},
	{#State 145
		DEFAULT => -42
	},
	{#State 146
		DEFAULT => -49
	},
	{#State 147
		DEFAULT => -55
	},
	{#State 148
		DEFAULT => -47
	},
	{#State 149
		DEFAULT => -53
	},
	{#State 150
		ACTIONS => {
			'INTEGER' => 154
		}
	},
	{#State 151
		ACTIONS => {
			"\n" => 155
		}
	},
	{#State 152
		DEFAULT => -40
	},
	{#State 153
		DEFAULT => -38
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
#line 48 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 4
		 'cmd', 1,
sub
#line 49 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 5
		 'cmd', 1,
sub
#line 50 "../parser/parser.yp"
{ &tts_d; $_[1]; }
	],
	[#Rule 6
		 'cmd', 1,
sub
#line 51 "../parser/parser.yp"
{ &tts_s; $_[1]; }
	],
	[#Rule 7
		 'cmd', 1,
sub
#line 52 "../parser/parser.yp"
{ &tts_version; $_[1]; }
	],
	[#Rule 8
		 'cmd', 1,
sub
#line 53 "../parser/parser.yp"
{ &tts_silence; $_[1]; }
	],
	[#Rule 9
		 'cmd', 1,
sub
#line 54 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 10
		 'cmd', 1,
sub
#line 55 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 11
		 'cmd', 1,
sub
#line 56 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 12
		 'cmd', 1,
sub
#line 57 "../parser/parser.yp"
{ &tts_pause; $_[1]; }
	],
	[#Rule 13
		 'cmd', 1,
sub
#line 58 "../parser/parser.yp"
{ &tts_reset; $_[1]; }
	],
	[#Rule 14
		 'cmd', 1,
sub
#line 59 "../parser/parser.yp"
{ &tts_resume; $_[1]; }
	],
	[#Rule 15
		 'cmd', 1,
sub
#line 60 "../parser/parser.yp"
{ &tts_allcaps_beep($_[1]); $_[1]; }
	],
	[#Rule 16
		 'cmd', 1,
sub
#line 61 "../parser/parser.yp"
{ &tts_capitalize($_[1]); $_[1]; }
	],
	[#Rule 17
		 'cmd', 1,
sub
#line 62 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 18
		 'cmd', 1,
sub
#line 64 "../parser/parser.yp"
{
			&tts_set_punctuations($_[1]);
			$_[1];
		}
	],
	[#Rule 19
		 'cmd', 1,
sub
#line 69 "../parser/parser.yp"
{ 
			&tts_set_speech_rate($_[1]);
				$_[1];		
		}
	],
	[#Rule 20
		 'cmd', 1,
sub
#line 73 "../parser/parser.yp"
{ &tts_split_caps($_[1]); $_[1]; }
	],
	[#Rule 21
		 'cmd', 1,
sub
#line 74 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 22
		 'code', 5,
sub
#line 79 "../parser/parser.yp"
{
			&tts_c($_[3]);
			$_[1];
		}
	],
	[#Rule 23
		 'code', 3,
sub
#line 84 "../parser/parser.yp"
{
			&tts_c($_[2]);
			$_[1];
		}
	],
	[#Rule 24
		 'speech', 1,
sub
#line 91 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 25
		 'speech', 1,
sub
#line 92 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 26
		 'speech', 1,
sub
#line 93 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 27
		 'immediate_speech', 5,
sub
#line 98 "../parser/parser.yp"
{
			&tts_say($_[3]);
			$_[1];
		}
	],
	[#Rule 28
		 'immediate_speech', 3,
sub
#line 103 "../parser/parser.yp"
{
			&tts_say($_[2]);
			$_[1];
		}
	],
	[#Rule 29
		 'character', 5,
sub
#line 111 "../parser/parser.yp"
{
			&tts_l($_[3]);
			$_[1];
		}
	],
	[#Rule 30
		 'character', 3,
sub
#line 116 "../parser/parser.yp"
{
			&tts_l($_[2]);
			$_[1];
		}
	],
	[#Rule 31
		 'queued_speech', 5,
sub
#line 124 "../parser/parser.yp"
{
			&tts_q($_[3]);
			$_[1];
		}
	],
	[#Rule 32
		 'queued_speech', 3,
sub
#line 129 "../parser/parser.yp"
{
			&tts_q($_[2]);
			$_[1];
		}
	],
	[#Rule 33
		 'dispatch', 2,
sub
#line 136 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 34
		 'version', 2,
sub
#line 140 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 35
		 'stop', 2,
sub
#line 144 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 36
		 'silence', 5,
sub
#line 148 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 37
		 'silence', 3,
sub
#line 149 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 38
		 'beep', 6,
sub
#line 154 "../parser/parser.yp"
{
			&tts_b($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 39
		 'beep', 4,
sub
#line 159 "../parser/parser.yp"
{
			&tts_b($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 40
		 'tone', 6,
sub
#line 167 "../parser/parser.yp"
{
			&tts_t($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 41
		 'tone', 4,
sub
#line 172 "../parser/parser.yp"
{
			&tts_t($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 42
		 'sound', 5,
sub
#line 180 "../parser/parser.yp"
{
			&tts_a($_[3]);
			$_[1];
		}
	],
	[#Rule 43
		 'sound', 3,
sub
#line 185 "../parser/parser.yp"
{
			&tts_a($_[2]);
			$_[1];
		}
	],
	[#Rule 44
		 'tts_pause', 2,
sub
#line 192 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 45
		 'tts_reset', 2,
sub
#line 196 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 46
		 'tts_resume', 2,
sub
#line 200 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 47
		 'tts_allcaps_beep', 5,
sub
#line 204 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 48
		 'tts_allcaps_beep', 3,
sub
#line 205 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 49
		 'tts_capitalize', 5,
sub
#line 209 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 50
		 'tts_capitalize', 3,
sub
#line 210 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 51
		 'tts_set_character_scale', 5,
sub
#line 215 "../parser/parser.yp"
{
			&tts_set_character_scale($_[3]);
			$_[1];
		}
	],
	[#Rule 52
		 'tts_set_character_scale', 3,
sub
#line 220 "../parser/parser.yp"
{
			&tts_set_character_scale($_[2]);
			$_[1];
		}
	],
	[#Rule 53
		 'tts_set_punctuations', 5,
sub
#line 227 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 54
		 'tts_set_punctuations', 3,
sub
#line 228 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 55
		 'tts_set_speech_rate', 5,
sub
#line 232 "../parser/parser.yp"
{ print "In tts_set_speech_rate\n"; $_[3]; }
	],
	[#Rule 56
		 'tts_set_speech_rate', 3,
sub
#line 233 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 57
		 'tts_split_caps', 5,
sub
#line 237 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 58
		 'tts_split_caps', 3,
sub
#line 238 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 59
		 'tts_sync_state', 9,
sub
#line 243 "../parser/parser.yp"
{ 
			&tts_sync_state($_[3], $_[4], $_[5], $_[6], $_[7]);
			$_[1];
		}
	],
	[#Rule 60
		 'tts_sync_state', 7,
sub
#line 248 "../parser/parser.yp"
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

#line 260 "../parser/parser.yp"


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
	
    $parser->YYData->{INPUT}=~s/^[ \t]+//;

	for ($parser->YYData->{INPUT}) {

		# tts_say, immediate speech
		s/^(tts_say)//
		and do {
			$parser->YYData->{CONDITION} = 1;
			return('TTS_SAY',$1);
		};

		# Version, no arguments
		s/^(version)//
		and return('VERSION',$1);

		# punctuation levels
		s/^((none|some|all))//
		and return('PUNCTLEVEL',$1);

		# Pause, reset and resume have no arguments

		# pause
		s/^(tts_pause)//
		and return('TTS_PAUSE',$1);

		# reset 
		s/^(tts_reset)//
		and return('TTS_RESET',$1);

		# resume 
		s/^(tts_resume)//
		and return('TTS_RESUME',$1);

		# These tts_* functions either have braces or not

		# tts_allcaps_beep
		s/^(tts_allcaps_beep)//
		and return('TTS_ALLCAPS_BEEP',$1);

		# tts_capitalize
		s/^(tts_capitalize)//
		and return('TTS_CAPITALIZE',$1);

		# tts_set_character_scale
		s/^(tts_set_character_scale)//
		and return('TTS_SET_CHARACTER_SCALE',$1);

		# tts_set_punctuations	
		s/^(tts_set_punctuations)//
		and return('TTS_SET_PUNCTUATIONS',$1);

		# tts_set_speech_rate
		s/^(tts_set_speech_rate)//
		and do {
			$parser->YYData->{CONDITION} = 1;
			return('TTS_SET_SPEECH_RATE',$1);
		};

		# tts_split_caps
		s/^(tts_split_caps)//
		and return('TTS_SPLIT_CAPS',$1);

		# tts_sync_state with or without braces but I've never seen braces

		# tts_sync_state
		s/^(tts_sync_state)//
		and return('TTS_SYNC_STATE',$1);

	# silence 'sh'
		s/^(sh)//
		and return('SH',$1);

		# Start of single-character patterns

		# Dispatch 'd'
		s/^(d)//
		and return($1,$1);

		# stop 's'
		s/^(s)//
			and return($1,$1);

		# code 'c'
		s/^(c)//
		and return($1,$1);

		# single letter 'l'
		s/^(l)//
		and return($1,$1);

		# queued speech 'q'
		s/^(q)//
		and return($1,$1);

		# tone 't' 
		s/^(t)//
		and return($1,$1);

		# beep 'b'
		s/^(b)//
		and return($1,$1);

		# sound file 'a' or 'p'
		s/^((a|p))//
		and return($1,$1);

		# numeric patterns

		# integer
		s/^([0-9][0-9]+)//
		and return('INTEGER',$1);

		# double
		s/^([-+]?([0-9]*\.[0-9]+|[0-9]+\.))//
			and return('DOUBLE',$1);

		# flag 0 or 1
		s/^([01])//
		and return('FLAG',$1);

		# Left-brace
		s/^({)//
		and return($1,$1);

		# Right-brace
		s/^(})//
		and return($1,$1);

		# newline
		s/^(\n)//s
		and do {
			$parser->YYData->{CONDITION} = 0;
			return($1,$1);
		};


	}

} # end of _Lexer

sub Run {
	my($self)=shift;
	$self->YYParse( yylex => \&_Lexer, yyerror => \&_Error );
} # end of Run


1;
