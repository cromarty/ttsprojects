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
			"L" => 39,
			"Q" => 14,
			'TTS_RESUME' => 40,
			'TTS_SET_SPEECH_RATE' => 42,
			'TTS_SPLIT_CAPS' => 20,
			"C" => 45,
			'TTS_ALLCAPS_BEEP' => 24,
			"s" => 25,
			"a" => 5,
			'TTS_SAY' => 26,
			'' => 27,
			"b" => 3,
			"d" => 30,
			"t" => 7,
			'TTS_CAPITALIZE' => 31,
			'VERSION' => 36,
			'TTS_RESET' => 34,
			'TTS_SET_CHARACTER_SCALE' => 35,
			'TTS_PAUSE' => 10,
			'TTS_SET_PUNCTUATIONS' => 9,
			'SH' => 12,
			'TTS_SYNC_STATE' => 13
		},
		GOTOS => {
			'tts_capitalize' => 23,
			'tts_allcaps_beep' => 46,
			'tone' => 21,
			'character' => 22,
			'version' => 41,
			'cmd' => 17,
			'queued_speech' => 18,
			'tts_pause' => 43,
			'tts_split_caps' => 19,
			'tts_set_speech_rate' => 44,
			'tts_reset' => 16,
			'stop' => 15,
			'silence' => 38,
			'beep' => 33,
			'dispatch' => 32,
			'sound' => 37,
			'speech' => 11,
			'tts_sync_state' => 6,
			'tts_set_punctuations' => 8,
			'tts_set_character_scale' => 2,
			'tts_resume' => 29,
			'code' => 28,
			'immediate_speech' => 4
		}
	},
	{#State 2
		DEFAULT => -17
	},
	{#State 3
		ACTIONS => {
			'INTEGER' => 47,
			"{" => 48
		}
	},
	{#State 4
		DEFAULT => -24
	},
	{#State 5
		ACTIONS => {
			'TEXT' => 49,
			"{" => 50
		}
	},
	{#State 6
		DEFAULT => -21
	},
	{#State 7
		ACTIONS => {
			"{" => 51,
			'INTEGER' => 52
		}
	},
	{#State 8
		DEFAULT => -18
	},
	{#State 9
		ACTIONS => {
			'PUNCTLEVEL' => 54,
			"{" => 53
		}
	},
	{#State 10
		ACTIONS => {
			"\n" => 55
		}
	},
	{#State 11
		DEFAULT => -4
	},
	{#State 12
		ACTIONS => {
			'INTEGER' => 57,
			"{" => 56
		}
	},
	{#State 13
		ACTIONS => {
			'SOME' => 62,
			'NONE' => 61,
			'ALL' => 59,
			"{" => 58
		},
		GOTOS => {
			'punctlevel' => 60
		}
	},
	{#State 14
		ACTIONS => {
			'TEXT' => 63,
			"{" => 64
		}
	},
	{#State 15
		DEFAULT => -6
	},
	{#State 16
		DEFAULT => -13
	},
	{#State 17
		DEFAULT => -2
	},
	{#State 18
		DEFAULT => -25
	},
	{#State 19
		DEFAULT => -20
	},
	{#State 20
		ACTIONS => {
			'FLAG' => 65,
			"{" => 66
		}
	},
	{#State 21
		DEFAULT => -10
	},
	{#State 22
		DEFAULT => -26
	},
	{#State 23
		DEFAULT => -16
	},
	{#State 24
		ACTIONS => {
			"{" => 68,
			'FLAG' => 67
		}
	},
	{#State 25
		ACTIONS => {
			"\n" => 69
		}
	},
	{#State 26
		ACTIONS => {
			'TEXT' => 71,
			"{" => 70
		}
	},
	{#State 27
		DEFAULT => 0
	},
	{#State 28
		DEFAULT => -3
	},
	{#State 29
		DEFAULT => -14
	},
	{#State 30
		ACTIONS => {
			"\n" => 72
		}
	},
	{#State 31
		ACTIONS => {
			'FLAG' => 73,
			"{" => 74
		}
	},
	{#State 32
		DEFAULT => -5
	},
	{#State 33
		DEFAULT => -9
	},
	{#State 34
		ACTIONS => {
			"\n" => 75
		}
	},
	{#State 35
		ACTIONS => {
			'DOUBLE' => 77,
			"{" => 76
		}
	},
	{#State 36
		ACTIONS => {
			"\n" => 78
		}
	},
	{#State 37
		DEFAULT => -11
	},
	{#State 38
		DEFAULT => -8
	},
	{#State 39
		ACTIONS => {
			"{" => 79,
			'CHAR' => 80
		}
	},
	{#State 40
		ACTIONS => {
			"\n" => 81
		}
	},
	{#State 41
		DEFAULT => -7
	},
	{#State 42
		ACTIONS => {
			"{" => 83,
			'INTEGER' => 82
		}
	},
	{#State 43
		DEFAULT => -12
	},
	{#State 44
		DEFAULT => -19
	},
	{#State 45
		ACTIONS => {
			"{" => 85,
			'TEXT' => 84
		}
	},
	{#State 46
		DEFAULT => -15
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
			'TEXT' => 89
		}
	},
	{#State 51
		ACTIONS => {
			'INTEGER' => 90
		}
	},
	{#State 52
		ACTIONS => {
			'INTEGER' => 91
		}
	},
	{#State 53
		ACTIONS => {
			'PUNCTLEVEL' => 92
		}
	},
	{#State 54
		ACTIONS => {
			"\n" => 93
		}
	},
	{#State 55
		DEFAULT => -44
	},
	{#State 56
		ACTIONS => {
			'INTEGER' => 94
		}
	},
	{#State 57
		ACTIONS => {
			"\n" => 95
		}
	},
	{#State 58
		ACTIONS => {
			'SOME' => 62,
			'ALL' => 59,
			'NONE' => 61
		},
		GOTOS => {
			'punctlevel' => 96
		}
	},
	{#State 59
		DEFAULT => -63
	},
	{#State 60
		ACTIONS => {
			'FLAG' => 97
		}
	},
	{#State 61
		DEFAULT => -61
	},
	{#State 62
		DEFAULT => -62
	},
	{#State 63
		ACTIONS => {
			"\n" => 98
		}
	},
	{#State 64
		ACTIONS => {
			'TEXT' => 99
		}
	},
	{#State 65
		ACTIONS => {
			"\n" => 100
		}
	},
	{#State 66
		ACTIONS => {
			'FLAG' => 101
		}
	},
	{#State 67
		ACTIONS => {
			"\n" => 102
		}
	},
	{#State 68
		ACTIONS => {
			'FLAG' => 103
		}
	},
	{#State 69
		DEFAULT => -35
	},
	{#State 70
		ACTIONS => {
			'TEXT' => 104
		}
	},
	{#State 71
		ACTIONS => {
			"\n" => 105
		}
	},
	{#State 72
		DEFAULT => -33
	},
	{#State 73
		ACTIONS => {
			"\n" => 106
		}
	},
	{#State 74
		ACTIONS => {
			'FLAG' => 107
		}
	},
	{#State 75
		DEFAULT => -45
	},
	{#State 76
		ACTIONS => {
			'DOUBLE' => 108
		}
	},
	{#State 77
		ACTIONS => {
			"\n" => 109
		}
	},
	{#State 78
		DEFAULT => -34
	},
	{#State 79
		ACTIONS => {
			'CHAR' => 110
		}
	},
	{#State 80
		ACTIONS => {
			"\n" => 111
		}
	},
	{#State 81
		DEFAULT => -46
	},
	{#State 82
		ACTIONS => {
			"\n" => 112
		}
	},
	{#State 83
		ACTIONS => {
			'INTEGER' => 113
		}
	},
	{#State 84
		ACTIONS => {
			"\n" => 114
		}
	},
	{#State 85
		ACTIONS => {
			'TEXT' => 115
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
		DEFAULT => -43
	},
	{#State 89
		ACTIONS => {
			"}" => 118
		}
	},
	{#State 90
		ACTIONS => {
			'INTEGER' => 119
		}
	},
	{#State 91
		ACTIONS => {
			"\n" => 120
		}
	},
	{#State 92
		ACTIONS => {
			"}" => 121
		}
	},
	{#State 93
		DEFAULT => -54
	},
	{#State 94
		ACTIONS => {
			"}" => 122
		}
	},
	{#State 95
		DEFAULT => -37
	},
	{#State 96
		ACTIONS => {
			'FLAG' => 123
		}
	},
	{#State 97
		ACTIONS => {
			'FLAG' => 124
		}
	},
	{#State 98
		DEFAULT => -32
	},
	{#State 99
		ACTIONS => {
			"}" => 125
		}
	},
	{#State 100
		DEFAULT => -58
	},
	{#State 101
		ACTIONS => {
			"}" => 126
		}
	},
	{#State 102
		DEFAULT => -48
	},
	{#State 103
		ACTIONS => {
			"}" => 127
		}
	},
	{#State 104
		ACTIONS => {
			"}" => 128
		}
	},
	{#State 105
		DEFAULT => -28
	},
	{#State 106
		DEFAULT => -50
	},
	{#State 107
		ACTIONS => {
			"}" => 129
		}
	},
	{#State 108
		ACTIONS => {
			"}" => 130
		}
	},
	{#State 109
		DEFAULT => -52
	},
	{#State 110
		ACTIONS => {
			"}" => 131
		}
	},
	{#State 111
		DEFAULT => -30
	},
	{#State 112
		DEFAULT => -56
	},
	{#State 113
		ACTIONS => {
			"}" => 132
		}
	},
	{#State 114
		DEFAULT => -23
	},
	{#State 115
		ACTIONS => {
			"}" => 133
		}
	},
	{#State 116
		DEFAULT => -39
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
			"}" => 136
		}
	},
	{#State 120
		DEFAULT => -41
	},
	{#State 121
		ACTIONS => {
			"\n" => 137
		}
	},
	{#State 122
		ACTIONS => {
			"\n" => 138
		}
	},
	{#State 123
		ACTIONS => {
			'FLAG' => 139
		}
	},
	{#State 124
		ACTIONS => {
			'FLAG' => 140
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
		DEFAULT => -42
	},
	{#State 136
		ACTIONS => {
			"\n" => 151
		}
	},
	{#State 137
		DEFAULT => -53
	},
	{#State 138
		DEFAULT => -36
	},
	{#State 139
		ACTIONS => {
			'FLAG' => 152
		}
	},
	{#State 140
		ACTIONS => {
			'INTEGER' => 153
		}
	},
	{#State 141
		DEFAULT => -31
	},
	{#State 142
		DEFAULT => -57
	},
	{#State 143
		DEFAULT => -47
	},
	{#State 144
		DEFAULT => -27
	},
	{#State 145
		DEFAULT => -49
	},
	{#State 146
		DEFAULT => -51
	},
	{#State 147
		DEFAULT => -29
	},
	{#State 148
		DEFAULT => -55
	},
	{#State 149
		DEFAULT => -22
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
		and do {
			return('PUNCTLEVEL',{'none'=>0,'some'=>1,'all'=>2}->{$1});
		};


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
