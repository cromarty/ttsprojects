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
			"L" => 28,
			'' => 3,
			"a" => 2,
			'TTS_SAY' => 33,
			"d" => 9,
			"b" => 32,
			'TTS_SPLIT_CAPS' => 7,
			"q" => 6,
			'TTS_SET_CHARACTER_SCALE' => 29,
			'TTS_PAUSE' => 38,
			'SH' => 11,
			"c" => 36,
			'TTS_SET_PUNCTUATIONS' => 37,
			'TTS_CAPITALIZE' => 10,
			"s" => 23,
			'TTS_SYNC_STATE' => 45,
			"t" => 21,
			'TTS_RESET' => 41,
			'TTS_SET_SPEECH_RATE' => 18,
			'VERSION' => 15,
			'TTS_ALLCAPS_BEEP' => 16,
			'TTS_RESUME' => 12
		},
		GOTOS => {
			'cmd' => 31,
			'tts_sync_state' => 8,
			'immediate_speech' => 30,
			'tts_allcaps_beep' => 4,
			'tts_resume' => 26,
			'tts_set_character_scale' => 25,
			'tts_pause' => 24,
			'dispatch' => 27,
			'queued_speech' => 5,
			'stop' => 17,
			'tone' => 40,
			'tts_capitalize' => 39,
			'code' => 14,
			'silence' => 13,
			'tts_set_punctuations' => 46,
			'sound' => 22,
			'tts_split_caps' => 44,
			'beep' => 43,
			'tts_set_speech_rate' => 19,
			'character' => 42,
			'speech' => 20,
			'tts_reset' => 35,
			'version' => 34
		}
	},
	{#State 2
		ACTIONS => {
			'TEXT' => 48,
			"{" => 47
		}
	},
	{#State 3
		DEFAULT => 0
	},
	{#State 4
		DEFAULT => -15
	},
	{#State 5
		DEFAULT => -25
	},
	{#State 6
		ACTIONS => {
			"{" => 50,
			'WORD' => 49
		}
	},
	{#State 7
		ACTIONS => {
			'FLAG' => 52,
			"{" => 51
		}
	},
	{#State 8
		DEFAULT => -21
	},
	{#State 9
		ACTIONS => {
			"\n" => 53
		}
	},
	{#State 10
		ACTIONS => {
			'FLAG' => 55,
			"{" => 54
		}
	},
	{#State 11
		ACTIONS => {
			'INTEGER' => 57,
			"{" => 56
		}
	},
	{#State 12
		ACTIONS => {
			"\n" => 58
		}
	},
	{#State 13
		DEFAULT => -8
	},
	{#State 14
		DEFAULT => -3
	},
	{#State 15
		ACTIONS => {
			"\n" => 59
		}
	},
	{#State 16
		ACTIONS => {
			'FLAG' => 61,
			"{" => 60
		}
	},
	{#State 17
		DEFAULT => -6
	},
	{#State 18
		ACTIONS => {
			'INTEGER' => 63,
			"{" => 62
		}
	},
	{#State 19
		DEFAULT => -19
	},
	{#State 20
		DEFAULT => -4
	},
	{#State 21
		ACTIONS => {
			"{" => 64,
			'INTEGER' => 65
		}
	},
	{#State 22
		DEFAULT => -11
	},
	{#State 23
		ACTIONS => {
			"\n" => 66
		}
	},
	{#State 24
		DEFAULT => -12
	},
	{#State 25
		DEFAULT => -17
	},
	{#State 26
		DEFAULT => -14
	},
	{#State 27
		DEFAULT => -5
	},
	{#State 28
		ACTIONS => {
			"{" => 67,
			'CHAR' => 68
		}
	},
	{#State 29
		ACTIONS => {
			'DOUBLE' => 69,
			"{" => 70
		}
	},
	{#State 30
		DEFAULT => -24
	},
	{#State 31
		DEFAULT => -2
	},
	{#State 32
		ACTIONS => {
			"{" => 72,
			'INTEGER' => 71
		}
	},
	{#State 33
		ACTIONS => {
			'WORD' => 74,
			"{" => 73
		}
	},
	{#State 34
		DEFAULT => -7
	},
	{#State 35
		DEFAULT => -13
	},
	{#State 36
		ACTIONS => {
			'WORD' => 75,
			"{" => 76
		}
	},
	{#State 37
		ACTIONS => {
			'PUNCTLEVEL' => 78,
			"{" => 77
		}
	},
	{#State 38
		ACTIONS => {
			"\n" => 79
		}
	},
	{#State 39
		DEFAULT => -16
	},
	{#State 40
		DEFAULT => -10
	},
	{#State 41
		ACTIONS => {
			"\n" => 80
		}
	},
	{#State 42
		DEFAULT => -26
	},
	{#State 43
		DEFAULT => -9
	},
	{#State 44
		DEFAULT => -20
	},
	{#State 45
		ACTIONS => {
			'NONE' => 84,
			"{" => 82,
			'SOME' => 83,
			'ALL' => 85
		},
		GOTOS => {
			'punctlevel' => 81
		}
	},
	{#State 46
		DEFAULT => -18
	},
	{#State 47
		ACTIONS => {
			'TEXT' => 86
		}
	},
	{#State 48
		ACTIONS => {
			"\n" => 87
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
			'FLAG' => 90
		}
	},
	{#State 52
		ACTIONS => {
			"\n" => 91
		}
	},
	{#State 53
		DEFAULT => -33
	},
	{#State 54
		ACTIONS => {
			'FLAG' => 92
		}
	},
	{#State 55
		ACTIONS => {
			"\n" => 93
		}
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
		DEFAULT => -46
	},
	{#State 59
		DEFAULT => -34
	},
	{#State 60
		ACTIONS => {
			'FLAG' => 96
		}
	},
	{#State 61
		ACTIONS => {
			"\n" => 97
		}
	},
	{#State 62
		ACTIONS => {
			'INTEGER' => 98
		}
	},
	{#State 63
		ACTIONS => {
			"\n" => 99
		}
	},
	{#State 64
		ACTIONS => {
			'INTEGER' => 100
		}
	},
	{#State 65
		ACTIONS => {
			'INTEGER' => 101
		}
	},
	{#State 66
		DEFAULT => -35
	},
	{#State 67
		ACTIONS => {
			'CHAR' => 102
		}
	},
	{#State 68
		ACTIONS => {
			"\n" => 103
		}
	},
	{#State 69
		ACTIONS => {
			"\n" => 104
		}
	},
	{#State 70
		ACTIONS => {
			'DOUBLE' => 105
		}
	},
	{#State 71
		ACTIONS => {
			'INTEGER' => 106
		}
	},
	{#State 72
		ACTIONS => {
			'INTEGER' => 107
		}
	},
	{#State 73
		ACTIONS => {
			'TEXT' => 108
		}
	},
	{#State 74
		ACTIONS => {
			"\n" => 109
		}
	},
	{#State 75
		ACTIONS => {
			"\n" => 110
		}
	},
	{#State 76
		ACTIONS => {
			'TEXT' => 111
		}
	},
	{#State 77
		ACTIONS => {
			'PUNCTLEVEL' => 112
		}
	},
	{#State 78
		ACTIONS => {
			"\n" => 113
		}
	},
	{#State 79
		DEFAULT => -44
	},
	{#State 80
		DEFAULT => -45
	},
	{#State 81
		ACTIONS => {
			'FLAG' => 114
		}
	},
	{#State 82
		ACTIONS => {
			'ALL' => 85,
			'SOME' => 83,
			'NONE' => 84
		},
		GOTOS => {
			'punctlevel' => 115
		}
	},
	{#State 83
		DEFAULT => -62
	},
	{#State 84
		DEFAULT => -61
	},
	{#State 85
		DEFAULT => -63
	},
	{#State 86
		ACTIONS => {
			"}" => 116
		}
	},
	{#State 87
		DEFAULT => -43
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
		ACTIONS => {
			"}" => 118
		}
	},
	{#State 91
		DEFAULT => -58
	},
	{#State 92
		ACTIONS => {
			"}" => 119
		}
	},
	{#State 93
		DEFAULT => -50
	},
	{#State 94
		ACTIONS => {
			"}" => 120
		}
	},
	{#State 95
		DEFAULT => -37
	},
	{#State 96
		ACTIONS => {
			"}" => 121
		}
	},
	{#State 97
		DEFAULT => -48
	},
	{#State 98
		ACTIONS => {
			"}" => 122
		}
	},
	{#State 99
		DEFAULT => -56
	},
	{#State 100
		ACTIONS => {
			'INTEGER' => 123
		}
	},
	{#State 101
		ACTIONS => {
			"\n" => 124
		}
	},
	{#State 102
		ACTIONS => {
			"}" => 125
		}
	},
	{#State 103
		DEFAULT => -30
	},
	{#State 104
		DEFAULT => -52
	},
	{#State 105
		ACTIONS => {
			"}" => 126
		}
	},
	{#State 106
		ACTIONS => {
			"\n" => 127
		}
	},
	{#State 107
		ACTIONS => {
			'INTEGER' => 128
		}
	},
	{#State 108
		ACTIONS => {
			"}" => 129
		}
	},
	{#State 109
		DEFAULT => -28
	},
	{#State 110
		DEFAULT => -23
	},
	{#State 111
		ACTIONS => {
			"}" => 130
		}
	},
	{#State 112
		ACTIONS => {
			"}" => 131
		}
	},
	{#State 113
		DEFAULT => -54
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
			"}" => 141
		}
	},
	{#State 124
		DEFAULT => -41
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
		DEFAULT => -39
	},
	{#State 128
		ACTIONS => {
			"}" => 144
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
		DEFAULT => -42
	},
	{#State 135
		DEFAULT => -31
	},
	{#State 136
		DEFAULT => -57
	},
	{#State 137
		DEFAULT => -49
	},
	{#State 138
		DEFAULT => -36
	},
	{#State 139
		DEFAULT => -47
	},
	{#State 140
		DEFAULT => -55
	},
	{#State 141
		ACTIONS => {
			"\n" => 150
		}
	},
	{#State 142
		DEFAULT => -29
	},
	{#State 143
		DEFAULT => -51
	},
	{#State 144
		ACTIONS => {
			"\n" => 151
		}
	},
	{#State 145
		DEFAULT => -27
	},
	{#State 146
		DEFAULT => -22
	},
	{#State 147
		DEFAULT => -53
	},
	{#State 148
		ACTIONS => {
			'INTEGER' => 152
		}
	},
	{#State 149
		ACTIONS => {
			'FLAG' => 153
		}
	},
	{#State 150
		DEFAULT => -40
	},
	{#State 151
		DEFAULT => -38
	},
	{#State 152
		ACTIONS => {
			"\n" => 154
		}
	},
	{#State 153
		ACTIONS => {
			'INTEGER' => 155
		}
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
	
	# Eat white space
    $parser->YYData->{INPUT} =~ s/^[ \t]+//;

	for ($parser->YYData->{INPUT}) {

		if ($parser->YYData->{STATE} == X_INBRACES ) {
			#print "State is X_INBRACES\n";
			#s/^(.*?)([}\n])/$2/
			s/^([^}]+)//
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
				return('WORD',$1);
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
