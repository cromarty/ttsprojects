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
my $debug = 1;



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
			'TTS_CAPITALIZE' => 29,
			'TTS_SPLIT_CAPS' => 3,
			"s" => 4,
			"c" => 32,
			"q" => 5,
			"l" => 8,
			'TTS_RESET' => 10,
			'' => 33,
			"a" => 11,
			'TTS_SET_CHARACTER_SCALE' => 15,
			'SH' => 35,
			'TTS_PAUSE' => 16,
			"b" => 20,
			'TTS_SET_SPEECH_RATE' => 22,
			'VERSION' => 38,
			'TTS_SET_PUNCTUATIONS' => 21,
			'TTS_ALLCAPS_BEEP' => 40,
			'TTS_SAY' => 25,
			"d" => 42,
			'TTS_SYNC_STATE' => 44,
			"t" => 46,
			'TTS_RESUME' => 45
		},
		GOTOS => {
			'code' => 18,
			'speech' => 17,
			'dispatch' => 37,
			'silence' => 36,
			'tts_allcaps_beep' => 19,
			'sound' => 26,
			'stop' => 39,
			'tone' => 24,
			'tts_split_caps' => 23,
			'character' => 43,
			'tts_reset' => 28,
			'version' => 27,
			'queued_speech' => 41,
			'beep' => 2,
			'immediate_speech' => 31,
			'tts_sync_state' => 30,
			'cmd' => 6,
			'tts_capitalize' => 7,
			'tts_set_punctuations' => 13,
			'tts_set_speech_rate' => 34,
			'tts_pause' => 14,
			'tts_set_character_scale' => 12,
			'tts_resume' => 9
		}
	},
	{#State 2
		DEFAULT => -9
	},
	{#State 3
		ACTIONS => {
			'FLAG' => 48,
			"{" => 47
		}
	},
	{#State 4
		ACTIONS => {
			"\n" => 49
		}
	},
	{#State 5
		ACTIONS => {
			'ATOM' => 50,
			"{" => 51
		}
	},
	{#State 6
		DEFAULT => -2
	},
	{#State 7
		DEFAULT => -16
	},
	{#State 8
		ACTIONS => {
			"{" => 53,
			'CHAR' => 52
		}
	},
	{#State 9
		DEFAULT => -14
	},
	{#State 10
		ACTIONS => {
			"\n" => 54
		}
	},
	{#State 11
		ACTIONS => {
			'RESOURCE' => 55,
			"{" => 56
		}
	},
	{#State 12
		DEFAULT => -17
	},
	{#State 13
		DEFAULT => -18
	},
	{#State 14
		DEFAULT => -12
	},
	{#State 15
		ACTIONS => {
			"{" => 58,
			'DOUBLE' => 57
		}
	},
	{#State 16
		ACTIONS => {
			"\n" => 59
		}
	},
	{#State 17
		DEFAULT => -4
	},
	{#State 18
		DEFAULT => -3
	},
	{#State 19
		DEFAULT => -15
	},
	{#State 20
		ACTIONS => {
			"{" => 61,
			'INTEGER' => 60
		}
	},
	{#State 21
		ACTIONS => {
			'ALL' => 62,
			'NONE' => 66,
			"{" => 63,
			'SOME' => 65
		},
		GOTOS => {
			'punctlevel' => 64
		}
	},
	{#State 22
		ACTIONS => {
			"{" => 68,
			'INTEGER' => 67
		}
	},
	{#State 23
		DEFAULT => -20
	},
	{#State 24
		DEFAULT => -10
	},
	{#State 25
		ACTIONS => {
			"{" => 69,
			'ATOM' => 70
		}
	},
	{#State 26
		DEFAULT => -11
	},
	{#State 27
		DEFAULT => -7
	},
	{#State 28
		DEFAULT => -13
	},
	{#State 29
		ACTIONS => {
			"{" => 71,
			'FLAG' => 72
		}
	},
	{#State 30
		DEFAULT => -21
	},
	{#State 31
		DEFAULT => -24
	},
	{#State 32
		ACTIONS => {
			"{" => 73,
			'ATOM' => 74
		}
	},
	{#State 33
		DEFAULT => 0
	},
	{#State 34
		DEFAULT => -19
	},
	{#State 35
		ACTIONS => {
			'INTEGER' => 76,
			"{" => 75
		}
	},
	{#State 36
		DEFAULT => -8
	},
	{#State 37
		DEFAULT => -5
	},
	{#State 38
		ACTIONS => {
			"\n" => 77
		}
	},
	{#State 39
		DEFAULT => -6
	},
	{#State 40
		ACTIONS => {
			'FLAG' => 78,
			"{" => 79
		}
	},
	{#State 41
		DEFAULT => -25
	},
	{#State 42
		ACTIONS => {
			"\n" => 80
		}
	},
	{#State 43
		DEFAULT => -26
	},
	{#State 44
		ACTIONS => {
			'NONE' => 66,
			'ALL' => 62,
			"{" => 81,
			'SOME' => 65
		},
		GOTOS => {
			'punctlevel' => 82
		}
	},
	{#State 45
		ACTIONS => {
			"\n" => 83
		}
	},
	{#State 46
		ACTIONS => {
			'INTEGER' => 85,
			"{" => 84
		}
	},
	{#State 47
		ACTIONS => {
			'FLAG' => 86
		}
	},
	{#State 48
		ACTIONS => {
			"\n" => 87
		}
	},
	{#State 49
		DEFAULT => -35
	},
	{#State 50
		ACTIONS => {
			"\n" => 88
		}
	},
	{#State 51
		ACTIONS => {
			'TEXT' => 89
		}
	},
	{#State 52
		ACTIONS => {
			"\n" => 90
		}
	},
	{#State 53
		ACTIONS => {
			'CHAR' => 91
		}
	},
	{#State 54
		DEFAULT => -45
	},
	{#State 55
		ACTIONS => {
			"\n" => 92
		}
	},
	{#State 56
		ACTIONS => {
			'RESOURCE' => 93
		}
	},
	{#State 57
		ACTIONS => {
			"\n" => 94
		}
	},
	{#State 58
		ACTIONS => {
			'DOUBLE' => 95
		}
	},
	{#State 59
		DEFAULT => -44
	},
	{#State 60
		ACTIONS => {
			'INTEGER' => 96
		}
	},
	{#State 61
		ACTIONS => {
			'INTEGER' => 97
		}
	},
	{#State 62
		DEFAULT => -63
	},
	{#State 63
		ACTIONS => {
			'ALL' => 62,
			'NONE' => 66,
			'SOME' => 65
		},
		GOTOS => {
			'punctlevel' => 98
		}
	},
	{#State 64
		ACTIONS => {
			"\n" => 99
		}
	},
	{#State 65
		DEFAULT => -62
	},
	{#State 66
		DEFAULT => -61
	},
	{#State 67
		ACTIONS => {
			"\n" => 100
		}
	},
	{#State 68
		ACTIONS => {
			'INTEGER' => 101
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
		ACTIONS => {
			'FLAG' => 104
		}
	},
	{#State 72
		ACTIONS => {
			"\n" => 105
		}
	},
	{#State 73
		ACTIONS => {
			'CODE' => 106
		}
	},
	{#State 74
		ACTIONS => {
			"\n" => 107
		}
	},
	{#State 75
		ACTIONS => {
			'INTEGER' => 108
		}
	},
	{#State 76
		ACTIONS => {
			"\n" => 109
		}
	},
	{#State 77
		DEFAULT => -34
	},
	{#State 78
		ACTIONS => {
			"\n" => 110
		}
	},
	{#State 79
		ACTIONS => {
			'FLAG' => 111
		}
	},
	{#State 80
		DEFAULT => -33
	},
	{#State 81
		ACTIONS => {
			'NONE' => 66,
			'ALL' => 62,
			'SOME' => 65
		},
		GOTOS => {
			'punctlevel' => 112
		}
	},
	{#State 82
		ACTIONS => {
			'FLAG' => 113
		}
	},
	{#State 83
		DEFAULT => -46
	},
	{#State 84
		ACTIONS => {
			'INTEGER' => 114
		}
	},
	{#State 85
		ACTIONS => {
			'INTEGER' => 115
		}
	},
	{#State 86
		ACTIONS => {
			"}" => 116
		}
	},
	{#State 87
		DEFAULT => -58
	},
	{#State 88
		DEFAULT => -32
	},
	{#State 89
		ACTIONS => {
			"}" => 117
		}
	},
	{#State 90
		DEFAULT => -30
	},
	{#State 91
		ACTIONS => {
			"}" => 118
		}
	},
	{#State 92
		DEFAULT => -43
	},
	{#State 93
		ACTIONS => {
			"}" => 119
		}
	},
	{#State 94
		DEFAULT => -52
	},
	{#State 95
		ACTIONS => {
			"}" => 120
		}
	},
	{#State 96
		ACTIONS => {
			"\n" => 121
		}
	},
	{#State 97
		ACTIONS => {
			'INTEGER' => 122
		}
	},
	{#State 98
		ACTIONS => {
			"}" => 123
		}
	},
	{#State 99
		DEFAULT => -54
	},
	{#State 100
		DEFAULT => -56
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
		DEFAULT => -28
	},
	{#State 104
		ACTIONS => {
			"}" => 126
		}
	},
	{#State 105
		DEFAULT => -50
	},
	{#State 106
		ACTIONS => {
			"}" => 127
		}
	},
	{#State 107
		DEFAULT => -23
	},
	{#State 108
		ACTIONS => {
			"}" => 128
		}
	},
	{#State 109
		DEFAULT => -37
	},
	{#State 110
		DEFAULT => -48
	},
	{#State 111
		ACTIONS => {
			"}" => 129
		}
	},
	{#State 112
		ACTIONS => {
			'FLAG' => 130
		}
	},
	{#State 113
		ACTIONS => {
			'FLAG' => 131
		}
	},
	{#State 114
		ACTIONS => {
			'INTEGER' => 132
		}
	},
	{#State 115
		ACTIONS => {
			"\n" => 133
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
		ACTIONS => {
			"\n" => 136
		}
	},
	{#State 119
		ACTIONS => {
			"\n" => 137
		}
	},
	{#State 120
		ACTIONS => {
			"\n" => 138
		}
	},
	{#State 121
		DEFAULT => -39
	},
	{#State 122
		ACTIONS => {
			"}" => 139
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
			"\n" => 145
		}
	},
	{#State 129
		ACTIONS => {
			"\n" => 146
		}
	},
	{#State 130
		ACTIONS => {
			'FLAG' => 147
		}
	},
	{#State 131
		ACTIONS => {
			'FLAG' => 148
		}
	},
	{#State 132
		ACTIONS => {
			"}" => 149
		}
	},
	{#State 133
		DEFAULT => -41
	},
	{#State 134
		DEFAULT => -57
	},
	{#State 135
		DEFAULT => -31
	},
	{#State 136
		DEFAULT => -29
	},
	{#State 137
		DEFAULT => -42
	},
	{#State 138
		DEFAULT => -51
	},
	{#State 139
		ACTIONS => {
			"\n" => 150
		}
	},
	{#State 140
		DEFAULT => -53
	},
	{#State 141
		DEFAULT => -55
	},
	{#State 142
		DEFAULT => -27
	},
	{#State 143
		DEFAULT => -49
	},
	{#State 144
		DEFAULT => -22
	},
	{#State 145
		DEFAULT => -36
	},
	{#State 146
		DEFAULT => -47
	},
	{#State 147
		ACTIONS => {
			'FLAG' => 151
		}
	},
	{#State 148
		ACTIONS => {
			'INTEGER' => 152
		}
	},
	{#State 149
		ACTIONS => {
			"\n" => 153
		}
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


__END__

=pod

=head1 name
Parse::Emacspeak - Emacspeak text-to-speech protocol parser



1;
