####################################################################
#
#    This file was generated using Parse::Yapp version 1.05.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package Emacspeak;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
use Parse::Yapp::Driver;

#line 24 "../parser.yp"


# These constants are used as start states, a-la %x in Yacc.
use constant X_INITIAL			=> 0;

# q or tts_say
use constant X_SPEECH			=> 1;

# a (play sound file)
use constant X_RESOURCE			=> 2;

# l (single letter)
use constant X_LETTER			=> 4;

# c
use constant X_CODE				=> 8;

# we're inside braces
use constant X_INBRACES			=> 16;

# All free-form payloads.
# Payloads for these three functions don't conform to fixed format, like integer, punctuation levels, flag etc. FF = free-form
use constant X_FF			=> (X_SPEECH|X_LETTER|X_CODE);

our $VERSION = '1.0.0';

# set to a non-zero value to see debug messages
my $debug = 0;



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
			'TTS_CAPITALIZE' => 17,
			'TTS_PAUSE' => 18,
			"d" => 22,
			'TTS_SPLIT_CAPS' => 21,
			"c" => 20,
			'TTS_SYNC_STATE' => 42,
			"s" => 14,
			'TTS_SAY' => 16,
			'TTS_SET_SPEECH_RATE' => 5,
			"a" => 37,
			"b" => 7,
			"l" => 6,
			'SH' => 40,
			'TTS_ALLCAPS_BEEP' => 39,
			"t" => 9,
			'TTS_RESET' => 38,
			'TTS_SET_CHARACTER_SCALE' => 24,
			'' => 32,
			'VERSION' => 3,
			'TTS_SET_PUNCTUATIONS' => 29,
			'TTS_RESUME' => 28,
			"q" => 31
		},
		GOTOS => {
			'version' => 46,
			'stop' => 19,
			'code' => 23,
			'sound' => 11,
			'silence' => 41,
			'tone' => 12,
			'beep' => 44,
			'character' => 45,
			'tts_set_speech_rate' => 43,
			'tts_set_punctuations' => 13,
			'tts_pause' => 15,
			'tts_set_character_scale' => 35,
			'queued_speech' => 4,
			'tts_split_caps' => 36,
			'cmd' => 8,
			'tts_reset' => 10,
			'tts_allcaps_beep' => 25,
			'dispatch' => 27,
			'tts_sync_state' => 26,
			'immediate_speech' => 33,
			'tts_resume' => 30,
			'speech' => 2,
			'tts_capitalize' => 34
		}
	},
	{#State 2
		DEFAULT => -4
	},
	{#State 3
		ACTIONS => {
			"\n" => 47
		}
	},
	{#State 4
		DEFAULT => -25
	},
	{#State 5
		ACTIONS => {
			"{" => 49,
			'INTEGER' => 48
		}
	},
	{#State 6
		ACTIONS => {
			'CHAR' => 50,
			"{" => 51
		}
	},
	{#State 7
		ACTIONS => {
			'INTEGER' => 52,
			"{" => 53
		}
	},
	{#State 8
		DEFAULT => -2
	},
	{#State 9
		ACTIONS => {
			"{" => 55,
			'INTEGER' => 54
		}
	},
	{#State 10
		DEFAULT => -13
	},
	{#State 11
		DEFAULT => -11
	},
	{#State 12
		DEFAULT => -10
	},
	{#State 13
		DEFAULT => -18
	},
	{#State 14
		ACTIONS => {
			"\n" => 56
		}
	},
	{#State 15
		DEFAULT => -12
	},
	{#State 16
		ACTIONS => {
			"{" => 58,
			'ATOM' => 57
		}
	},
	{#State 17
		ACTIONS => {
			"{" => 60,
			'FLAG' => 59
		}
	},
	{#State 18
		ACTIONS => {
			"\n" => 61
		}
	},
	{#State 19
		DEFAULT => -6
	},
	{#State 20
		ACTIONS => {
			"{" => 62,
			'ATOM' => 63
		}
	},
	{#State 21
		ACTIONS => {
			'FLAG' => 65,
			"{" => 64
		}
	},
	{#State 22
		ACTIONS => {
			"\n" => 66
		}
	},
	{#State 23
		DEFAULT => -3
	},
	{#State 24
		ACTIONS => {
			"{" => 67,
			'DOUBLE' => 68
		}
	},
	{#State 25
		DEFAULT => -15
	},
	{#State 26
		DEFAULT => -21
	},
	{#State 27
		DEFAULT => -5
	},
	{#State 28
		ACTIONS => {
			"\n" => 69
		}
	},
	{#State 29
		ACTIONS => {
			'NONE' => 71,
			"{" => 74,
			'ALL' => 73,
			'SOME' => 72
		},
		GOTOS => {
			'punctlevel' => 70
		}
	},
	{#State 30
		DEFAULT => -14
	},
	{#State 31
		ACTIONS => {
			"{" => 75,
			'ATOM' => 76
		}
	},
	{#State 32
		DEFAULT => 0
	},
	{#State 33
		DEFAULT => -24
	},
	{#State 34
		DEFAULT => -16
	},
	{#State 35
		DEFAULT => -17
	},
	{#State 36
		DEFAULT => -20
	},
	{#State 37
		ACTIONS => {
			'RESOURCE' => 78,
			"{" => 77
		}
	},
	{#State 38
		ACTIONS => {
			"\n" => 79
		}
	},
	{#State 39
		ACTIONS => {
			'FLAG' => 81,
			"{" => 80
		}
	},
	{#State 40
		ACTIONS => {
			"{" => 82,
			'INTEGER' => 83
		}
	},
	{#State 41
		DEFAULT => -8
	},
	{#State 42
		ACTIONS => {
			'NONE' => 71,
			"{" => 84,
			'ALL' => 73,
			'SOME' => 72
		},
		GOTOS => {
			'punctlevel' => 85
		}
	},
	{#State 43
		DEFAULT => -19
	},
	{#State 44
		DEFAULT => -9
	},
	{#State 45
		DEFAULT => -26
	},
	{#State 46
		DEFAULT => -7
	},
	{#State 47
		DEFAULT => -34
	},
	{#State 48
		ACTIONS => {
			"\n" => 86
		}
	},
	{#State 49
		ACTIONS => {
			'INTEGER' => 87
		}
	},
	{#State 50
		ACTIONS => {
			"\n" => 88
		}
	},
	{#State 51
		ACTIONS => {
			'CHAR' => 89
		}
	},
	{#State 52
		ACTIONS => {
			'INTEGER' => 90
		}
	},
	{#State 53
		ACTIONS => {
			'INTEGER' => 91
		}
	},
	{#State 54
		ACTIONS => {
			'INTEGER' => 92
		}
	},
	{#State 55
		ACTIONS => {
			'INTEGER' => 93
		}
	},
	{#State 56
		DEFAULT => -35
	},
	{#State 57
		ACTIONS => {
			"\n" => 94
		}
	},
	{#State 58
		ACTIONS => {
			'TEXT' => 95
		}
	},
	{#State 59
		ACTIONS => {
			"\n" => 96
		}
	},
	{#State 60
		ACTIONS => {
			'FLAG' => 97
		}
	},
	{#State 61
		DEFAULT => -44
	},
	{#State 62
		ACTIONS => {
			'CODE' => 98
		}
	},
	{#State 63
		ACTIONS => {
			"\n" => 99
		}
	},
	{#State 64
		ACTIONS => {
			'FLAG' => 100
		}
	},
	{#State 65
		ACTIONS => {
			"\n" => 101
		}
	},
	{#State 66
		DEFAULT => -33
	},
	{#State 67
		ACTIONS => {
			'DOUBLE' => 102
		}
	},
	{#State 68
		ACTIONS => {
			"\n" => 103
		}
	},
	{#State 69
		DEFAULT => -46
	},
	{#State 70
		ACTIONS => {
			"\n" => 104
		}
	},
	{#State 71
		DEFAULT => -61
	},
	{#State 72
		DEFAULT => -62
	},
	{#State 73
		DEFAULT => -63
	},
	{#State 74
		ACTIONS => {
			'SOME' => 72,
			'ALL' => 73,
			'NONE' => 71
		},
		GOTOS => {
			'punctlevel' => 105
		}
	},
	{#State 75
		ACTIONS => {
			'TEXT' => 106
		}
	},
	{#State 76
		ACTIONS => {
			"\n" => 107
		}
	},
	{#State 77
		ACTIONS => {
			'RESOURCE' => 108
		}
	},
	{#State 78
		ACTIONS => {
			"\n" => 109
		}
	},
	{#State 79
		DEFAULT => -45
	},
	{#State 80
		ACTIONS => {
			'FLAG' => 110
		}
	},
	{#State 81
		ACTIONS => {
			"\n" => 111
		}
	},
	{#State 82
		ACTIONS => {
			'INTEGER' => 112
		}
	},
	{#State 83
		ACTIONS => {
			"\n" => 113
		}
	},
	{#State 84
		ACTIONS => {
			'SOME' => 72,
			'ALL' => 73,
			'NONE' => 71
		},
		GOTOS => {
			'punctlevel' => 114
		}
	},
	{#State 85
		ACTIONS => {
			'FLAG' => 115
		}
	},
	{#State 86
		DEFAULT => -56
	},
	{#State 87
		ACTIONS => {
			"}" => 116
		}
	},
	{#State 88
		DEFAULT => -30
	},
	{#State 89
		ACTIONS => {
			"}" => 117
		}
	},
	{#State 90
		ACTIONS => {
			"\n" => 118
		}
	},
	{#State 91
		ACTIONS => {
			'INTEGER' => 119
		}
	},
	{#State 92
		ACTIONS => {
			"\n" => 120
		}
	},
	{#State 93
		ACTIONS => {
			'INTEGER' => 121
		}
	},
	{#State 94
		DEFAULT => -28
	},
	{#State 95
		ACTIONS => {
			"}" => 122
		}
	},
	{#State 96
		DEFAULT => -50
	},
	{#State 97
		ACTIONS => {
			"}" => 123
		}
	},
	{#State 98
		ACTIONS => {
			"}" => 124
		}
	},
	{#State 99
		DEFAULT => -23
	},
	{#State 100
		ACTIONS => {
			"}" => 125
		}
	},
	{#State 101
		DEFAULT => -58
	},
	{#State 102
		ACTIONS => {
			"}" => 126
		}
	},
	{#State 103
		DEFAULT => -52
	},
	{#State 104
		DEFAULT => -54
	},
	{#State 105
		ACTIONS => {
			"}" => 127
		}
	},
	{#State 106
		ACTIONS => {
			"}" => 128
		}
	},
	{#State 107
		DEFAULT => -32
	},
	{#State 108
		ACTIONS => {
			"}" => 129
		}
	},
	{#State 109
		DEFAULT => -43
	},
	{#State 110
		ACTIONS => {
			"}" => 130
		}
	},
	{#State 111
		DEFAULT => -48
	},
	{#State 112
		ACTIONS => {
			"}" => 131
		}
	},
	{#State 113
		DEFAULT => -37
	},
	{#State 114
		ACTIONS => {
			'FLAG' => 132
		}
	},
	{#State 115
		ACTIONS => {
			'FLAG' => 133
		}
	},
	{#State 116
		ACTIONS => {
			"\n" => 134
		}
	},
	{#State 117
		ACTIONS => {
			"\n" => 135
		}
	},
	{#State 118
		DEFAULT => -39
	},
	{#State 119
		ACTIONS => {
			"}" => 136
		}
	},
	{#State 120
		DEFAULT => -41
	},
	{#State 121
		ACTIONS => {
			"}" => 137
		}
	},
	{#State 122
		ACTIONS => {
			"\n" => 138
		}
	},
	{#State 123
		ACTIONS => {
			"\n" => 139
		}
	},
	{#State 124
		ACTIONS => {
			"\n" => 140
		}
	},
	{#State 125
		ACTIONS => {
			"\n" => 141
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
			'FLAG' => 148
		}
	},
	{#State 133
		ACTIONS => {
			'FLAG' => 149
		}
	},
	{#State 134
		DEFAULT => -55
	},
	{#State 135
		DEFAULT => -29
	},
	{#State 136
		ACTIONS => {
			"\n" => 150
		}
	},
	{#State 137
		ACTIONS => {
			"\n" => 151
		}
	},
	{#State 138
		DEFAULT => -27
	},
	{#State 139
		DEFAULT => -49
	},
	{#State 140
		DEFAULT => -22
	},
	{#State 141
		DEFAULT => -57
	},
	{#State 142
		DEFAULT => -51
	},
	{#State 143
		DEFAULT => -53
	},
	{#State 144
		DEFAULT => -31
	},
	{#State 145
		DEFAULT => -42
	},
	{#State 146
		DEFAULT => -47
	},
	{#State 147
		DEFAULT => -36
	},
	{#State 148
		ACTIONS => {
			'FLAG' => 152
		}
	},
	{#State 149
		ACTIONS => {
			'INTEGER' => 153
		}
	},
	{#State 150
		DEFAULT => -38
	},
	{#State 151
		DEFAULT => -40
	},
	{#State 152
		ACTIONS => {
			'INTEGER' => 154
		}
	},
	{#State 153
		ACTIONS => {
			"\n" => 155
		}
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
#line 68 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 4
		 'cmd', 1,
sub
#line 69 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 5
		 'cmd', 1,
sub
#line 71 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_d}};
					$_[1];
						}
	],
	[#Rule 6
		 'cmd', 1,
sub
#line 76 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_s}};
		$_[1];
		}
	],
	[#Rule 7
		 'cmd', 1,
sub
#line 81 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_version}};
			$_[1];
		}
	],
	[#Rule 8
		 'cmd', 1,
sub
#line 86 "../parser.yp"
{ 
			&{$_[0]->YYData->{SA}->{tts_silence}}($_[1]);
$_[1];
		}
	],
	[#Rule 9
		 'cmd', 1,
sub
#line 90 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 10
		 'cmd', 1,
sub
#line 91 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 11
		 'cmd', 1,
sub
#line 92 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 12
		 'cmd', 1,
sub
#line 94 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_pause}};
			$_[1];
		}
	],
	[#Rule 13
		 'cmd', 1,
sub
#line 99 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_reset}};
			$_[1];
		}
	],
	[#Rule 14
		 'cmd', 1,
sub
#line 104 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_resume}};
			$_[1];
		}
	],
	[#Rule 15
		 'cmd', 1,
sub
#line 109 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_allcaps_beep}}($_[1]);
			$_[1];
		}
	],
	[#Rule 16
		 'cmd', 1,
sub
#line 114 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_capitalize}}($_[1]);
			$_[1];
		}
	],
	[#Rule 17
		 'cmd', 1,
sub
#line 119 "../parser.yp"
{
			$_[1];
		}
	],
	[#Rule 18
		 'cmd', 1,
sub
#line 123 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_set_punctuations}}($_[1]);
			$_[1];
		}
	],
	[#Rule 19
		 'cmd', 1,
sub
#line 128 "../parser.yp"
{ 
			&{$_[0]->YYData->{SA}->{tts_set_speech_rate}}($_[1]);
				$_[1];		
		}
	],
	[#Rule 20
		 'cmd', 1,
sub
#line 133 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_split_caps}}($_[1]);
			$_[1];
		}
	],
	[#Rule 21
		 'cmd', 1,
sub
#line 138 "../parser.yp"
{
			$_[1];
		}
	],
	[#Rule 22
		 'code', 5,
sub
#line 145 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_c}}($_[3]);
			$_[1];
		}
	],
	[#Rule 23
		 'code', 3,
sub
#line 150 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_c}}($_[2]);
			$_[1];
		}
	],
	[#Rule 24
		 'speech', 1,
sub
#line 157 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 25
		 'speech', 1,
sub
#line 158 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 26
		 'speech', 1,
sub
#line 159 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 27
		 'immediate_speech', 5,
sub
#line 164 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_say}}($_[3]);
			$_[1];
		}
	],
	[#Rule 28
		 'immediate_speech', 3,
sub
#line 169 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_say}}($_[2]);
			$_[1];
		}
	],
	[#Rule 29
		 'character', 5,
sub
#line 177 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_l}}($_[3]);
			$_[1];
		}
	],
	[#Rule 30
		 'character', 3,
sub
#line 182 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_l}}($_[2]);
			$_[1];
		}
	],
	[#Rule 31
		 'queued_speech', 5,
sub
#line 190 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_q}}($_[3]);
			$_[1];
		}
	],
	[#Rule 32
		 'queued_speech', 3,
sub
#line 195 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_q}}($_[2]);
			$_[1];
		}
	],
	[#Rule 33
		 'dispatch', 2,
sub
#line 202 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 34
		 'version', 2,
sub
#line 206 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 35
		 'stop', 2,
sub
#line 210 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 36
		 'silence', 5,
sub
#line 215 "../parser.yp"
{
			$_[3];
		}
	],
	[#Rule 37
		 'silence', 3,
sub
#line 219 "../parser.yp"
{
			$_[2];
		}
	],
	[#Rule 38
		 'beep', 6,
sub
#line 226 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_b}}($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 39
		 'beep', 4,
sub
#line 231 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_b}}($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 40
		 'tone', 6,
sub
#line 239 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_t}}($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 41
		 'tone', 4,
sub
#line 244 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_t}}($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 42
		 'sound', 5,
sub
#line 252 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_a}}($_[3]);
			$_[1];
		}
	],
	[#Rule 43
		 'sound', 3,
sub
#line 257 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_a}}($_[2]);
			$_[1];
		}
	],
	[#Rule 44
		 'tts_pause', 2,
sub
#line 264 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 45
		 'tts_reset', 2,
sub
#line 268 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 46
		 'tts_resume', 2,
sub
#line 272 "../parser.yp"
{ $_[1]; }
	],
	[#Rule 47
		 'tts_allcaps_beep', 5,
sub
#line 276 "../parser.yp"
{ $_[3]; }
	],
	[#Rule 48
		 'tts_allcaps_beep', 3,
sub
#line 277 "../parser.yp"
{ $_[2]; }
	],
	[#Rule 49
		 'tts_capitalize', 5,
sub
#line 281 "../parser.yp"
{ $_[3]; }
	],
	[#Rule 50
		 'tts_capitalize', 3,
sub
#line 282 "../parser.yp"
{ $_[2]; }
	],
	[#Rule 51
		 'tts_set_character_scale', 5,
sub
#line 287 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_set_character_scale}}($_[3]);
			$_[1];
		}
	],
	[#Rule 52
		 'tts_set_character_scale', 3,
sub
#line 292 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_set_character_scale}}($_[2]);
			$_[1];
		}
	],
	[#Rule 53
		 'tts_set_punctuations', 5,
sub
#line 299 "../parser.yp"
{ $_[3]; }
	],
	[#Rule 54
		 'tts_set_punctuations', 3,
sub
#line 300 "../parser.yp"
{ $_[2]; }
	],
	[#Rule 55
		 'tts_set_speech_rate', 5,
sub
#line 304 "../parser.yp"
{ $_[3]; }
	],
	[#Rule 56
		 'tts_set_speech_rate', 3,
sub
#line 305 "../parser.yp"
{ $_[2]; }
	],
	[#Rule 57
		 'tts_split_caps', 5,
sub
#line 309 "../parser.yp"
{ $_[3]; }
	],
	[#Rule 58
		 'tts_split_caps', 3,
sub
#line 310 "../parser.yp"
{ $_[2]; }
	],
	[#Rule 59
		 'tts_sync_state', 9,
sub
#line 315 "../parser.yp"
{ 
			&{$_[0]->YYData->{SA}->{tts_sync_state}}($_[3], $_[4], $_[5], $_[6], $_[7]);
			$_[1];
		}
	],
	[#Rule 60
		 'tts_sync_state', 7,
sub
#line 320 "../parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_sync_state}}($_[2],$_[3], $_[4], $_[5], $_[6]);
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

#line 332 "../parser.yp"


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

		# don't want to consume whitespace if we're inside braces in the c function
		unless ( ($parser->YYData->{STATE} & X_CODE ) &&
($parser->YYData->{STATE} & X_INBRACES ) ) {
	# Eat white space
    $parser->YYData->{INPUT} =~ s/^[ \t]+//;
}

	# This is not a loop. It is just here to set the $_ variable
	for ($parser->YYData->{INPUT}) {

		# Parse text if we're inside braces for c
		if ( ($parser->YYData->{STATE} & X_CODE ) &&
($parser->YYData->{STATE} & X_INBRACES ) ) {
			print "State X_CODE/X_INBRACES\n" if $debug;
			s/^([^}]+)//
			and do {
				$parser->YYData->{STATE} = X_INITIAL;
				print "About to return code: >$1<\n" if $debug;
				return('CODE',$1);
			};
		}


		# Parse text if we're inside braces for q and tts_say
		if ( ($parser->YYData->{STATE} & X_SPEECH ) &&
($parser->YYData->{STATE} & X_INBRACES ) ) {
			print "State X_SPEECH/X_INBRACES\n" if $debug;
			s/^\s*([^}]+)\s*//
			and do {
				$parser->YYData->{STATE} = X_INITIAL;
				print "About to return text: >$1<\n" if $debug;
				return('TEXT',$1);
			};
		}

		# lipstick
		# Parse atom (string with no spaces) for q and tts_say
		if ($parser->YYData->{STATE} & X_SPEECH ) {
			s/^([^ {}\n]+)//
			and do {
				print "About to return ATOM\n" if $debug;
				$parser->YYData->{STATE} = X_INITIAL;
				return('ATOM',$1);
			};
		}

		# Parse resource (string with no spaces) for a
		if ($parser->YYData->{STATE} & X_RESOURCE ) {
			s/^([^ {}\n]+)//
			and do {
				print "About to return RESOURCE\n" if $debug;
				$parser->YYData->{STATE} = X_INITIAL;
				return('RESOURCE',$1);
			};
		}
		
		# tts_say, immediate speech. Set state to X_SPEECH and return function token
		s/^(tts_say)//i
		and do {
			$parser->YYData->{STATE} |= X_SPEECH;
			return('TTS_SAY',$1);
		};

		# Parse single character (letter) for the l function
		if ( ($parser->YYData->{STATE} & X_LETTER ) &&
($parser->YYData->{STATE} & X_INBRACES ) ) {
			print "State X_LETTER/X_INBRACES\n" if $debug;
			s/^\s*([^}])\s*//
			and do {
				$parser->YYData->{STATE} = X_INITIAL;
				print "About to return letter: >$1<\n" if $debug;
				return('CHAR',$1);
			};
		}

		# Parse single letter 
		if ($parser->YYData->{STATE} & X_LETTER ) {
			s/^([^ {}\n])//
			and do {
				print "About to return CHAR\n" if $debug;
				$parser->YYData->{STATE} = X_INITIAL;
				return('CHAR',$1);
			};
		}

		# Version, no arguments
		s/^(version)//i
		and return('VERSION',$1);

		# punctuation levels
		s/^((none|some|all))//
		and do {
			return(uc($1),{'none'=>0,'some'=>1,'all'=>2}->{$1});
		};

		# Pause, reset and resume have no arguments

		# pause
		s/^(tts_pause)//i
		and return('TTS_PAUSE',$1);

		# reset 
		s/^(tts_reset)//i
		and return('TTS_RESET',$1);

		# resume 
		s/^(tts_resume)//i
		and return('TTS_RESUME',$1);

		# These tts_* functions either have braces or not

		# tts_allcaps_beep
		s/^(tts_allcaps_beep)//i
		and return('TTS_ALLCAPS_BEEP',$1);

		# tts_capitalize
		s/^(tts_capitalize)//i
		and return('TTS_CAPITALIZE',$1);

		# tts_set_character_scale
		s/^(tts_set_character_scale)//i
		and return('TTS_SET_CHARACTER_SCALE',$1);

		# tts_set_punctuations	
		s/^(tts_set_punctuations)//i
		and return('TTS_SET_PUNCTUATIONS',$1);

		# tts_set_speech_rate
		s/^(tts_set_speech_rate)//i
		and do {
			$parser->YYData->{CONDITION} = 1;
			return('TTS_SET_SPEECH_RATE',$1);
		};

		# tts_split_caps
		s/^(tts_split_caps)//i
		and return('TTS_SPLIT_CAPS',$1);

		# tts_sync_state with or without braces but I've never seen braces

		# tts_sync_state
		s/^(tts_sync_state)//i
		and return('TTS_SYNC_STATE',$1);

	# silence 'sh'
		s/^(sh)//i
		and return('SH',$1);

		# Start of single-character patterns

		# Dispatch 'd'
		s/^(d)//i
		and return($1,$1);

		# stop 's'
		s/^(s)//i
			and return($1,$1);

		# code 'c'
		s/^(c)//i
		and do {
			$parser->YYData->{STATE} |= X_CODE;
			return($1,$1);
		};

		# single letter 'l'
		s/^(l)//i
		and do {
			print "Found single-letter prefix\n" if $debug;
			$parser->YYData->{STATE} |= X_LETTER;
			return(lc($1),$1);
		};


		# queued speech 'q'
		s/^(q)//i
		and do {
			print "Found q\n" if $debug;
			$parser->YYData->{STATE} |= X_SPEECH;
			return(lc($1),$1);
		};

		# tone 't' 
		s/^(t)//i
		and return($1,$1);

		# beep 'b'
		s/^(b)//i
		and return($1,$1);

		# sound file 'a' or 'p'
		s/^((a|p))//i
		and do {
			$parser->YYData->{STATE} |= X_RESOURCE;
			return($1,$1);
		};

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
		and do {
			if ($parser->YYData->{STATE} & X_FF) {
				print "Found left brace while in X_FF\n" if $debug;
				$parser->YYData->{STATE} |= X_INBRACES;
			}
			return($1,$1);
		};

		# Right-brace
		s/^(})//
		and do {
			print "Found right brace\n" if $debug;
			$parser->YYData->{STATE} = X_INITIAL;
			return($1,$1);
		};

		# newline
		s/^(\n)//s
		and do {
			print "Found newline\n" if $debug;
			$parser->YYData->{STATE} = X_INITIAL;
			return($1,$1);
		};

	} # end of for()

} # end of _Lexer

