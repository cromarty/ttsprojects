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
			'TTS_SPLIT_CAPS' => 7,
			'TTS_SET_CHARACTER_SCALE' => 39,
			'' => 30,
			'VERSION' => 2,
			'TTS_SAY' => 3,
			'SH' => 32,
			"q" => 4,
			'TTS_RESET' => 6,
			'TTS_CAPITALIZE' => 36,
			"a" => 44,
			"l" => 45,
			'TTS_ALLCAPS_BEEP' => 25,
			"c" => 26,
			"d" => 27,
			'TTS_PAUSE' => 29,
			"t" => 46,
			'TTS_SET_SPEECH_RATE' => 18,
			'TTS_RESUME' => 41,
			'TTS_SYNC_STATE' => 20,
			"b" => 42,
			"s" => 21,
			'TTS_SET_PUNCTUATIONS' => 19
		},
		GOTOS => {
			'tts_split_caps' => 24,
			'tts_pause' => 23,
			'immediate_speech' => 28,
			'tts_resume' => 40,
			'tts_capitalize' => 17,
			'silence' => 43,
			'beep' => 22,
			'code' => 8,
			'tts_reset' => 9,
			'tts_set_speech_rate' => 38,
			'tts_allcaps_beep' => 37,
			'queued_speech' => 16,
			'character' => 14,
			'cmd' => 15,
			'dispatch' => 13,
			'sound' => 12,
			'version' => 10,
			'stop' => 11,
			'tts_sync_state' => 31,
			'tts_set_character_scale' => 5,
			'speech' => 35,
			'tone' => 34,
			'tts_set_punctuations' => 33
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
			'ATOM' => 49
		}
	},
	{#State 4
		ACTIONS => {
			"{" => 50,
			'ATOM' => 51
		}
	},
	{#State 5
		DEFAULT => -17
	},
	{#State 6
		ACTIONS => {
			"\n" => 52
		}
	},
	{#State 7
		ACTIONS => {
			"{" => 53,
			'FLAG' => 54
		}
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		DEFAULT => -13
	},
	{#State 10
		DEFAULT => -7
	},
	{#State 11
		DEFAULT => -6
	},
	{#State 12
		DEFAULT => -11
	},
	{#State 13
		DEFAULT => -5
	},
	{#State 14
		DEFAULT => -26
	},
	{#State 15
		DEFAULT => -2
	},
	{#State 16
		DEFAULT => -25
	},
	{#State 17
		DEFAULT => -16
	},
	{#State 18
		ACTIONS => {
			'INTEGER' => 55,
			"{" => 56
		}
	},
	{#State 19
		ACTIONS => {
			'NONE' => 59,
			"{" => 58,
			'SOME' => 61,
			'ALL' => 60
		},
		GOTOS => {
			'punctlevel' => 57
		}
	},
	{#State 20
		ACTIONS => {
			"{" => 62,
			'ALL' => 60,
			'SOME' => 61,
			'NONE' => 59
		},
		GOTOS => {
			'punctlevel' => 63
		}
	},
	{#State 21
		ACTIONS => {
			"\n" => 64
		}
	},
	{#State 22
		DEFAULT => -9
	},
	{#State 23
		DEFAULT => -12
	},
	{#State 24
		DEFAULT => -20
	},
	{#State 25
		ACTIONS => {
			"{" => 66,
			'FLAG' => 65
		}
	},
	{#State 26
		ACTIONS => {
			'ATOM' => 68,
			"{" => 67
		}
	},
	{#State 27
		ACTIONS => {
			"\n" => 69
		}
	},
	{#State 28
		DEFAULT => -24
	},
	{#State 29
		ACTIONS => {
			"\n" => 70
		}
	},
	{#State 30
		DEFAULT => 0
	},
	{#State 31
		DEFAULT => -21
	},
	{#State 32
		ACTIONS => {
			"{" => 71,
			'INTEGER' => 72
		}
	},
	{#State 33
		DEFAULT => -18
	},
	{#State 34
		DEFAULT => -10
	},
	{#State 35
		DEFAULT => -4
	},
	{#State 36
		ACTIONS => {
			'FLAG' => 73,
			"{" => 74
		}
	},
	{#State 37
		DEFAULT => -15
	},
	{#State 38
		DEFAULT => -19
	},
	{#State 39
		ACTIONS => {
			"{" => 76,
			'DOUBLE' => 75
		}
	},
	{#State 40
		DEFAULT => -14
	},
	{#State 41
		ACTIONS => {
			"\n" => 77
		}
	},
	{#State 42
		ACTIONS => {
			'INTEGER' => 78,
			"{" => 79
		}
	},
	{#State 43
		DEFAULT => -8
	},
	{#State 44
		ACTIONS => {
			"{" => 81,
			'ATOM' => 80
		}
	},
	{#State 45
		ACTIONS => {
			'CHAR' => 83,
			"{" => 82
		}
	},
	{#State 46
		ACTIONS => {
			'INTEGER' => 84,
			"{" => 85
		}
	},
	{#State 47
		DEFAULT => -34
	},
	{#State 48
		ACTIONS => {
			'TEXT' => 86
		}
	},
	{#State 49
		ACTIONS => {
			"\n" => 87
		}
	},
	{#State 50
		ACTIONS => {
			'TEXT' => 88
		}
	},
	{#State 51
		ACTIONS => {
			"\n" => 89
		}
	},
	{#State 52
		DEFAULT => -45
	},
	{#State 53
		ACTIONS => {
			'FLAG' => 90
		}
	},
	{#State 54
		ACTIONS => {
			"\n" => 91
		}
	},
	{#State 55
		ACTIONS => {
			"\n" => 92
		}
	},
	{#State 56
		ACTIONS => {
			'INTEGER' => 93
		}
	},
	{#State 57
		ACTIONS => {
			"\n" => 94
		}
	},
	{#State 58
		ACTIONS => {
			'NONE' => 59,
			'ALL' => 60,
			'SOME' => 61
		},
		GOTOS => {
			'punctlevel' => 95
		}
	},
	{#State 59
		DEFAULT => -61
	},
	{#State 60
		DEFAULT => -63
	},
	{#State 61
		DEFAULT => -62
	},
	{#State 62
		ACTIONS => {
			'ALL' => 60,
			'SOME' => 61,
			'NONE' => 59
		},
		GOTOS => {
			'punctlevel' => 96
		}
	},
	{#State 63
		ACTIONS => {
			'FLAG' => 97
		}
	},
	{#State 64
		DEFAULT => -35
	},
	{#State 65
		ACTIONS => {
			"\n" => 98
		}
	},
	{#State 66
		ACTIONS => {
			'FLAG' => 99
		}
	},
	{#State 67
		ACTIONS => {
			'CODE' => 100
		}
	},
	{#State 68
		ACTIONS => {
			"\n" => 101
		}
	},
	{#State 69
		DEFAULT => -33
	},
	{#State 70
		DEFAULT => -44
	},
	{#State 71
		ACTIONS => {
			'INTEGER' => 102
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
		DEFAULT => -46
	},
	{#State 78
		ACTIONS => {
			'INTEGER' => 108
		}
	},
	{#State 79
		ACTIONS => {
			'INTEGER' => 109
		}
	},
	{#State 80
		ACTIONS => {
			"\n" => 110
		}
	},
	{#State 81
		ACTIONS => {
			'ATOM' => 111
		}
	},
	{#State 82
		ACTIONS => {
			'CHAR' => 112
		}
	},
	{#State 83
		ACTIONS => {
			"\n" => 113
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
		DEFAULT => -28
	},
	{#State 88
		ACTIONS => {
			"}" => 117
		}
	},
	{#State 89
		DEFAULT => -32
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
		DEFAULT => -56
	},
	{#State 93
		ACTIONS => {
			"}" => 119
		}
	},
	{#State 94
		DEFAULT => -54
	},
	{#State 95
		ACTIONS => {
			"}" => 120
		}
	},
	{#State 96
		ACTIONS => {
			'FLAG' => 121
		}
	},
	{#State 97
		ACTIONS => {
			'FLAG' => 122
		}
	},
	{#State 98
		DEFAULT => -48
	},
	{#State 99
		ACTIONS => {
			"}" => 123
		}
	},
	{#State 100
		ACTIONS => {
			"}" => 124
		}
	},
	{#State 101
		DEFAULT => -23
	},
	{#State 102
		ACTIONS => {
			"}" => 125
		}
	},
	{#State 103
		DEFAULT => -37
	},
	{#State 104
		DEFAULT => -50
	},
	{#State 105
		ACTIONS => {
			"}" => 126
		}
	},
	{#State 106
		DEFAULT => -52
	},
	{#State 107
		ACTIONS => {
			"}" => 127
		}
	},
	{#State 108
		ACTIONS => {
			"\n" => 128
		}
	},
	{#State 109
		ACTIONS => {
			'INTEGER' => 129
		}
	},
	{#State 110
		DEFAULT => -43
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
		DEFAULT => -30
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
			'FLAG' => 139
		}
	},
	{#State 122
		ACTIONS => {
			'FLAG' => 140
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
			"\n" => 144
		}
	},
	{#State 127
		ACTIONS => {
			"\n" => 145
		}
	},
	{#State 128
		DEFAULT => -39
	},
	{#State 129
		ACTIONS => {
			"}" => 146
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
		DEFAULT => -27
	},
	{#State 135
		DEFAULT => -31
	},
	{#State 136
		DEFAULT => -57
	},
	{#State 137
		DEFAULT => -55
	},
	{#State 138
		DEFAULT => -53
	},
	{#State 139
		ACTIONS => {
			'FLAG' => 150
		}
	},
	{#State 140
		ACTIONS => {
			'INTEGER' => 151
		}
	},
	{#State 141
		DEFAULT => -47
	},
	{#State 142
		DEFAULT => -22
	},
	{#State 143
		DEFAULT => -36
	},
	{#State 144
		DEFAULT => -49
	},
	{#State 145
		DEFAULT => -51
	},
	{#State 146
		ACTIONS => {
			"\n" => 152
		}
	},
	{#State 147
		DEFAULT => -42
	},
	{#State 148
		DEFAULT => -29
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
