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
use constant X_SPEECH			=> 1;
use constant X_RESOURCE			=> 2;
use constant X_INBRACES			=> 4;

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
			"t" => 45,
			'TTS_RESUME' => 28,
			'TTS_SET_PUNCTUATIONS' => 44,
			"a" => 41,
			'TTS_SET_SPEECH_RATE' => 22,
			'TTS_SET_CHARACTER_SCALE' => 24,
			'TTS_ALLCAPS_BEEP' => 21,
			'SH' => 16,
			'TTS_CAPITALIZE' => 18,
			'' => 15,
			'TTS_PAUSE' => 36,
			'TTS_SAY' => 11,
			'TTS_SYNC_STATE' => 13,
			"c" => 38,
			"q" => 37,
			"s" => 6,
			"b" => 34,
			'VERSION' => 31,
			'TTS_RESET' => 2,
			'TTS_SPLIT_CAPS' => 29,
			"d" => 30,
			"L" => 3
		},
		GOTOS => {
			'dispatch' => 42,
			'tts_resume' => 43,
			'character' => 23,
			'sound' => 40,
			'silence' => 25,
			'tts_set_character_scale' => 26,
			'stop' => 27,
			'code' => 46,
			'tts_set_speech_rate' => 19,
			'cmd' => 17,
			'tone' => 20,
			'tts_reset' => 35,
			'tts_split_caps' => 12,
			'queued_speech' => 14,
			'tts_capitalize' => 39,
			'tts_pause' => 5,
			'tts_allcaps_beep' => 4,
			'immediate_speech' => 7,
			'beep' => 10,
			'tts_sync_state' => 8,
			'speech' => 33,
			'version' => 32,
			'tts_set_punctuations' => 9
		}
	},
	{#State 2
		ACTIONS => {
			"\n" => 47
		}
	},
	{#State 3
		ACTIONS => {
			"{" => 48,
			'CHAR' => 49
		}
	},
	{#State 4
		DEFAULT => -15
	},
	{#State 5
		DEFAULT => -12
	},
	{#State 6
		ACTIONS => {
			"\n" => 50
		}
	},
	{#State 7
		DEFAULT => -24
	},
	{#State 8
		DEFAULT => -21
	},
	{#State 9
		DEFAULT => -18
	},
	{#State 10
		DEFAULT => -9
	},
	{#State 11
		ACTIONS => {
			"{" => 52,
			'ATOM' => 51
		}
	},
	{#State 12
		DEFAULT => -20
	},
	{#State 13
		ACTIONS => {
			'NONE' => 54,
			"{" => 53,
			'SOME' => 57,
			'ALL' => 56
		},
		GOTOS => {
			'punctlevel' => 55
		}
	},
	{#State 14
		DEFAULT => -25
	},
	{#State 15
		DEFAULT => 0
	},
	{#State 16
		ACTIONS => {
			'INTEGER' => 59,
			"{" => 58
		}
	},
	{#State 17
		DEFAULT => -2
	},
	{#State 18
		ACTIONS => {
			'FLAG' => 60,
			"{" => 61
		}
	},
	{#State 19
		DEFAULT => -19
	},
	{#State 20
		DEFAULT => -10
	},
	{#State 21
		ACTIONS => {
			'FLAG' => 63,
			"{" => 62
		}
	},
	{#State 22
		ACTIONS => {
			'INTEGER' => 65,
			"{" => 64
		}
	},
	{#State 23
		DEFAULT => -26
	},
	{#State 24
		ACTIONS => {
			"{" => 66,
			'DOUBLE' => 67
		}
	},
	{#State 25
		DEFAULT => -8
	},
	{#State 26
		DEFAULT => -17
	},
	{#State 27
		DEFAULT => -6
	},
	{#State 28
		ACTIONS => {
			"\n" => 68
		}
	},
	{#State 29
		ACTIONS => {
			'FLAG' => 69,
			"{" => 70
		}
	},
	{#State 30
		ACTIONS => {
			"\n" => 71
		}
	},
	{#State 31
		ACTIONS => {
			"\n" => 72
		}
	},
	{#State 32
		DEFAULT => -7
	},
	{#State 33
		DEFAULT => -4
	},
	{#State 34
		ACTIONS => {
			"{" => 73,
			'INTEGER' => 74
		}
	},
	{#State 35
		DEFAULT => -13
	},
	{#State 36
		ACTIONS => {
			"\n" => 75
		}
	},
	{#State 37
		ACTIONS => {
			'ATOM' => 76,
			"{" => 77
		}
	},
	{#State 38
		ACTIONS => {
			"{" => 78,
			'ATOM' => 79
		}
	},
	{#State 39
		DEFAULT => -16
	},
	{#State 40
		DEFAULT => -11
	},
	{#State 41
		ACTIONS => {
			'ATOM' => 81,
			"{" => 80
		}
	},
	{#State 42
		DEFAULT => -5
	},
	{#State 43
		DEFAULT => -14
	},
	{#State 44
		ACTIONS => {
			"{" => 83,
			'PUNCTLEVEL' => 82
		}
	},
	{#State 45
		ACTIONS => {
			"{" => 85,
			'INTEGER' => 84
		}
	},
	{#State 46
		DEFAULT => -3
	},
	{#State 47
		DEFAULT => -45
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
			"\n" => 88
		}
	},
	{#State 52
		ACTIONS => {
			'TEXT' => 89
		}
	},
	{#State 53
		ACTIONS => {
			'ALL' => 56,
			'SOME' => 57,
			'NONE' => 54
		},
		GOTOS => {
			'punctlevel' => 90
		}
	},
	{#State 54
		DEFAULT => -61
	},
	{#State 55
		ACTIONS => {
			'FLAG' => 91
		}
	},
	{#State 56
		DEFAULT => -63
	},
	{#State 57
		DEFAULT => -62
	},
	{#State 58
		ACTIONS => {
			'INTEGER' => 92
		}
	},
	{#State 59
		ACTIONS => {
			"\n" => 93
		}
	},
	{#State 60
		ACTIONS => {
			"\n" => 94
		}
	},
	{#State 61
		ACTIONS => {
			'FLAG' => 95
		}
	},
	{#State 62
		ACTIONS => {
			'FLAG' => 96
		}
	},
	{#State 63
		ACTIONS => {
			"\n" => 97
		}
	},
	{#State 64
		ACTIONS => {
			'INTEGER' => 98
		}
	},
	{#State 65
		ACTIONS => {
			"\n" => 99
		}
	},
	{#State 66
		ACTIONS => {
			'DOUBLE' => 100
		}
	},
	{#State 67
		ACTIONS => {
			"\n" => 101
		}
	},
	{#State 68
		DEFAULT => -46
	},
	{#State 69
		ACTIONS => {
			"\n" => 102
		}
	},
	{#State 70
		ACTIONS => {
			'FLAG' => 103
		}
	},
	{#State 71
		DEFAULT => -33
	},
	{#State 72
		DEFAULT => -34
	},
	{#State 73
		ACTIONS => {
			'INTEGER' => 104
		}
	},
	{#State 74
		ACTIONS => {
			'INTEGER' => 105
		}
	},
	{#State 75
		DEFAULT => -44
	},
	{#State 76
		ACTIONS => {
			"\n" => 106
		}
	},
	{#State 77
		ACTIONS => {
			'TEXT' => 107
		}
	},
	{#State 78
		ACTIONS => {
			'TEXT' => 108
		}
	},
	{#State 79
		ACTIONS => {
			"\n" => 109
		}
	},
	{#State 80
		ACTIONS => {
			'ATOM' => 110
		}
	},
	{#State 81
		ACTIONS => {
			"\n" => 111
		}
	},
	{#State 82
		ACTIONS => {
			"\n" => 112
		}
	},
	{#State 83
		ACTIONS => {
			'PUNCTLEVEL' => 113
		}
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
		DEFAULT => -30
	},
	{#State 88
		DEFAULT => -28
	},
	{#State 89
		ACTIONS => {
			"}" => 117
		}
	},
	{#State 90
		ACTIONS => {
			'FLAG' => 118
		}
	},
	{#State 91
		ACTIONS => {
			'FLAG' => 119
		}
	},
	{#State 92
		ACTIONS => {
			"}" => 120
		}
	},
	{#State 93
		DEFAULT => -37
	},
	{#State 94
		DEFAULT => -50
	},
	{#State 95
		ACTIONS => {
			"}" => 121
		}
	},
	{#State 96
		ACTIONS => {
			"}" => 122
		}
	},
	{#State 97
		DEFAULT => -48
	},
	{#State 98
		ACTIONS => {
			"}" => 123
		}
	},
	{#State 99
		DEFAULT => -56
	},
	{#State 100
		ACTIONS => {
			"}" => 124
		}
	},
	{#State 101
		DEFAULT => -52
	},
	{#State 102
		DEFAULT => -58
	},
	{#State 103
		ACTIONS => {
			"}" => 125
		}
	},
	{#State 104
		ACTIONS => {
			'INTEGER' => 126
		}
	},
	{#State 105
		ACTIONS => {
			"\n" => 127
		}
	},
	{#State 106
		DEFAULT => -32
	},
	{#State 107
		ACTIONS => {
			"}" => 128
		}
	},
	{#State 108
		ACTIONS => {
			"}" => 129
		}
	},
	{#State 109
		DEFAULT => -23
	},
	{#State 110
		ACTIONS => {
			"}" => 130
		}
	},
	{#State 111
		DEFAULT => -43
	},
	{#State 112
		DEFAULT => -54
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
			"\n" => 135
		}
	},
	{#State 118
		ACTIONS => {
			'FLAG' => 136
		}
	},
	{#State 119
		ACTIONS => {
			'FLAG' => 137
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
			"\n" => 140
		}
	},
	{#State 123
		ACTIONS => {
			"\n" => 141
		}
	},
	{#State 124
		ACTIONS => {
			"\n" => 142
		}
	},
	{#State 125
		ACTIONS => {
			"\n" => 143
		}
	},
	{#State 126
		ACTIONS => {
			"}" => 144
		}
	},
	{#State 127
		DEFAULT => -39
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
			"\n" => 147
		}
	},
	{#State 131
		ACTIONS => {
			"\n" => 148
		}
	},
	{#State 132
		DEFAULT => -41
	},
	{#State 133
		ACTIONS => {
			"}" => 149
		}
	},
	{#State 134
		DEFAULT => -29
	},
	{#State 135
		DEFAULT => -27
	},
	{#State 136
		ACTIONS => {
			'FLAG' => 150
		}
	},
	{#State 137
		ACTIONS => {
			'INTEGER' => 151
		}
	},
	{#State 138
		DEFAULT => -36
	},
	{#State 139
		DEFAULT => -49
	},
	{#State 140
		DEFAULT => -47
	},
	{#State 141
		DEFAULT => -55
	},
	{#State 142
		DEFAULT => -51
	},
	{#State 143
		DEFAULT => -57
	},
	{#State 144
		ACTIONS => {
			"\n" => 152
		}
	},
	{#State 145
		DEFAULT => -31
	},
	{#State 146
		DEFAULT => -22
	},
	{#State 147
		DEFAULT => -42
	},
	{#State 148
		DEFAULT => -53
	},
	{#State 149
		ACTIONS => {
			"\n" => 153
		}
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
		DEFAULT => -38
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
#line 54 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 4
		 'cmd', 1,
sub
#line 55 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 5
		 'cmd', 1,
sub
#line 56 "../parser/parser.yp"
{ &tts_d; $_[1]; }
	],
	[#Rule 6
		 'cmd', 1,
sub
#line 57 "../parser/parser.yp"
{ &tts_s; $_[1]; }
	],
	[#Rule 7
		 'cmd', 1,
sub
#line 58 "../parser/parser.yp"
{ &tts_version; $_[1]; }
	],
	[#Rule 8
		 'cmd', 1,
sub
#line 60 "../parser/parser.yp"
{ 
			&tts_silence($_[1]);
$_[1];
		}
	],
	[#Rule 9
		 'cmd', 1,
sub
#line 64 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 10
		 'cmd', 1,
sub
#line 65 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 11
		 'cmd', 1,
sub
#line 66 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 12
		 'cmd', 1,
sub
#line 68 "../parser/parser.yp"
{
			&tts_pause;
			$_[1];
		}
	],
	[#Rule 13
		 'cmd', 1,
sub
#line 73 "../parser/parser.yp"
{
			&tts_reset;
			$_[1];
		}
	],
	[#Rule 14
		 'cmd', 1,
sub
#line 77 "../parser/parser.yp"
{ &tts_resume; $_[1]; }
	],
	[#Rule 15
		 'cmd', 1,
sub
#line 79 "../parser/parser.yp"
{
			&tts_allcaps_beep($_[1]);
			$_[1];
		}
	],
	[#Rule 16
		 'cmd', 1,
sub
#line 84 "../parser/parser.yp"
{
			&tts_capitalize($_[1]);
			$_[1];
		}
	],
	[#Rule 17
		 'cmd', 1,
sub
#line 89 "../parser/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 18
		 'cmd', 1,
sub
#line 93 "../parser/parser.yp"
{
			&tts_set_punctuations($_[1]);
			$_[1];
		}
	],
	[#Rule 19
		 'cmd', 1,
sub
#line 98 "../parser/parser.yp"
{ 
			&tts_set_speech_rate($_[1]);
				$_[1];		
		}
	],
	[#Rule 20
		 'cmd', 1,
sub
#line 103 "../parser/parser.yp"
{
			&tts_split_caps($_[1]);
			$_[1];
		}
	],
	[#Rule 21
		 'cmd', 1,
sub
#line 108 "../parser/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 22
		 'code', 5,
sub
#line 115 "../parser/parser.yp"
{
			&tts_c($_[3]);
			$_[1];
		}
	],
	[#Rule 23
		 'code', 3,
sub
#line 120 "../parser/parser.yp"
{
			&tts_c($_[2]);
			$_[1];
		}
	],
	[#Rule 24
		 'speech', 1,
sub
#line 127 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 25
		 'speech', 1,
sub
#line 128 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 26
		 'speech', 1,
sub
#line 129 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 27
		 'immediate_speech', 5,
sub
#line 134 "../parser/parser.yp"
{
			&tts_say($_[3]);
			$_[1];
		}
	],
	[#Rule 28
		 'immediate_speech', 3,
sub
#line 139 "../parser/parser.yp"
{
			&tts_say($_[2]);
			$_[1];
		}
	],
	[#Rule 29
		 'character', 5,
sub
#line 147 "../parser/parser.yp"
{
			&tts_l($_[3]);
			$_[1];
		}
	],
	[#Rule 30
		 'character', 3,
sub
#line 152 "../parser/parser.yp"
{
			&tts_l($_[2]);
			$_[1];
		}
	],
	[#Rule 31
		 'queued_speech', 5,
sub
#line 160 "../parser/parser.yp"
{
			&tts_q($_[3]);
			$_[1];
		}
	],
	[#Rule 32
		 'queued_speech', 3,
sub
#line 165 "../parser/parser.yp"
{
			&tts_q($_[2]);
			$_[1];
		}
	],
	[#Rule 33
		 'dispatch', 2,
sub
#line 172 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 34
		 'version', 2,
sub
#line 176 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 35
		 'stop', 2,
sub
#line 180 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 36
		 'silence', 5,
sub
#line 185 "../parser/parser.yp"
{
			$_[3];
		}
	],
	[#Rule 37
		 'silence', 3,
sub
#line 189 "../parser/parser.yp"
{
			$_[2];
		}
	],
	[#Rule 38
		 'beep', 6,
sub
#line 196 "../parser/parser.yp"
{
			&tts_b($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 39
		 'beep', 4,
sub
#line 201 "../parser/parser.yp"
{
			&tts_b($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 40
		 'tone', 6,
sub
#line 209 "../parser/parser.yp"
{
			&tts_t($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 41
		 'tone', 4,
sub
#line 214 "../parser/parser.yp"
{
			&tts_t($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 42
		 'sound', 5,
sub
#line 222 "../parser/parser.yp"
{
			&tts_a($_[3]);
			$_[1];
		}
	],
	[#Rule 43
		 'sound', 3,
sub
#line 227 "../parser/parser.yp"
{
			&tts_a($_[2]);
			$_[1];
		}
	],
	[#Rule 44
		 'tts_pause', 2,
sub
#line 234 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 45
		 'tts_reset', 2,
sub
#line 238 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 46
		 'tts_resume', 2,
sub
#line 242 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 47
		 'tts_allcaps_beep', 5,
sub
#line 246 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 48
		 'tts_allcaps_beep', 3,
sub
#line 247 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 49
		 'tts_capitalize', 5,
sub
#line 251 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 50
		 'tts_capitalize', 3,
sub
#line 252 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 51
		 'tts_set_character_scale', 5,
sub
#line 257 "../parser/parser.yp"
{
			&tts_set_character_scale($_[3]);
			$_[1];
		}
	],
	[#Rule 52
		 'tts_set_character_scale', 3,
sub
#line 262 "../parser/parser.yp"
{
			&tts_set_character_scale($_[2]);
			$_[1];
		}
	],
	[#Rule 53
		 'tts_set_punctuations', 5,
sub
#line 269 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 54
		 'tts_set_punctuations', 3,
sub
#line 270 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 55
		 'tts_set_speech_rate', 5,
sub
#line 274 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 56
		 'tts_set_speech_rate', 3,
sub
#line 275 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 57
		 'tts_split_caps', 5,
sub
#line 279 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 58
		 'tts_split_caps', 3,
sub
#line 280 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 59
		 'tts_sync_state', 9,
sub
#line 285 "../parser/parser.yp"
{ 
			&tts_sync_state($_[3], $_[4], $_[5], $_[6], $_[7]);
			$_[1];
		}
	],
	[#Rule 60
		 'tts_sync_state', 7,
sub
#line 290 "../parser/parser.yp"
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

#line 302 "../parser/parser.yp"


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

	for ($parser->YYData->{INPUT}) {

		if ($parser->YYData->{STATE} == X_INBRACES ) {
			#print "State is X_INBRACES\n";
			#s/^(.*?)([}\n])/$2/
			s/^([^}]+)\s+//
			and do {
				$parser->YYData->{STATE} = X_INITIAL;
				#print "About to return text: >$1<\n";
				return('TEXT',$1);
			};
		}

		if ($parser->YYData->{STATE} == X_SPEECH ) {
			s/^([^ {}\n]+)//
			and do {
				$parser->YYData->{STATE} = X_INITIAL;
				return('ATOM',$1);
			};
		}

		# tts_say, immediate speech
		s/^(tts_say)//i
		and do {
			$parser->YYData->{STATE} = X_SPEECH;
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
		and do {
			$parser->YYData->{STATE} = X_SPEECH;
			return($1,$1);
		};

		# single letter 'l'
		s/^(l)//i
		and return($1,$1);

		# queued speech 'q'
		s/^(q)//i
		and do {
			$parser->YYData->{STATE} = X_SPEECH;
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
			$parser->YYData->{STATE} = X_RESOURCE;
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
			#print "Found left brace\n";
			if ( $parser->YYData->{STATE} == X_SPEECH ) {
				#print "Found left brace while in X_SPEECH\n";
				$parser->YYData->{STATE} = X_INBRACES;
			}
			return($1,$1);
		};

		# Right-brace
		s/^(})//
		and do {
			#print "Found right brace\n";
			$parser->YYData->{STATE} = X_INITIAL;
			return($1,$1);
		};

		# newline
		s/^(\n)//s
		and do {
			$parser->YYData->{STATE} = X_INITIAL;
			return($1,$1);
	
	};

	}

} # end of _Lexer

sub Run {
	my($self)=shift;
	$self->YYParse( yylex => \&_Lexer, yyerror => \&_Error );
} # end of Run


1;