sub Run {
	my($self)=shift;
	$self->YYParse( yylex => \&_Lexer, yyerror => \&_Error );
} # end of Run

1;


__END__

=pod

=head1 name

Parse::Emacspeak - Emacspeak text-to-speech protocol parser

=head1 SYNOPSIS

	use Parse::Emacspeak;

	my $parser = new Emacspeak;

	# Preset state to zero
	$parser->YYData->{STATE} = 0;

	my $value = $parser->YYParse(
			yylex => \&Emacspeak::_Lexer,
			yyerror => \&Emacspeak::_Error,
			yydebug => shift || 0
		);

	my $nberr = $parser->YYNberr();

	$parser->Run;

=head1 EXAMPLE

	#!/usr/bin/perl -w

	use strict;
	use warnings;

	use Parse::Emacspeak;

	my $parser = new Emacspeak;

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
			yylex => \&Emacspeak::_Lexer,
			yyerror => \&Emacspeak::_Error,
			yydebug => shift || 0
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

=head1 DESCRIPTION

Emacspeak is an extension to emacs written by T.V. Raman.

It communicates with a speech-synthesiser via a protocol written to STDOUT with text-to-speech 
functions which resemble TCL function calls. Current text-to-speech servers bundled with Emacspeak 
are TCL scripts.

