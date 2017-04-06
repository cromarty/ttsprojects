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
			"d" => 21,
			'TTS_SET_PUNCTUATIONS' => 43,
			"b" => 20,
			'TTS_RESET' => 16,
			"t" => 17,
			'TTS_SET_SPEECH_RATE' => 46,
			'TTS_CAPITALIZE' => 25,
			"q" => 14,
			'SH' => 15,
			"c" => 39,
			"a" => 11,
			'VERSION' => 33,
			'TTS_SET_CHARACTER_SCALE' => 31,
			'TTS_SYNC_STATE' => 10,
			'TTS_SAY' => 34,
			'' => 36,
			"l" => 4,
			'TTS_RESUME' => 3,
			'TTS_ALLCAPS_BEEP' => 29,
			'TTS_SPLIT_CAPS' => 30,
			"s" => 7,
			'TTS_PAUSE' => 28
		},
		GOTOS => {
			'tts_pause' => 35,
			'tts_set_punctuations' => 32,
			'tts_split_caps' => 12,
			'tts_capitalize' => 26,
			'tts_allcaps_beep' => 5,
			'tts_sync_state' => 2,
			'queued_speech' => 27,
			'tts_reset' => 6,
			'speech' => 8,
			'beep' => 9,
			'immediate_speech' => 18,
			'dispatch' => 41,
			'tts_set_character_scale' => 44,
			'stop' => 19,
			'tts_resume' => 42,
			'version' => 23,
			'tts_set_speech_rate' => 22,
			'code' => 24,
			'tone' => 45,
			'silence' => 13,
			'cmd' => 37,
			'sound' => 40,
			'character' => 38
		}
	},
	{#State 2
		DEFAULT => -21
	},
	{#State 3
		ACTIONS => {
			"\n" => 47
		}
	},
	{#State 4
		ACTIONS => {
			'CHAR' => 49,
			"{" => 48
		}
	},
	{#State 5
		DEFAULT => -15
	},
	{#State 6
		DEFAULT => -13
	},
	{#State 7
		ACTIONS => {
			"\n" => 50
		}
	},
	{#State 8
		DEFAULT => -4
	},
	{#State 9
		DEFAULT => -9
	},
	{#State 10
		ACTIONS => {
			'ALL' => 52,
			'NONE' => 54,
			"{" => 51,
			'SOME' => 55
		},
		GOTOS => {
			'punctlevel' => 53
		}
	},
	{#State 11
		ACTIONS => {
			'ATOM' => 56,
			"{" => 57
		}
	},
	{#State 12
		DEFAULT => -20
	},
	{#State 13
		DEFAULT => -8
	},
	{#State 14
		ACTIONS => {
			"{" => 59,
			'ATOM' => 58
		}
	},
	{#State 15
		ACTIONS => {
			'INTEGER' => 60,
			"{" => 61
		}
	},
	{#State 16
		ACTIONS => {
			"\n" => 62
		}
	},
	{#State 17
		ACTIONS => {
			'INTEGER' => 64,
			"{" => 63
		}
	},
	{#State 18
		DEFAULT => -24
	},
	{#State 19
		DEFAULT => -6
	},
	{#State 20
		ACTIONS => {
			'INTEGER' => 66,
			"{" => 65
		}
	},
	{#State 21
		ACTIONS => {
			"\n" => 67
		}
	},
	{#State 22
		DEFAULT => -19
	},
	{#State 23
		DEFAULT => -7
	},
	{#State 24
		DEFAULT => -3
	},
	{#State 25
		ACTIONS => {
			"{" => 69,
			'FLAG' => 68
		}
	},
	{#State 26
		DEFAULT => -16
	},
	{#State 27
		DEFAULT => -25
	},
	{#State 28
		ACTIONS => {
			"\n" => 70
		}
	},
	{#State 29
		ACTIONS => {
			"{" => 71,
			'FLAG' => 72
		}
	},
	{#State 30
		ACTIONS => {
			"{" => 74,
			'FLAG' => 73
		}
	},
	{#State 31
		ACTIONS => {
			'DOUBLE' => 75,
			"{" => 76
		}
	},
	{#State 32
		DEFAULT => -18
	},
	{#State 33
		ACTIONS => {
			"\n" => 77
		}
	},
	{#State 34
		ACTIONS => {
			"{" => 79,
			'ATOM' => 78
		}
	},
	{#State 35
		DEFAULT => -12
	},
	{#State 36
		DEFAULT => 0
	},
	{#State 37
		DEFAULT => -2
	},
	{#State 38
		DEFAULT => -26
	},
	{#State 39
		ACTIONS => {
			"{" => 80,
			'ATOM' => 81
		}
	},
	{#State 40
		DEFAULT => -11
	},
	{#State 41
		DEFAULT => -5
	},
	{#State 42
		DEFAULT => -14
	},
	{#State 43
		ACTIONS => {
			'NONE' => 54,
			'ALL' => 52,
			'SOME' => 55,
			"{" => 82
		},
		GOTOS => {
			'punctlevel' => 83
		}
	},
	{#State 44
		DEFAULT => -17
	},
	{#State 45
		DEFAULT => -10
	},
	{#State 46
		ACTIONS => {
			'INTEGER' => 84,
			"{" => 85
		}
	},
	{#State 47
		DEFAULT => -46
	},
	{#State 48
		ACTIONS => {
			'CHAR' => 86
		}
	},
	{#State 49
		ACTIONS => {
			"\n" => 87
		}
	},
	{#State 50
		DEFAULT => -35
	},
	{#State 51
		ACTIONS => {
			'ALL' => 52,
			'NONE' => 54,
			'SOME' => 55
		},
		GOTOS => {
			'punctlevel' => 88
		}
	},
	{#State 52
		DEFAULT => -63
	},
	{#State 53
		ACTIONS => {
			'FLAG' => 89
		}
	},
	{#State 54
		DEFAULT => -61
	},
	{#State 55
		DEFAULT => -62
	},
	{#State 56
		ACTIONS => {
			"\n" => 90
		}
	},
	{#State 57
		ACTIONS => {
			'ATOM' => 91
		}
	},
	{#State 58
		ACTIONS => {
			"\n" => 92
		}
	},
	{#State 59
		ACTIONS => {
			'TEXT' => 93
		}
	},
	{#State 60
		ACTIONS => {
			"\n" => 94
		}
	},
	{#State 61
		ACTIONS => {
			'INTEGER' => 95
		}
	},
	{#State 62
		DEFAULT => -45
	},
	{#State 63
		ACTIONS => {
			'INTEGER' => 96
		}
	},
	{#State 64
		ACTIONS => {
			'INTEGER' => 97
		}
	},
	{#State 65
		ACTIONS => {
			'INTEGER' => 98
		}
	},
	{#State 66
		ACTIONS => {
			'INTEGER' => 99
		}
	},
	{#State 67
		DEFAULT => -33
	},
	{#State 68
		ACTIONS => {
			"\n" => 100
		}
	},
	{#State 69
		ACTIONS => {
			'FLAG' => 101
		}
	},
	{#State 70
		DEFAULT => -44
	},
	{#State 71
		ACTIONS => {
			'FLAG' => 102
		}
	},
	{#State 72
		ACTIONS => {
			"\n" => 103
		}
	},
	{#State 73
		ACTIONS => {
			"\n" => 104
		}
	},
	{#State 74
		ACTIONS => {
			'FLAG' => 105
		}
	},
	{#State 75
		ACTIONS => {
			"\n" => 106
		}
	},
	{#State 76
		ACTIONS => {
			'DOUBLE' => 107
		}
	},
	{#State 77
		DEFAULT => -34
	},
	{#State 78
		ACTIONS => {
			"\n" => 108
		}
	},
	{#State 79
		ACTIONS => {
			'TEXT' => 109
		}
	},
	{#State 80
		ACTIONS => {
			'CODE' => 110
		}
	},
	{#State 81
		ACTIONS => {
			"\n" => 111
		}
	},
	{#State 82
		ACTIONS => {
			'NONE' => 54,
			'ALL' => 52,
			'SOME' => 55
		},
		GOTOS => {
			'punctlevel' => 112
		}
	},
	{#State 83
		ACTIONS => {
			"\n" => 113
		}
	},
	{#State 84
		ACTIONS => {
			"\n" => 114
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
		DEFAULT => -30
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
		DEFAULT => -43
	},
	{#State 91
		ACTIONS => {
			"}" => 119
		}
	},
	{#State 92
		DEFAULT => -32
	},
	{#State 93
		ACTIONS => {
			"}" => 120
		}
	},
	{#State 94
		DEFAULT => -37
	},
	{#State 95
		ACTIONS => {
			"}" => 121
		}
	},
	{#State 96
		ACTIONS => {
			'INTEGER' => 122
		}
	},
	{#State 97
		ACTIONS => {
			"\n" => 123
		}
	},
	{#State 98
		ACTIONS => {
			'INTEGER' => 124
		}
	},
	{#State 99
		ACTIONS => {
			"\n" => 125
		}
	},
	{#State 100
		DEFAULT => -50
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
		DEFAULT => -48
	},
	{#State 104
		DEFAULT => -58
	},
	{#State 105
		ACTIONS => {
			"}" => 128
		}
	},
	{#State 106
		DEFAULT => -52
	},
	{#State 107
		ACTIONS => {
			"}" => 129
		}
	},
	{#State 108
		DEFAULT => -28
	},
	{#State 109
		ACTIONS => {
			"}" => 130
		}
	},
	{#State 110
		ACTIONS => {
			"}" => 131
		}
	},
	{#State 111
		DEFAULT => -23
	},
	{#State 112
		ACTIONS => {
			"}" => 132
		}
	},
	{#State 113
		DEFAULT => -54
	},
	{#State 114
		DEFAULT => -56
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
			"\n" => 138
		}
	},
	{#State 121
		ACTIONS => {
			"\n" => 139
		}
	},
	{#State 122
		ACTIONS => {
			"}" => 140
		}
	},
	{#State 123
		DEFAULT => -41
	},
	{#State 124
		ACTIONS => {
			"}" => 141
		}
	},
	{#State 125
		DEFAULT => -39
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
		DEFAULT => -29
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
		DEFAULT => -42
	},
	{#State 138
		DEFAULT => -31
	},
	{#State 139
		DEFAULT => -36
	},
	{#State 140
		ACTIONS => {
			"\n" => 152
		}
	},
	{#State 141
		ACTIONS => {
			"\n" => 153
		}
	},
	{#State 142
		DEFAULT => -49
	},
	{#State 143
		DEFAULT => -47
	},
	{#State 144
		DEFAULT => -57
	},
	{#State 145
		DEFAULT => -51
	},
	{#State 146
		DEFAULT => -27
	},
	{#State 147
		DEFAULT => -22
	},
	{#State 148
		DEFAULT => -53
	},
	{#State 149
		DEFAULT => -55
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
#line 68 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 4
		 'cmd', 1,
sub
#line 69 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 5
		 'cmd', 1,
sub
#line 71 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_d}};
					$_[1];
						}
	],
	[#Rule 6
		 'cmd', 1,
sub
#line 76 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_s}};
		$_[1];
		}
	],
	[#Rule 7
		 'cmd', 1,
sub
#line 81 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_version}};
			$_[1];
		}
	],
	[#Rule 8
		 'cmd', 1,
sub
#line 86 "../parser/parser.yp"
{ 
			&{$_[0]->YYData->{SA}->{tts_silence}}($_[1]);
$_[1];
		}
	],
	[#Rule 9
		 'cmd', 1,
sub
#line 90 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 10
		 'cmd', 1,
sub
#line 91 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 11
		 'cmd', 1,
sub
#line 92 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 12
		 'cmd', 1,
sub
#line 94 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_pause}};
			$_[1];
		}
	],
	[#Rule 13
		 'cmd', 1,
sub
#line 99 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_reset}};
			$_[1];
		}
	],
	[#Rule 14
		 'cmd', 1,
sub
#line 104 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_resume}};
			$_[1];
		}
	],
	[#Rule 15
		 'cmd', 1,
sub
#line 109 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_allcaps_beep}}($_[1]);
			$_[1];
		}
	],
	[#Rule 16
		 'cmd', 1,
sub
#line 114 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_capitalize}}($_[1]);
			$_[1];
		}
	],
	[#Rule 17
		 'cmd', 1,
sub
#line 119 "../parser/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 18
		 'cmd', 1,
sub
#line 123 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_set_punctuations}}($_[1]);
			$_[1];
		}
	],
	[#Rule 19
		 'cmd', 1,
sub
#line 128 "../parser/parser.yp"
{ 
			&{$_[0]->YYData->{SA}->{tts_set_speech_rate}}($_[1]);
				$_[1];		
		}
	],
	[#Rule 20
		 'cmd', 1,
sub
#line 133 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_split_caps}}($_[1]);
			$_[1];
		}
	],
	[#Rule 21
		 'cmd', 1,
sub
#line 138 "../parser/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 22
		 'code', 5,
sub
#line 145 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_c}}($_[3]);
			$_[1];
		}
	],
	[#Rule 23
		 'code', 3,
sub
#line 150 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_c}}($_[2]);
			$_[1];
		}
	],
	[#Rule 24
		 'speech', 1,
sub
#line 157 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 25
		 'speech', 1,
sub
#line 158 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 26
		 'speech', 1,
sub
#line 159 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 27
		 'immediate_speech', 5,
sub
#line 164 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_say}}($_[3]);
			$_[1];
		}
	],
	[#Rule 28
		 'immediate_speech', 3,
sub
#line 169 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_say}}($_[2]);
			$_[1];
		}
	],
	[#Rule 29
		 'character', 5,
sub
#line 177 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_l}}($_[3]);
			$_[1];
		}
	],
	[#Rule 30
		 'character', 3,
sub
#line 182 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_l}}($_[2]);
			$_[1];
		}
	],
	[#Rule 31
		 'queued_speech', 5,
sub
#line 190 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_q}}($_[3]);
			$_[1];
		}
	],
	[#Rule 32
		 'queued_speech', 3,
sub
#line 195 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_q}}($_[2]);
			$_[1];
		}
	],
	[#Rule 33
		 'dispatch', 2,
sub
#line 202 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 34
		 'version', 2,
sub
#line 206 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 35
		 'stop', 2,
sub
#line 210 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 36
		 'silence', 5,
sub
#line 215 "../parser/parser.yp"
{
			$_[3];
		}
	],
	[#Rule 37
		 'silence', 3,
sub
#line 219 "../parser/parser.yp"
{
			$_[2];
		}
	],
	[#Rule 38
		 'beep', 6,
sub
#line 226 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_b}}($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 39
		 'beep', 4,
sub
#line 231 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_b}}($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 40
		 'tone', 6,
sub
#line 239 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_t}}($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 41
		 'tone', 4,
sub
#line 244 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_t}}($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 42
		 'sound', 5,
sub
#line 252 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_a}}($_[3]);
			$_[1];
		}
	],
	[#Rule 43
		 'sound', 3,
sub
#line 257 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_a}}($_[2]);
			$_[1];
		}
	],
	[#Rule 44
		 'tts_pause', 2,
sub
#line 264 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 45
		 'tts_reset', 2,
sub
#line 268 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 46
		 'tts_resume', 2,
sub
#line 272 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 47
		 'tts_allcaps_beep', 5,
sub
#line 276 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 48
		 'tts_allcaps_beep', 3,
sub
#line 277 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 49
		 'tts_capitalize', 5,
sub
#line 281 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 50
		 'tts_capitalize', 3,
sub
#line 282 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 51
		 'tts_set_character_scale', 5,
sub
#line 287 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_set_character_scale}}($_[3]);
			$_[1];
		}
	],
	[#Rule 52
		 'tts_set_character_scale', 3,
sub
#line 292 "../parser/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_set_character_scale}}($_[2]);
			$_[1];
		}
	],
	[#Rule 53
		 'tts_set_punctuations', 5,
sub
#line 299 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 54
		 'tts_set_punctuations', 3,
sub
#line 300 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 55
		 'tts_set_speech_rate', 5,
sub
#line 304 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 56
		 'tts_set_speech_rate', 3,
sub
#line 305 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 57
		 'tts_split_caps', 5,
sub
#line 309 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 58
		 'tts_split_caps', 3,
sub
#line 310 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 59
		 'tts_sync_state', 9,
sub
#line 315 "../parser/parser.yp"
{ 
			&{$_[0]->YYData->{SA}->{tts_sync_state}}($_[3], $_[4], $_[5], $_[6], $_[7]);
			$_[1];
		}
	],
	[#Rule 60
		 'tts_sync_state', 7,
sub
#line 320 "../parser/parser.yp"
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

#line 332 "../parser/parser.yp"


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
	
	# Eat white space
    $parser->YYData->{INPUT} =~ s/^[ \t]+//;

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

		# Parse atom (string with no spaces) for q and tts_say
		if ($parser->YYData->{STATE} & X_SPEECH ) {
			s/^([^ {}\n]+)//
			and do {
				print "About to return ATOM\n" if $debug;
				$parser->YYData->{STATE} = X_INITIAL;
				return('ATOM',$1);
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
