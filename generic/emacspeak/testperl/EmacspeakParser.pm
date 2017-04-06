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

#line 26 "../parser/perl/parser.yp"


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
			"q" => 41,
			"b" => 16,
			"a" => 12,
			'TTS_SET_CHARACTER_SCALE' => 14,
			'TTS_CAPITALIZE' => 13,
			'TTS_RESUME' => 24,
			"d" => 25,
			'TTS_SET_SPEECH_RATE' => 43,
			'TTS_SPLIT_CAPS' => 19,
			"s" => 23,
			'TTS_SYNC_STATE' => 29,
			"c" => 6,
			"t" => 5,
			'TTS_SET_PUNCTUATIONS' => 26,
			'TTS_PAUSE' => 3,
			'TTS_RESET' => 35,
			'TTS_ALLCAPS_BEEP' => 8,
			'' => 34,
			"l" => 10,
			'SH' => 36,
			'VERSION' => 9,
			'TTS_SAY' => 30
		},
		GOTOS => {
			'tts_sync_state' => 27,
			'character' => 2,
			'tts_reset' => 4,
			'tts_split_caps' => 28,
			'tts_set_speech_rate' => 38,
			'speech' => 37,
			'cmd' => 31,
			'tts_set_character_scale' => 33,
			'immediate_speech' => 7,
			'tts_capitalize' => 32,
			'stop' => 40,
			'code' => 15,
			'silence' => 42,
			'queued_speech' => 11,
			'beep' => 39,
			'dispatch' => 44,
			'tts_allcaps_beep' => 45,
			'tts_set_punctuations' => 46,
			'tts_resume' => 18,
			'tts_pause' => 17,
			'tone' => 20,
			'sound' => 22,
			'version' => 21
		}
	},
	{#State 2
		DEFAULT => -26
	},
	{#State 3
		ACTIONS => {
			"\n" => 47
		}
	},
	{#State 4
		DEFAULT => -13
	},
	{#State 5
		ACTIONS => {
			"{" => 49,
			'INTEGER' => 48
		}
	},
	{#State 6
		ACTIONS => {
			"{" => 50,
			'ATOM' => 51
		}
	},
	{#State 7
		DEFAULT => -24
	},
	{#State 8
		ACTIONS => {
			'FLAG' => 53,
			"{" => 52
		}
	},
	{#State 9
		ACTIONS => {
			"\n" => 54
		}
	},
	{#State 10
		ACTIONS => {
			"{" => 55,
			'CHAR' => 56
		}
	},
	{#State 11
		DEFAULT => -25
	},
	{#State 12
		ACTIONS => {
			'ATOM' => 58,
			"{" => 57
		}
	},
	{#State 13
		ACTIONS => {
			'FLAG' => 60,
			"{" => 59
		}
	},
	{#State 14
		ACTIONS => {
			'DOUBLE' => 62,
			"{" => 61
		}
	},
	{#State 15
		DEFAULT => -3
	},
	{#State 16
		ACTIONS => {
			'INTEGER' => 64,
			"{" => 63
		}
	},
	{#State 17
		DEFAULT => -12
	},
	{#State 18
		DEFAULT => -14
	},
	{#State 19
		ACTIONS => {
			"{" => 65,
			'FLAG' => 66
		}
	},
	{#State 20
		DEFAULT => -10
	},
	{#State 21
		DEFAULT => -7
	},
	{#State 22
		DEFAULT => -11
	},
	{#State 23
		ACTIONS => {
			"\n" => 67
		}
	},
	{#State 24
		ACTIONS => {
			"\n" => 68
		}
	},
	{#State 25
		ACTIONS => {
			"\n" => 69
		}
	},
	{#State 26
		ACTIONS => {
			"{" => 73,
			'NONE' => 70,
			'SOME' => 71,
			'ALL' => 74
		},
		GOTOS => {
			'punctlevel' => 72
		}
	},
	{#State 27
		DEFAULT => -21
	},
	{#State 28
		DEFAULT => -20
	},
	{#State 29
		ACTIONS => {
			'ALL' => 74,
			'SOME' => 71,
			"{" => 75,
			'NONE' => 70
		},
		GOTOS => {
			'punctlevel' => 76
		}
	},
	{#State 30
		ACTIONS => {
			'ATOM' => 78,
			"{" => 77
		}
	},
	{#State 31
		DEFAULT => -2
	},
	{#State 32
		DEFAULT => -16
	},
	{#State 33
		DEFAULT => -17
	},
	{#State 34
		DEFAULT => 0
	},
	{#State 35
		ACTIONS => {
			"\n" => 79
		}
	},
	{#State 36
		ACTIONS => {
			'INTEGER' => 80,
			"{" => 81
		}
	},
	{#State 37
		DEFAULT => -4
	},
	{#State 38
		DEFAULT => -19
	},
	{#State 39
		DEFAULT => -9
	},
	{#State 40
		DEFAULT => -6
	},
	{#State 41
		ACTIONS => {
			'ATOM' => 82,
			"{" => 83
		}
	},
	{#State 42
		DEFAULT => -8
	},
	{#State 43
		ACTIONS => {
			'INTEGER' => 85,
			"{" => 84
		}
	},
	{#State 44
		DEFAULT => -5
	},
	{#State 45
		DEFAULT => -15
	},
	{#State 46
		DEFAULT => -18
	},
	{#State 47
		DEFAULT => -44
	},
	{#State 48
		ACTIONS => {
			'INTEGER' => 86
		}
	},
	{#State 49
		ACTIONS => {
			'INTEGER' => 87
		}
	},
	{#State 50
		ACTIONS => {
			'CODE' => 88
		}
	},
	{#State 51
		ACTIONS => {
			"\n" => 89
		}
	},
	{#State 52
		ACTIONS => {
			'FLAG' => 90
		}
	},
	{#State 53
		ACTIONS => {
			"\n" => 91
		}
	},
	{#State 54
		DEFAULT => -34
	},
	{#State 55
		ACTIONS => {
			'CHAR' => 92
		}
	},
	{#State 56
		ACTIONS => {
			"\n" => 93
		}
	},
	{#State 57
		ACTIONS => {
			'ATOM' => 94
		}
	},
	{#State 58
		ACTIONS => {
			"\n" => 95
		}
	},
	{#State 59
		ACTIONS => {
			'FLAG' => 96
		}
	},
	{#State 60
		ACTIONS => {
			"\n" => 97
		}
	},
	{#State 61
		ACTIONS => {
			'DOUBLE' => 98
		}
	},
	{#State 62
		ACTIONS => {
			"\n" => 99
		}
	},
	{#State 63
		ACTIONS => {
			'INTEGER' => 100
		}
	},
	{#State 64
		ACTIONS => {
			'INTEGER' => 101
		}
	},
	{#State 65
		ACTIONS => {
			'FLAG' => 102
		}
	},
	{#State 66
		ACTIONS => {
			"\n" => 103
		}
	},
	{#State 67
		DEFAULT => -35
	},
	{#State 68
		DEFAULT => -46
	},
	{#State 69
		DEFAULT => -33
	},
	{#State 70
		DEFAULT => -61
	},
	{#State 71
		DEFAULT => -62
	},
	{#State 72
		ACTIONS => {
			"\n" => 104
		}
	},
	{#State 73
		ACTIONS => {
			'ALL' => 74,
			'NONE' => 70,
			'SOME' => 71
		},
		GOTOS => {
			'punctlevel' => 105
		}
	},
	{#State 74
		DEFAULT => -63
	},
	{#State 75
		ACTIONS => {
			'ALL' => 74,
			'SOME' => 71,
			'NONE' => 70
		},
		GOTOS => {
			'punctlevel' => 106
		}
	},
	{#State 76
		ACTIONS => {
			'FLAG' => 107
		}
	},
	{#State 77
		ACTIONS => {
			'TEXT' => 108
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
			"\n" => 110
		}
	},
	{#State 81
		ACTIONS => {
			'INTEGER' => 111
		}
	},
	{#State 82
		ACTIONS => {
			"\n" => 112
		}
	},
	{#State 83
		ACTIONS => {
			'TEXT' => 113
		}
	},
	{#State 84
		ACTIONS => {
			'INTEGER' => 114
		}
	},
	{#State 85
		ACTIONS => {
			"\n" => 115
		}
	},
	{#State 86
		ACTIONS => {
			"\n" => 116
		}
	},
	{#State 87
		ACTIONS => {
			'INTEGER' => 117
		}
	},
	{#State 88
		ACTIONS => {
			"}" => 118
		}
	},
	{#State 89
		DEFAULT => -23
	},
	{#State 90
		ACTIONS => {
			"}" => 119
		}
	},
	{#State 91
		DEFAULT => -48
	},
	{#State 92
		ACTIONS => {
			"}" => 120
		}
	},
	{#State 93
		DEFAULT => -30
	},
	{#State 94
		ACTIONS => {
			"}" => 121
		}
	},
	{#State 95
		DEFAULT => -43
	},
	{#State 96
		ACTIONS => {
			"}" => 122
		}
	},
	{#State 97
		DEFAULT => -50
	},
	{#State 98
		ACTIONS => {
			"}" => 123
		}
	},
	{#State 99
		DEFAULT => -52
	},
	{#State 100
		ACTIONS => {
			'INTEGER' => 124
		}
	},
	{#State 101
		ACTIONS => {
			"\n" => 125
		}
	},
	{#State 102
		ACTIONS => {
			"}" => 126
		}
	},
	{#State 103
		DEFAULT => -58
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
			'FLAG' => 128
		}
	},
	{#State 107
		ACTIONS => {
			'FLAG' => 129
		}
	},
	{#State 108
		ACTIONS => {
			"}" => 130
		}
	},
	{#State 109
		DEFAULT => -28
	},
	{#State 110
		DEFAULT => -37
	},
	{#State 111
		ACTIONS => {
			"}" => 131
		}
	},
	{#State 112
		DEFAULT => -32
	},
	{#State 113
		ACTIONS => {
			"}" => 132
		}
	},
	{#State 114
		ACTIONS => {
			"}" => 133
		}
	},
	{#State 115
		DEFAULT => -56
	},
	{#State 116
		DEFAULT => -41
	},
	{#State 117
		ACTIONS => {
			"}" => 134
		}
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
			'FLAG' => 144
		}
	},
	{#State 129
		ACTIONS => {
			'FLAG' => 145
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
		ACTIONS => {
			"\n" => 150
		}
	},
	{#State 135
		DEFAULT => -22
	},
	{#State 136
		DEFAULT => -47
	},
	{#State 137
		DEFAULT => -29
	},
	{#State 138
		DEFAULT => -42
	},
	{#State 139
		DEFAULT => -49
	},
	{#State 140
		DEFAULT => -51
	},
	{#State 141
		ACTIONS => {
			"\n" => 151
		}
	},
	{#State 142
		DEFAULT => -57
	},
	{#State 143
		DEFAULT => -53
	},
	{#State 144
		ACTIONS => {
			'FLAG' => 152
		}
	},
	{#State 145
		ACTIONS => {
			'INTEGER' => 153
		}
	},
	{#State 146
		DEFAULT => -27
	},
	{#State 147
		DEFAULT => -36
	},
	{#State 148
		DEFAULT => -31
	},
	{#State 149
		DEFAULT => -55
	},
	{#State 150
		DEFAULT => -40
	},
	{#State 151
		DEFAULT => -38
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
#line 68 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 4
		 'cmd', 1,
sub
#line 69 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 5
		 'cmd', 1,
sub
#line 71 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_d}};
					$_[1];
						}
	],
	[#Rule 6
		 'cmd', 1,
sub
#line 76 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_s}};
		$_[1];
		}
	],
	[#Rule 7
		 'cmd', 1,
sub
#line 81 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_version}};
			$_[1];
		}
	],
	[#Rule 8
		 'cmd', 1,
sub
#line 86 "../parser/perl/parser.yp"
{ 
			&{$_[0]->YYData->{SA}->{tts_silence}}($_[1]);
$_[1];
		}
	],
	[#Rule 9
		 'cmd', 1,
sub
#line 90 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 10
		 'cmd', 1,
sub
#line 91 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 11
		 'cmd', 1,
sub
#line 92 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 12
		 'cmd', 1,
sub
#line 94 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_pause}};
			$_[1];
		}
	],
	[#Rule 13
		 'cmd', 1,
sub
#line 99 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_reset}};
			$_[1];
		}
	],
	[#Rule 14
		 'cmd', 1,
sub
#line 104 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_resume}};
			$_[1];
		}
	],
	[#Rule 15
		 'cmd', 1,
sub
#line 109 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_allcaps_beep}}($_[1]);
			$_[1];
		}
	],
	[#Rule 16
		 'cmd', 1,
sub
#line 114 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_capitalize}}($_[1]);
			$_[1];
		}
	],
	[#Rule 17
		 'cmd', 1,
sub
#line 119 "../parser/perl/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 18
		 'cmd', 1,
sub
#line 123 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_set_punctuations}}($_[1]);
			$_[1];
		}
	],
	[#Rule 19
		 'cmd', 1,
sub
#line 128 "../parser/perl/parser.yp"
{ 
			&{$_[0]->YYData->{SA}->{tts_set_speech_rate}}($_[1]);
				$_[1];		
		}
	],
	[#Rule 20
		 'cmd', 1,
sub
#line 133 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_split_caps}}($_[1]);
			$_[1];
		}
	],
	[#Rule 21
		 'cmd', 1,
sub
#line 138 "../parser/perl/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 22
		 'code', 5,
sub
#line 145 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_c}}($_[3]);
			$_[1];
		}
	],
	[#Rule 23
		 'code', 3,
sub
#line 150 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_c}}($_[2]);
			$_[1];
		}
	],
	[#Rule 24
		 'speech', 1,
sub
#line 157 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 25
		 'speech', 1,
sub
#line 158 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 26
		 'speech', 1,
sub
#line 159 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 27
		 'immediate_speech', 5,
sub
#line 164 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_say}}($_[3]);
			$_[1];
		}
	],
	[#Rule 28
		 'immediate_speech', 3,
sub
#line 169 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_say}}($_[2]);
			$_[1];
		}
	],
	[#Rule 29
		 'character', 5,
sub
#line 177 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_l}}($_[3]);
			$_[1];
		}
	],
	[#Rule 30
		 'character', 3,
sub
#line 182 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_l}}($_[2]);
			$_[1];
		}
	],
	[#Rule 31
		 'queued_speech', 5,
sub
#line 190 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_q}}($_[3]);
			$_[1];
		}
	],
	[#Rule 32
		 'queued_speech', 3,
sub
#line 195 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_q}}($_[2]);
			$_[1];
		}
	],
	[#Rule 33
		 'dispatch', 2,
sub
#line 202 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 34
		 'version', 2,
sub
#line 206 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 35
		 'stop', 2,
sub
#line 210 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 36
		 'silence', 5,
sub
#line 215 "../parser/perl/parser.yp"
{
			$_[3];
		}
	],
	[#Rule 37
		 'silence', 3,
sub
#line 219 "../parser/perl/parser.yp"
{
			$_[2];
		}
	],
	[#Rule 38
		 'beep', 6,
sub
#line 226 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_b}}($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 39
		 'beep', 4,
sub
#line 231 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_b}}($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 40
		 'tone', 6,
sub
#line 239 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_t}}($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 41
		 'tone', 4,
sub
#line 244 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_t}}($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 42
		 'sound', 5,
sub
#line 252 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_a}}($_[3]);
			$_[1];
		}
	],
	[#Rule 43
		 'sound', 3,
sub
#line 257 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_a}}($_[2]);
			$_[1];
		}
	],
	[#Rule 44
		 'tts_pause', 2,
sub
#line 264 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 45
		 'tts_reset', 2,
sub
#line 268 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 46
		 'tts_resume', 2,
sub
#line 272 "../parser/perl/parser.yp"
{ $_[1]; }
	],
	[#Rule 47
		 'tts_allcaps_beep', 5,
sub
#line 276 "../parser/perl/parser.yp"
{ $_[3]; }
	],
	[#Rule 48
		 'tts_allcaps_beep', 3,
sub
#line 277 "../parser/perl/parser.yp"
{ $_[2]; }
	],
	[#Rule 49
		 'tts_capitalize', 5,
sub
#line 281 "../parser/perl/parser.yp"
{ $_[3]; }
	],
	[#Rule 50
		 'tts_capitalize', 3,
sub
#line 282 "../parser/perl/parser.yp"
{ $_[2]; }
	],
	[#Rule 51
		 'tts_set_character_scale', 5,
sub
#line 287 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_set_character_scale}}($_[3]);
			$_[1];
		}
	],
	[#Rule 52
		 'tts_set_character_scale', 3,
sub
#line 292 "../parser/perl/parser.yp"
{
			&{$_[0]->YYData->{SA}->{tts_set_character_scale}}($_[2]);
			$_[1];
		}
	],
	[#Rule 53
		 'tts_set_punctuations', 5,
sub
#line 299 "../parser/perl/parser.yp"
{ $_[3]; }
	],
	[#Rule 54
		 'tts_set_punctuations', 3,
sub
#line 300 "../parser/perl/parser.yp"
{ $_[2]; }
	],
	[#Rule 55
		 'tts_set_speech_rate', 5,
sub
#line 304 "../parser/perl/parser.yp"
{ $_[3]; }
	],
	[#Rule 56
		 'tts_set_speech_rate', 3,
sub
#line 305 "../parser/perl/parser.yp"
{ $_[2]; }
	],
	[#Rule 57
		 'tts_split_caps', 5,
sub
#line 309 "../parser/perl/parser.yp"
{ $_[3]; }
	],
	[#Rule 58
		 'tts_split_caps', 3,
sub
#line 310 "../parser/perl/parser.yp"
{ $_[2]; }
	],
	[#Rule 59
		 'tts_sync_state', 9,
sub
#line 315 "../parser/perl/parser.yp"
{ 
			&{$_[0]->YYData->{SA}->{tts_sync_state}}($_[3], $_[4], $_[5], $_[6], $_[7]);
			$_[1];
		}
	],
	[#Rule 60
		 'tts_sync_state', 7,
sub
#line 320 "../parser/perl/parser.yp"
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

#line 332 "../parser/perl/parser.yp"


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
