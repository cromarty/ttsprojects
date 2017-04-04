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


# These constants are used as conditions, a-la %x in Yacc.
use constant X_START			=> 0;
use constant X_SPEECH			=> 1;
use constant X_INBRACES			=> 2;

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
			"Q" => 45,
			'TTS_RESET' => 44,
			'TTS_SAY' => 25,
			"a" => 26,
			'TTS_PAUSE' => 19,
			'TTS_ALLCAPS_BEEP' => 17,
			'' => 14,
			'TTS_SET_SPEECH_RATE' => 15,
			'TTS_SPLIT_CAPS' => 38,
			"C" => 36,
			"d" => 37,
			"t" => 10,
			'TTS_RESUME' => 35,
			"L" => 34,
			'TTS_SET_CHARACTER_SCALE' => 31,
			'VERSION' => 8,
			"s" => 30,
			'SH' => 29,
			'TTS_CAPITALIZE' => 7,
			"b" => 4,
			'TTS_SYNC_STATE' => 28,
			'TTS_SET_PUNCTUATIONS' => 2
		},
		GOTOS => {
			'tts_set_character_scale' => 18,
			'beep' => 42,
			'code' => 40,
			'tts_resume' => 16,
			'stop' => 41,
			'queued_speech' => 13,
			'silence' => 12,
			'tts_split_caps' => 39,
			'tts_capitalize' => 27,
			'sound' => 46,
			'tts_pause' => 24,
			'version' => 43,
			'tts_sync_state' => 20,
			'speech' => 23,
			'dispatch' => 22,
			'cmd' => 21,
			'character' => 3,
			'tts_reset' => 11,
			'immediate_speech' => 32,
			'tts_allcaps_beep' => 9,
			'tts_set_punctuations' => 33,
			'tone' => 6,
			'tts_set_speech_rate' => 5
		}
	},
	{#State 2
		ACTIONS => {
			"{" => 47,
			'PUNCTLEVEL' => 48
		}
	},
	{#State 3
		DEFAULT => -26
	},
	{#State 4
		ACTIONS => {
			"{" => 49,
			'INTEGER' => 50
		}
	},
	{#State 5
		DEFAULT => -19
	},
	{#State 6
		DEFAULT => -10
	},
	{#State 7
		ACTIONS => {
			"{" => 52,
			'FLAG' => 51
		}
	},
	{#State 8
		ACTIONS => {
			"\n" => 53
		}
	},
	{#State 9
		DEFAULT => -15
	},
	{#State 10
		ACTIONS => {
			"{" => 55,
			'INTEGER' => 54
		}
	},
	{#State 11
		DEFAULT => -13
	},
	{#State 12
		DEFAULT => -8
	},
	{#State 13
		DEFAULT => -25
	},
	{#State 14
		DEFAULT => 0
	},
	{#State 15
		ACTIONS => {
			'INTEGER' => 56,
			"{" => 57
		}
	},
	{#State 16
		DEFAULT => -14
	},
	{#State 17
		ACTIONS => {
			'FLAG' => 58,
			"{" => 59
		}
	},
	{#State 18
		DEFAULT => -17
	},
	{#State 19
		ACTIONS => {
			"\n" => 60
		}
	},
	{#State 20
		DEFAULT => -21
	},
	{#State 21
		DEFAULT => -2
	},
	{#State 22
		DEFAULT => -5
	},
	{#State 23
		DEFAULT => -4
	},
	{#State 24
		DEFAULT => -12
	},
	{#State 25
		ACTIONS => {
			'TEXT' => 61,
			"{" => 62
		}
	},
	{#State 26
		ACTIONS => {
			'TEXT' => 64,
			"{" => 63
		}
	},
	{#State 27
		DEFAULT => -16
	},
	{#State 28
		ACTIONS => {
			'NONE' => 69,
			'ALL' => 65,
			'SOME' => 67,
			"{" => 66
		},
		GOTOS => {
			'punctlevel' => 68
		}
	},
	{#State 29
		ACTIONS => {
			"{" => 71,
			'INTEGER' => 70
		}
	},
	{#State 30
		ACTIONS => {
			"\n" => 72
		}
	},
	{#State 31
		ACTIONS => {
			'DOUBLE' => 73,
			"{" => 74
		}
	},
	{#State 32
		DEFAULT => -24
	},
	{#State 33
		DEFAULT => -18
	},
	{#State 34
		ACTIONS => {
			'CHAR' => 76,
			"{" => 75
		}
	},
	{#State 35
		ACTIONS => {
			"\n" => 77
		}
	},
	{#State 36
		ACTIONS => {
			'TEXT' => 78,
			"{" => 79
		}
	},
	{#State 37
		ACTIONS => {
			"\n" => 80
		}
	},
	{#State 38
		ACTIONS => {
			"{" => 81,
			'FLAG' => 82
		}
	},
	{#State 39
		DEFAULT => -20
	},
	{#State 40
		DEFAULT => -3
	},
	{#State 41
		DEFAULT => -6
	},
	{#State 42
		DEFAULT => -9
	},
	{#State 43
		DEFAULT => -7
	},
	{#State 44
		ACTIONS => {
			"\n" => 83
		}
	},
	{#State 45
		ACTIONS => {
			'TEXT' => 85,
			"{" => 84
		}
	},
	{#State 46
		DEFAULT => -11
	},
	{#State 47
		ACTIONS => {
			'PUNCTLEVEL' => 86
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
		ACTIONS => {
			"\n" => 90
		}
	},
	{#State 52
		ACTIONS => {
			'FLAG' => 91
		}
	},
	{#State 53
		DEFAULT => -34
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
		ACTIONS => {
			"\n" => 94
		}
	},
	{#State 57
		ACTIONS => {
			'INTEGER' => 95
		}
	},
	{#State 58
		ACTIONS => {
			"\n" => 96
		}
	},
	{#State 59
		ACTIONS => {
			'FLAG' => 97
		}
	},
	{#State 60
		DEFAULT => -44
	},
	{#State 61
		ACTIONS => {
			"\n" => 98
		}
	},
	{#State 62
		ACTIONS => {
			'TEXT' => 99
		}
	},
	{#State 63
		ACTIONS => {
			'TEXT' => 100
		}
	},
	{#State 64
		ACTIONS => {
			"\n" => 101
		}
	},
	{#State 65
		DEFAULT => -63
	},
	{#State 66
		ACTIONS => {
			'ALL' => 65,
			'NONE' => 69,
			'SOME' => 67
		},
		GOTOS => {
			'punctlevel' => 102
		}
	},
	{#State 67
		DEFAULT => -62
	},
	{#State 68
		ACTIONS => {
			'FLAG' => 103
		}
	},
	{#State 69
		DEFAULT => -61
	},
	{#State 70
		ACTIONS => {
			"\n" => 104
		}
	},
	{#State 71
		ACTIONS => {
			'INTEGER' => 105
		}
	},
	{#State 72
		DEFAULT => -35
	},
	{#State 73
		ACTIONS => {
			"\n" => 106
		}
	},
	{#State 74
		ACTIONS => {
			'DOUBLE' => 107
		}
	},
	{#State 75
		ACTIONS => {
			'CHAR' => 108
		}
	},
	{#State 76
		ACTIONS => {
			"\n" => 109
		}
	},
	{#State 77
		DEFAULT => -46
	},
	{#State 78
		ACTIONS => {
			"\n" => 110
		}
	},
	{#State 79
		ACTIONS => {
			'TEXT' => 111
		}
	},
	{#State 80
		DEFAULT => -33
	},
	{#State 81
		ACTIONS => {
			'FLAG' => 112
		}
	},
	{#State 82
		ACTIONS => {
			"\n" => 113
		}
	},
	{#State 83
		DEFAULT => -45
	},
	{#State 84
		ACTIONS => {
			'TEXT' => 114
		}
	},
	{#State 85
		ACTIONS => {
			"\n" => 115
		}
	},
	{#State 86
		ACTIONS => {
			"}" => 116
		}
	},
	{#State 87
		DEFAULT => -54
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
		DEFAULT => -50
	},
	{#State 91
		ACTIONS => {
			"}" => 119
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
		DEFAULT => -56
	},
	{#State 95
		ACTIONS => {
			"}" => 122
		}
	},
	{#State 96
		DEFAULT => -48
	},
	{#State 97
		ACTIONS => {
			"}" => 123
		}
	},
	{#State 98
		DEFAULT => -28
	},
	{#State 99
		ACTIONS => {
			"}" => 124
		}
	},
	{#State 100
		ACTIONS => {
			"}" => 125
		}
	},
	{#State 101
		DEFAULT => -43
	},
	{#State 102
		ACTIONS => {
			'FLAG' => 126
		}
	},
	{#State 103
		ACTIONS => {
			'FLAG' => 127
		}
	},
	{#State 104
		DEFAULT => -37
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
		ACTIONS => {
			"}" => 130
		}
	},
	{#State 109
		DEFAULT => -30
	},
	{#State 110
		DEFAULT => -23
	},
	{#State 111
		ACTIONS => {
			"}" => 131
		}
	},
	{#State 112
		ACTIONS => {
			"}" => 132
		}
	},
	{#State 113
		DEFAULT => -58
	},
	{#State 114
		ACTIONS => {
			"}" => 133
		}
	},
	{#State 115
		DEFAULT => -32
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
		DEFAULT => -39
	},
	{#State 119
		ACTIONS => {
			"\n" => 136
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
			'FLAG' => 142
		}
	},
	{#State 127
		ACTIONS => {
			'FLAG' => 143
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
		DEFAULT => -53
	},
	{#State 135
		ACTIONS => {
			"\n" => 150
		}
	},
	{#State 136
		DEFAULT => -49
	},
	{#State 137
		ACTIONS => {
			"\n" => 151
		}
	},
	{#State 138
		DEFAULT => -55
	},
	{#State 139
		DEFAULT => -47
	},
	{#State 140
		DEFAULT => -27
	},
	{#State 141
		DEFAULT => -42
	},
	{#State 142
		ACTIONS => {
			'FLAG' => 152
		}
	},
	{#State 143
		ACTIONS => {
			'INTEGER' => 153
		}
	},
	{#State 144
		DEFAULT => -36
	},
	{#State 145
		DEFAULT => -51
	},
	{#State 146
		DEFAULT => -29
	},
	{#State 147
		DEFAULT => -22
	},
	{#State 148
		DEFAULT => -57
	},
	{#State 149
		DEFAULT => -31
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
#line 53 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 4
		 'cmd', 1,
sub
#line 54 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 5
		 'cmd', 1,
sub
#line 55 "../parser/parser.yp"
{ &tts_d; $_[1]; }
	],
	[#Rule 6
		 'cmd', 1,
sub
#line 56 "../parser/parser.yp"
{ &tts_s; $_[1]; }
	],
	[#Rule 7
		 'cmd', 1,
sub
#line 57 "../parser/parser.yp"
{ &tts_version; $_[1]; }
	],
	[#Rule 8
		 'cmd', 1,
sub
#line 59 "../parser/parser.yp"
{ 
			&tts_silence($_[1]);
$_[1];
		}
	],
	[#Rule 9
		 'cmd', 1,
sub
#line 63 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 10
		 'cmd', 1,
sub
#line 64 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 11
		 'cmd', 1,
sub
#line 65 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 12
		 'cmd', 1,
sub
#line 67 "../parser/parser.yp"
{
			&tts_pause;
			$_[1];
		}
	],
	[#Rule 13
		 'cmd', 1,
sub
#line 72 "../parser/parser.yp"
{
			&tts_reset;
			$_[1];
		}
	],
	[#Rule 14
		 'cmd', 1,
sub
#line 76 "../parser/parser.yp"
{ &tts_resume; $_[1]; }
	],
	[#Rule 15
		 'cmd', 1,
sub
#line 78 "../parser/parser.yp"
{
			&tts_allcaps_beep($_[1]);
			$_[1];
		}
	],
	[#Rule 16
		 'cmd', 1,
sub
#line 83 "../parser/parser.yp"
{
			&tts_capitalize($_[1]);
			$_[1];
		}
	],
	[#Rule 17
		 'cmd', 1,
sub
#line 88 "../parser/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 18
		 'cmd', 1,
sub
#line 92 "../parser/parser.yp"
{
			&tts_set_punctuations($_[1]);
			$_[1];
		}
	],
	[#Rule 19
		 'cmd', 1,
sub
#line 97 "../parser/parser.yp"
{ 
			&tts_set_speech_rate($_[1]);
				$_[1];		
		}
	],
	[#Rule 20
		 'cmd', 1,
sub
#line 102 "../parser/parser.yp"
{
			&tts_split_caps($_[1]);
			$_[1];
		}
	],
	[#Rule 21
		 'cmd', 1,
sub
#line 107 "../parser/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 22
		 'code', 5,
sub
#line 114 "../parser/parser.yp"
{
			&tts_c($_[3]);
			$_[1];
		}
	],
	[#Rule 23
		 'code', 3,
sub
#line 119 "../parser/parser.yp"
{
			&tts_c($_[2]);
			$_[1];
		}
	],
	[#Rule 24
		 'speech', 1,
sub
#line 126 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 25
		 'speech', 1,
sub
#line 127 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 26
		 'speech', 1,
sub
#line 128 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 27
		 'immediate_speech', 5,
sub
#line 133 "../parser/parser.yp"
{
			&tts_say($_[3]);
			$_[1];
		}
	],
	[#Rule 28
		 'immediate_speech', 3,
sub
#line 138 "../parser/parser.yp"
{
			&tts_say($_[2]);
			$_[1];
		}
	],
	[#Rule 29
		 'character', 5,
sub
#line 146 "../parser/parser.yp"
{
			&tts_l($_[3]);
			$_[1];
		}
	],
	[#Rule 30
		 'character', 3,
sub
#line 151 "../parser/parser.yp"
{
			&tts_l($_[2]);
			$_[1];
		}
	],
	[#Rule 31
		 'queued_speech', 5,
sub
#line 159 "../parser/parser.yp"
{
			&tts_q($_[3]);
			$_[1];
		}
	],
	[#Rule 32
		 'queued_speech', 3,
sub
#line 164 "../parser/parser.yp"
{
			&tts_q($_[2]);
			$_[1];
		}
	],
	[#Rule 33
		 'dispatch', 2,
sub
#line 171 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 34
		 'version', 2,
sub
#line 175 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 35
		 'stop', 2,
sub
#line 179 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 36
		 'silence', 5,
sub
#line 184 "../parser/parser.yp"
{
			$_[3];
		}
	],
	[#Rule 37
		 'silence', 3,
sub
#line 188 "../parser/parser.yp"
{
			$_[2];
		}
	],
	[#Rule 38
		 'beep', 6,
sub
#line 195 "../parser/parser.yp"
{
			&tts_b($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 39
		 'beep', 4,
sub
#line 200 "../parser/parser.yp"
{
			&tts_b($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 40
		 'tone', 6,
sub
#line 208 "../parser/parser.yp"
{
			&tts_t($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 41
		 'tone', 4,
sub
#line 213 "../parser/parser.yp"
{
			&tts_t($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 42
		 'sound', 5,
sub
#line 221 "../parser/parser.yp"
{
			&tts_a($_[3]);
			$_[1];
		}
	],
	[#Rule 43
		 'sound', 3,
sub
#line 226 "../parser/parser.yp"
{
			&tts_a($_[2]);
			$_[1];
		}
	],
	[#Rule 44
		 'tts_pause', 2,
sub
#line 233 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 45
		 'tts_reset', 2,
sub
#line 237 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 46
		 'tts_resume', 2,
sub
#line 241 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 47
		 'tts_allcaps_beep', 5,
sub
#line 245 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 48
		 'tts_allcaps_beep', 3,
sub
#line 246 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 49
		 'tts_capitalize', 5,
sub
#line 250 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 50
		 'tts_capitalize', 3,
sub
#line 251 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 51
		 'tts_set_character_scale', 5,
sub
#line 256 "../parser/parser.yp"
{
			&tts_set_character_scale($_[3]);
			$_[1];
		}
	],
	[#Rule 52
		 'tts_set_character_scale', 3,
sub
#line 261 "../parser/parser.yp"
{
			&tts_set_character_scale($_[2]);
			$_[1];
		}
	],
	[#Rule 53
		 'tts_set_punctuations', 5,
sub
#line 268 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 54
		 'tts_set_punctuations', 3,
sub
#line 269 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 55
		 'tts_set_speech_rate', 5,
sub
#line 273 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 56
		 'tts_set_speech_rate', 3,
sub
#line 274 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 57
		 'tts_split_caps', 5,
sub
#line 278 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 58
		 'tts_split_caps', 3,
sub
#line 279 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 59
		 'tts_sync_state', 9,
sub
#line 284 "../parser/parser.yp"
{ 
			&tts_sync_state($_[3], $_[4], $_[5], $_[6], $_[7]);
			$_[1];
		}
	],
	[#Rule 60
		 'tts_sync_state', 7,
sub
#line 289 "../parser/parser.yp"
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

#line 301 "../parser/parser.yp"


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
		s/^(tts_say)//i
		and do {
			$parser->YYData->{CONDITION} = 1;
			return('TTS_SAY',$1);
		};

		# Version, no arguments
		s/^(version)//i
		and return('VERSION',$1);

		# punctuation levels
		s/^((none|some|all))//
		and do {
			return('PUNCTLEVEL',{'none'=>0,'some'=>1,'all'=>2}->{$1});
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
		and return($1,$1);

		# single letter 'l'
		s/^(l)//i
		and return($1,$1);

		# queued speech 'q'
		s/^(q)//i
		and return($1,$1);

		# tone 't' 
		s/^(t)//i
		and return($1,$1);

		# beep 'b'
		s/^(b)//i
		and return($1,$1);

		# sound file 'a' or 'p'
		s/^((a|p))//i
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
