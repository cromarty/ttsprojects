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
use constant X_LETTER			=> 4;
use constant X_CODE				=> 8;
use constant X_INBRACES			=> 16;

# Package of functions to be called from semantic actions
use Emacspeak;

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
			'VERSION' => 34,
			'TTS_PAUSE' => 11,
			"s" => 31,
			'TTS_SYNC_STATE' => 36,
			"b" => 13,
			'TTS_CAPITALIZE' => 37,
			'' => 15,
			'SH' => 39,
			"l" => 38,
			'TTS_SAY' => 3,
			"a" => 2,
			'TTS_SET_SPEECH_RATE' => 4,
			"d" => 8,
			"q" => 7,
			'TTS_RESET' => 26,
			'TTS_ALLCAPS_BEEP' => 27,
			'TTS_RESUME' => 40,
			'TTS_SET_PUNCTUATIONS' => 19,
			'TTS_SET_CHARACTER_SCALE' => 21,
			"c" => 22,
			"t" => 24,
			'TTS_SPLIT_CAPS' => 42
		},
		GOTOS => {
			'code' => 5,
			'tts_reset' => 29,
			'tts_set_punctuations' => 30,
			'cmd' => 6,
			'stop' => 9,
			'queued_speech' => 28,
			'tts_resume' => 16,
			'tts_capitalize' => 17,
			'speech' => 32,
			'tts_set_character_scale' => 33,
			'silence' => 10,
			'tts_pause' => 14,
			'beep' => 35,
			'tts_split_caps' => 12,
			'immediate_speech' => 23,
			'version' => 18,
			'tts_set_speech_rate' => 20,
			'character' => 41,
			'tts_sync_state' => 44,
			'dispatch' => 45,
			'sound' => 46,
			'tone' => 25,
			'tts_allcaps_beep' => 43
		}
	},
	{#State 2
		ACTIONS => {
			"{" => 47,
			'ATOM' => 48
		}
	},
	{#State 3
		ACTIONS => {
			'ATOM' => 50,
			"{" => 49
		}
	},
	{#State 4
		ACTIONS => {
			'INTEGER' => 51,
			"{" => 52
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		DEFAULT => -2
	},
	{#State 7
		ACTIONS => {
			'ATOM' => 54,
			"{" => 53
		}
	},
	{#State 8
		ACTIONS => {
			"\n" => 55
		}
	},
	{#State 9
		DEFAULT => -6
	},
	{#State 10
		DEFAULT => -8
	},
	{#State 11
		ACTIONS => {
			"\n" => 56
		}
	},
	{#State 12
		DEFAULT => -20
	},
	{#State 13
		ACTIONS => {
			'INTEGER' => 57,
			"{" => 58
		}
	},
	{#State 14
		DEFAULT => -12
	},
	{#State 15
		DEFAULT => 0
	},
	{#State 16
		DEFAULT => -14
	},
	{#State 17
		DEFAULT => -16
	},
	{#State 18
		DEFAULT => -7
	},
	{#State 19
		ACTIONS => {
			'NONE' => 61,
			"{" => 63,
			'ALL' => 59,
			'SOME' => 60
		},
		GOTOS => {
			'punctlevel' => 62
		}
	},
	{#State 20
		DEFAULT => -19
	},
	{#State 21
		ACTIONS => {
			'DOUBLE' => 65,
			"{" => 64
		}
	},
	{#State 22
		ACTIONS => {
			'ATOM' => 66,
			"{" => 67
		}
	},
	{#State 23
		DEFAULT => -24
	},
	{#State 24
		ACTIONS => {
			'INTEGER' => 68,
			"{" => 69
		}
	},
	{#State 25
		DEFAULT => -10
	},
	{#State 26
		ACTIONS => {
			"\n" => 70
		}
	},
	{#State 27
		ACTIONS => {
			'FLAG' => 71,
			"{" => 72
		}
	},
	{#State 28
		DEFAULT => -25
	},
	{#State 29
		DEFAULT => -13
	},
	{#State 30
		DEFAULT => -18
	},
	{#State 31
		ACTIONS => {
			"\n" => 73
		}
	},
	{#State 32
		DEFAULT => -4
	},
	{#State 33
		DEFAULT => -17
	},
	{#State 34
		ACTIONS => {
			"\n" => 74
		}
	},
	{#State 35
		DEFAULT => -9
	},
	{#State 36
		ACTIONS => {
			'SOME' => 60,
			"{" => 76,
			'ALL' => 59,
			'NONE' => 61
		},
		GOTOS => {
			'punctlevel' => 75
		}
	},
	{#State 37
		ACTIONS => {
			'FLAG' => 77,
			"{" => 78
		}
	},
	{#State 38
		ACTIONS => {
			"{" => 80,
			'CHAR' => 79
		}
	},
	{#State 39
		ACTIONS => {
			'INTEGER' => 81,
			"{" => 82
		}
	},
	{#State 40
		ACTIONS => {
			"\n" => 83
		}
	},
	{#State 41
		DEFAULT => -26
	},
	{#State 42
		ACTIONS => {
			'FLAG' => 84,
			"{" => 85
		}
	},
	{#State 43
		DEFAULT => -15
	},
	{#State 44
		DEFAULT => -21
	},
	{#State 45
		DEFAULT => -5
	},
	{#State 46
		DEFAULT => -11
	},
	{#State 47
		ACTIONS => {
			'ATOM' => 86
		}
	},
	{#State 48
		ACTIONS => {
			"\n" => 87
		}
	},
	{#State 49
		ACTIONS => {
			'TEXT' => 88
		}
	},
	{#State 50
		ACTIONS => {
			"\n" => 89
		}
	},
	{#State 51
		ACTIONS => {
			"\n" => 90
		}
	},
	{#State 52
		ACTIONS => {
			'INTEGER' => 91
		}
	},
	{#State 53
		ACTIONS => {
			'TEXT' => 92
		}
	},
	{#State 54
		ACTIONS => {
			"\n" => 93
		}
	},
	{#State 55
		DEFAULT => -33
	},
	{#State 56
		DEFAULT => -44
	},
	{#State 57
		ACTIONS => {
			'INTEGER' => 94
		}
	},
	{#State 58
		ACTIONS => {
			'INTEGER' => 95
		}
	},
	{#State 59
		DEFAULT => -63
	},
	{#State 60
		DEFAULT => -62
	},
	{#State 61
		DEFAULT => -61
	},
	{#State 62
		ACTIONS => {
			"\n" => 96
		}
	},
	{#State 63
		ACTIONS => {
			'NONE' => 61,
			'SOME' => 60,
			'ALL' => 59
		},
		GOTOS => {
			'punctlevel' => 97
		}
	},
	{#State 64
		ACTIONS => {
			'DOUBLE' => 98
		}
	},
	{#State 65
		ACTIONS => {
			"\n" => 99
		}
	},
	{#State 66
		ACTIONS => {
			"\n" => 100
		}
	},
	{#State 67
		ACTIONS => {
			'CODE' => 101
		}
	},
	{#State 68
		ACTIONS => {
			'INTEGER' => 102
		}
	},
	{#State 69
		ACTIONS => {
			'INTEGER' => 103
		}
	},
	{#State 70
		DEFAULT => -45
	},
	{#State 71
		ACTIONS => {
			"\n" => 104
		}
	},
	{#State 72
		ACTIONS => {
			'FLAG' => 105
		}
	},
	{#State 73
		DEFAULT => -35
	},
	{#State 74
		DEFAULT => -34
	},
	{#State 75
		ACTIONS => {
			'FLAG' => 106
		}
	},
	{#State 76
		ACTIONS => {
			'SOME' => 60,
			'ALL' => 59,
			'NONE' => 61
		},
		GOTOS => {
			'punctlevel' => 107
		}
	},
	{#State 77
		ACTIONS => {
			"\n" => 108
		}
	},
	{#State 78
		ACTIONS => {
			'FLAG' => 109
		}
	},
	{#State 79
		ACTIONS => {
			"\n" => 110
		}
	},
	{#State 80
		ACTIONS => {
			'CHAR' => 111
		}
	},
	{#State 81
		ACTIONS => {
			"\n" => 112
		}
	},
	{#State 82
		ACTIONS => {
			'INTEGER' => 113
		}
	},
	{#State 83
		DEFAULT => -46
	},
	{#State 84
		ACTIONS => {
			"\n" => 114
		}
	},
	{#State 85
		ACTIONS => {
			'FLAG' => 115
		}
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
		ACTIONS => {
			"}" => 117
		}
	},
	{#State 89
		DEFAULT => -28
	},
	{#State 90
		DEFAULT => -56
	},
	{#State 91
		ACTIONS => {
			"}" => 118
		}
	},
	{#State 92
		ACTIONS => {
			"}" => 119
		}
	},
	{#State 93
		DEFAULT => -32
	},
	{#State 94
		ACTIONS => {
			"\n" => 120
		}
	},
	{#State 95
		ACTIONS => {
			'INTEGER' => 121
		}
	},
	{#State 96
		DEFAULT => -54
	},
	{#State 97
		ACTIONS => {
			"}" => 122
		}
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
		DEFAULT => -23
	},
	{#State 101
		ACTIONS => {
			"}" => 124
		}
	},
	{#State 102
		ACTIONS => {
			"\n" => 125
		}
	},
	{#State 103
		ACTIONS => {
			'INTEGER' => 126
		}
	},
	{#State 104
		DEFAULT => -48
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
		DEFAULT => -50
	},
	{#State 109
		ACTIONS => {
			"}" => 130
		}
	},
	{#State 110
		DEFAULT => -30
	},
	{#State 111
		ACTIONS => {
			"}" => 131
		}
	},
	{#State 112
		DEFAULT => -37
	},
	{#State 113
		ACTIONS => {
			"}" => 132
		}
	},
	{#State 114
		DEFAULT => -58
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
		DEFAULT => -39
	},
	{#State 121
		ACTIONS => {
			"}" => 138
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
			"\n" => 141
		}
	},
	{#State 125
		DEFAULT => -41
	},
	{#State 126
		ACTIONS => {
			"}" => 142
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
		DEFAULT => -42
	},
	{#State 135
		DEFAULT => -27
	},
	{#State 136
		DEFAULT => -55
	},
	{#State 137
		DEFAULT => -31
	},
	{#State 138
		ACTIONS => {
			"\n" => 150
		}
	},
	{#State 139
		DEFAULT => -53
	},
	{#State 140
		DEFAULT => -51
	},
	{#State 141
		DEFAULT => -22
	},
	{#State 142
		ACTIONS => {
			"\n" => 151
		}
	},
	{#State 143
		DEFAULT => -47
	},
	{#State 144
		ACTIONS => {
			'INTEGER' => 152
		}
	},
	{#State 145
		ACTIONS => {
			'FLAG' => 153
		}
	},
	{#State 146
		DEFAULT => -49
	},
	{#State 147
		DEFAULT => -29
	},
	{#State 148
		DEFAULT => -36
	},
	{#State 149
		DEFAULT => -57
	},
	{#State 150
		DEFAULT => -38
	},
	{#State 151
		DEFAULT => -40
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
#line 57 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 4
		 'cmd', 1,
sub
#line 58 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 5
		 'cmd', 1,
sub
#line 59 "../parser/parser.yp"
{ &tts_d; $_[1]; }
	],
	[#Rule 6
		 'cmd', 1,
sub
#line 60 "../parser/parser.yp"
{ &tts_s; $_[1]; }
	],
	[#Rule 7
		 'cmd', 1,
sub
#line 61 "../parser/parser.yp"
{ &tts_version; $_[1]; }
	],
	[#Rule 8
		 'cmd', 1,
sub
#line 63 "../parser/parser.yp"
{ 
			&tts_silence($_[1]);
$_[1];
		}
	],
	[#Rule 9
		 'cmd', 1,
sub
#line 67 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 10
		 'cmd', 1,
sub
#line 68 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 11
		 'cmd', 1,
sub
#line 69 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 12
		 'cmd', 1,
sub
#line 71 "../parser/parser.yp"
{
			&tts_pause;
			$_[1];
		}
	],
	[#Rule 13
		 'cmd', 1,
sub
#line 76 "../parser/parser.yp"
{
			&tts_reset;
			$_[1];
		}
	],
	[#Rule 14
		 'cmd', 1,
sub
#line 80 "../parser/parser.yp"
{ &tts_resume; $_[1]; }
	],
	[#Rule 15
		 'cmd', 1,
sub
#line 82 "../parser/parser.yp"
{
			&tts_allcaps_beep($_[1]);
			$_[1];
		}
	],
	[#Rule 16
		 'cmd', 1,
sub
#line 87 "../parser/parser.yp"
{
			&tts_capitalize($_[1]);
			$_[1];
		}
	],
	[#Rule 17
		 'cmd', 1,
sub
#line 92 "../parser/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 18
		 'cmd', 1,
sub
#line 96 "../parser/parser.yp"
{
			&tts_set_punctuations($_[1]);
			$_[1];
		}
	],
	[#Rule 19
		 'cmd', 1,
sub
#line 101 "../parser/parser.yp"
{ 
			&tts_set_speech_rate($_[1]);
				$_[1];		
		}
	],
	[#Rule 20
		 'cmd', 1,
sub
#line 106 "../parser/parser.yp"
{
			&tts_split_caps($_[1]);
			$_[1];
		}
	],
	[#Rule 21
		 'cmd', 1,
sub
#line 111 "../parser/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 22
		 'code', 5,
sub
#line 118 "../parser/parser.yp"
{
			&tts_c($_[3]);
			$_[1];
		}
	],
	[#Rule 23
		 'code', 3,
sub
#line 123 "../parser/parser.yp"
{
			&tts_c($_[2]);
			$_[1];
		}
	],
	[#Rule 24
		 'speech', 1,
sub
#line 130 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 25
		 'speech', 1,
sub
#line 131 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 26
		 'speech', 1,
sub
#line 132 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 27
		 'immediate_speech', 5,
sub
#line 137 "../parser/parser.yp"
{
			&tts_say($_[3]);
			$_[1];
		}
	],
	[#Rule 28
		 'immediate_speech', 3,
sub
#line 142 "../parser/parser.yp"
{
			&tts_say($_[2]);
			$_[1];
		}
	],
	[#Rule 29
		 'character', 5,
sub
#line 150 "../parser/parser.yp"
{
			&tts_l($_[3]);
			$_[1];
		}
	],
	[#Rule 30
		 'character', 3,
sub
#line 155 "../parser/parser.yp"
{
			&tts_l($_[2]);
			$_[1];
		}
	],
	[#Rule 31
		 'queued_speech', 5,
sub
#line 163 "../parser/parser.yp"
{
			&tts_q($_[3]);
			$_[1];
		}
	],
	[#Rule 32
		 'queued_speech', 3,
sub
#line 168 "../parser/parser.yp"
{
			&tts_q($_[2]);
			$_[1];
		}
	],
	[#Rule 33
		 'dispatch', 2,
sub
#line 175 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 34
		 'version', 2,
sub
#line 179 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 35
		 'stop', 2,
sub
#line 183 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 36
		 'silence', 5,
sub
#line 188 "../parser/parser.yp"
{
			$_[3];
		}
	],
	[#Rule 37
		 'silence', 3,
sub
#line 192 "../parser/parser.yp"
{
			$_[2];
		}
	],
	[#Rule 38
		 'beep', 6,
sub
#line 199 "../parser/parser.yp"
{
			&tts_b($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 39
		 'beep', 4,
sub
#line 204 "../parser/parser.yp"
{
			&tts_b($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 40
		 'tone', 6,
sub
#line 212 "../parser/parser.yp"
{
			&tts_t($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 41
		 'tone', 4,
sub
#line 217 "../parser/parser.yp"
{
			&tts_t($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 42
		 'sound', 5,
sub
#line 225 "../parser/parser.yp"
{
			&tts_a($_[3]);
			$_[1];
		}
	],
	[#Rule 43
		 'sound', 3,
sub
#line 230 "../parser/parser.yp"
{
			&tts_a($_[2]);
			$_[1];
		}
	],
	[#Rule 44
		 'tts_pause', 2,
sub
#line 237 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 45
		 'tts_reset', 2,
sub
#line 241 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 46
		 'tts_resume', 2,
sub
#line 245 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 47
		 'tts_allcaps_beep', 5,
sub
#line 249 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 48
		 'tts_allcaps_beep', 3,
sub
#line 250 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 49
		 'tts_capitalize', 5,
sub
#line 254 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 50
		 'tts_capitalize', 3,
sub
#line 255 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 51
		 'tts_set_character_scale', 5,
sub
#line 260 "../parser/parser.yp"
{
			&tts_set_character_scale($_[3]);
			$_[1];
		}
	],
	[#Rule 52
		 'tts_set_character_scale', 3,
sub
#line 265 "../parser/parser.yp"
{
			&tts_set_character_scale($_[2]);
			$_[1];
		}
	],
	[#Rule 53
		 'tts_set_punctuations', 5,
sub
#line 272 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 54
		 'tts_set_punctuations', 3,
sub
#line 273 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 55
		 'tts_set_speech_rate', 5,
sub
#line 277 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 56
		 'tts_set_speech_rate', 3,
sub
#line 278 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 57
		 'tts_split_caps', 5,
sub
#line 282 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 58
		 'tts_split_caps', 3,
sub
#line 283 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 59
		 'tts_sync_state', 9,
sub
#line 288 "../parser/parser.yp"
{ 
			&tts_sync_state($_[3], $_[4], $_[5], $_[6], $_[7]);
			$_[1];
		}
	],
	[#Rule 60
		 'tts_sync_state', 7,
sub
#line 293 "../parser/parser.yp"
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

#line 305 "../parser/parser.yp"


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
			if ( ( $parser->YYData->{STATE} & X_SPEECH ) ||
				( $parser->YYData->{STATE} & X_LETTER ) ||
				( $parser->YYData->{STATE} & X_CODE ) ) { 
				print "Found left brace while in X_SPEECH\n" if $debug;
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