This module uses Parse::Yapp to parse the protocol by reading STDIN, tokenising the text and calling 
appropriate tts functions.

=head2 SEMANTIC ACTIONS

See the manual for Parse::Yapp for an explanation of the syntax of semantic actions in the 
Parse::Yapp grammar.

In every rule the first array entry ($_[0]) contains the parser object.

Text-to-speech functions to be called when a rule is reduced must be loaded into the parser object 
within the user-data hash:

	$parser->YYData

This module uses:

	$_[0]->YYData->{SA}->{name-of-tts-function-to-call}

For example to call the function called when an Emacspeak dispatch function is called (letter d 
followed by newline, and nothing else on a line), assuming you have called the function 'tts_d' in 
your code:

	$parser->YYData->{SA}-{ttsd} = \&tts_d;

It's then called in the semantic action like this:

	&{$_[0]->YYData->{SA}->{tts_d}};

And a function with arguments, for example 'tts_set_speech_rate' assuming the speech rate is $_[2]:

	&{$_[0]->YYData->{SA}->{tts_set_speech_rate}}($_[3]);

See the above example of a test script.

=head1 IMPORTANT

There *MUST* be a subroutine reference in the parser object for every rule in the grammar, even if 
the speech-synthesiser you are writing code for does not support the functionality represented by 
that function.


1;
