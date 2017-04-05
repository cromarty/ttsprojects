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
			'TTS_CAPITALIZE' => 2,
			"t" => 23,
			'TTS_ALLCAPS_BEEP' => 24,
			"L" => 25,
			'TTS_SET_SPEECH_RATE' => 26,
			'TTS_SPLIT_CAPS' => 6,
			'VERSION' => 27,
			'TTS_PAUSE' => 28,
			"d" => 10,
			'TTS_RESUME' => 31,
			"s" => 33,
			"c" => 12,
			'SH' => 13,
			'TTS_SET_PUNCTUATIONS' => 35,
			"b" => 39,
			'TTS_SYNC_STATE' => 38,
			'TTS_SET_CHARACTER_SCALE' => 42,
			'' => 43,
			'TTS_SAY' => 45,
			'TTS_RESET' => 18,
			"a" => 46,
			"q" => 19
		},
		GOTOS => {
			'tts_set_character_scale' => 16,
			'code' => 44,
			'tts_reset' => 17,
			'queued_speech' => 20,
			'silence' => 14,
			'tts_split_caps' => 40,
			'cmd' => 37,
			'character' => 15,
			'immediate_speech' => 41,
			'stop' => 34,
			'version' => 36,
			'tts_resume' => 11,
			'tts_capitalize' => 30,
			'tts_allcaps_beep' => 32,
			'dispatch' => 9,
			'tone' => 8,
			'tts_set_speech_rate' => 29,
			'tts_pause' => 7,
			'sound' => 5,
			'tts_sync_state' => 21,
			'tts_set_punctuations' => 4,
			'beep' => 3,
			'speech' => 22
		}
	},
	{#State 2
		ACTIONS => {
			"{" => 47,
			'FLAG' => 48
		}
	},
	{#State 3
		DEFAULT => -9
	},
	{#State 4
		DEFAULT => -18
	},
	{#State 5
		DEFAULT => -11
	},
	{#State 6
		ACTIONS => {
			'FLAG' => 50,
			"{" => 49
		}
	},
	{#State 7
		DEFAULT => -12
	},
	{#State 8
		DEFAULT => -10
	},
	{#State 9
		DEFAULT => -5
	},
	{#State 10
		ACTIONS => {
			"\n" => 51
		}
	},
	{#State 11
		DEFAULT => -14
	},
	{#State 12
		ACTIONS => {
			"{" => 52,
			'ATOM' => 53
		}
	},
	{#State 13
		ACTIONS => {
			'INTEGER' => 54,
			"{" => 55
		}
	},
	{#State 14
		DEFAULT => -8
	},
	{#State 15
		DEFAULT => -26
	},
	{#State 16
		DEFAULT => -17
	},
	{#State 17
		DEFAULT => -13
	},
	{#State 18
		ACTIONS => {
			"\n" => 56
		}
	},
	{#State 19
		ACTIONS => {
			"{" => 57,
			'ATOM' => 58
		}
	},
	{#State 20
		DEFAULT => -25
	},
	{#State 21
		DEFAULT => -21
	},
	{#State 22
		DEFAULT => -4
	},
	{#State 23
		ACTIONS => {
			"{" => 59,
			'INTEGER' => 60
		}
	},
	{#State 24
		ACTIONS => {
			"{" => 62,
			'FLAG' => 61
		}
	},
	{#State 25
		ACTIONS => {
			'CHAR' => 63,
			"{" => 64
		}
	},
	{#State 26
		ACTIONS => {
			'INTEGER' => 65,
			"{" => 66
		}
	},
	{#State 27
		ACTIONS => {
			"\n" => 67
		}
	},
	{#State 28
		ACTIONS => {
			"\n" => 68
		}
	},
	{#State 29
		DEFAULT => -19
	},
	{#State 30
		DEFAULT => -16
	},
	{#State 31
		ACTIONS => {
			"\n" => 69
		}
	},
	{#State 32
		DEFAULT => -15
	},
	{#State 33
		ACTIONS => {
			"\n" => 70
		}
	},
	{#State 34
		DEFAULT => -6
	},
	{#State 35
		ACTIONS => {
			"{" => 71,
			'PUNCTLEVEL' => 72
		}
	},
	{#State 36
		DEFAULT => -7
	},
	{#State 37
		DEFAULT => -2
	},
	{#State 38
		ACTIONS => {
			'ALL' => 77,
			"{" => 74,
			'SOME' => 76,
			'NONE' => 73
		},
		GOTOS => {
			'punctlevel' => 75
		}
	},
	{#State 39
		ACTIONS => {
			'INTEGER' => 78,
			"{" => 79
		}
	},
	{#State 40
		DEFAULT => -20
	},
	{#State 41
		DEFAULT => -24
	},
	{#State 42
		ACTIONS => {
			'DOUBLE' => 81,
			"{" => 80
		}
	},
	{#State 43
		DEFAULT => 0
	},
	{#State 44
		DEFAULT => -3
	},
	{#State 45
		ACTIONS => {
			"{" => 83,
			'ATOM' => 82
		}
	},
	{#State 46
		ACTIONS => {
			"{" => 85,
			'ATOM' => 84
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
		ACTIONS => {
			'FLAG' => 88
		}
	},
	{#State 50
		ACTIONS => {
			"\n" => 89
		}
	},
	{#State 51
		DEFAULT => -33
	},
	{#State 52
		ACTIONS => {
			'TEXT' => 90
		}
	},
	{#State 53
		ACTIONS => {
			"\n" => 91
		}
	},
	{#State 54
		ACTIONS => {
			"\n" => 92
		}
	},
	{#State 55
		ACTIONS => {
			'INTEGER' => 93
		}
	},
	{#State 56
		DEFAULT => -45
	},
	{#State 57
		ACTIONS => {
			'TEXT' => 94
		}
	},
	{#State 58
		ACTIONS => {
			"\n" => 95
		}
	},
	{#State 59
		ACTIONS => {
			'INTEGER' => 96
		}
	},
	{#State 60
		ACTIONS => {
			'INTEGER' => 97
		}
	},
	{#State 61
		ACTIONS => {
			"\n" => 98
		}
	},
	{#State 62
		ACTIONS => {
			'FLAG' => 99
		}
	},
	{#State 63
		ACTIONS => {
			"\n" => 100
		}
	},
	{#State 64
		ACTIONS => {
			'CHAR' => 101
		}
	},
	{#State 65
		ACTIONS => {
			"\n" => 102
		}
	},
	{#State 66
		ACTIONS => {
			'INTEGER' => 103
		}
	},
	{#State 67
		DEFAULT => -34
	},
	{#State 68
		DEFAULT => -44
	},
	{#State 69
		DEFAULT => -46
	},
	{#State 70
		DEFAULT => -35
	},
	{#State 71
		ACTIONS => {
			'PUNCTLEVEL' => 104
		}
	},
	{#State 72
		ACTIONS => {
			"\n" => 105
		}
	},
	{#State 73
		DEFAULT => -61
	},
	{#State 74
		ACTIONS => {
			'ALL' => 77,
			'SOME' => 76,
			'NONE' => 73
		},
		GOTOS => {
			'punctlevel' => 106
		}
	},
	{#State 75
		ACTIONS => {
			'FLAG' => 107
		}
	},
	{#State 76
		DEFAULT => -62
	},
	{#State 77
		DEFAULT => -63
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
			'DOUBLE' => 110
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
			'TEXT' => 113
		}
	},
	{#State 84
		ACTIONS => {
			"\n" => 114
		}
	},
	{#State 85
		ACTIONS => {
			'ATOM' => 115
		}
	},
	{#State 86
		ACTIONS => {
			"}" => 116
		}
	},
	{#State 87
		DEFAULT => -50
	},
	{#State 88
		ACTIONS => {
			"}" => 117
		}
	},
	{#State 89
		DEFAULT => -58
	},
	{#State 90
		ACTIONS => {
			"}" => 118
		}
	},
	{#State 91
		DEFAULT => -23
	},
	{#State 92
		DEFAULT => -37
	},
	{#State 93
		ACTIONS => {
			"}" => 119
		}
	},
	{#State 94
		ACTIONS => {
			"}" => 120
		}
	},
	{#State 95
		DEFAULT => -32
	},
	{#State 96
		ACTIONS => {
			'INTEGER' => 121
		}
	},
	{#State 97
		ACTIONS => {
			"\n" => 122
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
		DEFAULT => -30
	},
	{#State 101
		ACTIONS => {
			"}" => 124
		}
	},
	{#State 102
		DEFAULT => -56
	},
	{#State 103
		ACTIONS => {
			"}" => 125
		}
	},
	{#State 104
		ACTIONS => {
			"}" => 126
		}
	},
	{#State 105
		DEFAULT => -54
	},
	{#State 106
		ACTIONS => {
			'FLAG' => 127
		}
	},
	{#State 107
		ACTIONS => {
			'FLAG' => 128
		}
	},
	{#State 108
		ACTIONS => {
			"\n" => 129
		}
	},
	{#State 109
		ACTIONS => {
			'INTEGER' => 130
		}
	},
	{#State 110
		ACTIONS => {
			"}" => 131
		}
	},
	{#State 111
		DEFAULT => -52
	},
	{#State 112
		DEFAULT => -28
	},
	{#State 113
		ACTIONS => {
			"}" => 132
		}
	},
	{#State 114
		DEFAULT => -43
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
		ACTIONS => {
			"\n" => 138
		}
	},
	{#State 121
		ACTIONS => {
			"}" => 139
		}
	},
	{#State 122
		DEFAULT => -41
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
			'FLAG' => 144
		}
	},
	{#State 128
		ACTIONS => {
			'FLAG' => 145
		}
	},
	{#State 129
		DEFAULT => -39
	},
	{#State 130
		ACTIONS => {
			"}" => 146
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
		DEFAULT => -49
	},
	{#State 135
		DEFAULT => -57
	},
	{#State 136
		DEFAULT => -22
	},
	{#State 137
		DEFAULT => -36
	},
	{#State 138
		DEFAULT => -31
	},
	{#State 139
		ACTIONS => {
			"\n" => 150
		}
	},
	{#State 140
		DEFAULT => -47
	},
	{#State 141
		DEFAULT => -29
	},
	{#State 142
		DEFAULT => -55
	},
	{#State 143
		DEFAULT => -53
	},
	{#State 144
		ACTIONS => {
			'FLAG' => 151
		}
	},
	{#State 145
		ACTIONS => {
			'INTEGER' => 152
		}
	},
	{#State 146
		ACTIONS => {
			"\n" => 153
		}
	},
	{#State 147
		DEFAULT => -51
	},
	{#State 148
		DEFAULT => -27
	},
	{#State 149
		DEFAULT => -42
	},
	{#State 150
		DEFAULT => -40
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
#line 55 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 4
		 'cmd', 1,
sub
#line 56 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 5
		 'cmd', 1,
sub
#line 57 "../parser/parser.yp"
{ &tts_d; $_[1]; }
	],
	[#Rule 6
		 'cmd', 1,
sub
#line 58 "../parser/parser.yp"
{ &tts_s; $_[1]; }
	],
	[#Rule 7
		 'cmd', 1,
sub
#line 59 "../parser/parser.yp"
{ &tts_version; $_[1]; }
	],
	[#Rule 8
		 'cmd', 1,
sub
#line 61 "../parser/parser.yp"
{ 
			&tts_silence($_[1]);
$_[1];
		}
	],
	[#Rule 9
		 'cmd', 1,
sub
#line 65 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 10
		 'cmd', 1,
sub
#line 66 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 11
		 'cmd', 1,
sub
#line 67 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 12
		 'cmd', 1,
sub
#line 69 "../parser/parser.yp"
{
			&tts_pause;
			$_[1];
		}
	],
	[#Rule 13
		 'cmd', 1,
sub
#line 74 "../parser/parser.yp"
{
			&tts_reset;
			$_[1];
		}
	],
	[#Rule 14
		 'cmd', 1,
sub
#line 78 "../parser/parser.yp"
{ &tts_resume; $_[1]; }
	],
	[#Rule 15
		 'cmd', 1,
sub
#line 80 "../parser/parser.yp"
{
			&tts_allcaps_beep($_[1]);
			$_[1];
		}
	],
	[#Rule 16
		 'cmd', 1,
sub
#line 85 "../parser/parser.yp"
{
			&tts_capitalize($_[1]);
			$_[1];
		}
	],
	[#Rule 17
		 'cmd', 1,
sub
#line 90 "../parser/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 18
		 'cmd', 1,
sub
#line 94 "../parser/parser.yp"
{
			&tts_set_punctuations($_[1]);
			$_[1];
		}
	],
	[#Rule 19
		 'cmd', 1,
sub
#line 99 "../parser/parser.yp"
{ 
			&tts_set_speech_rate($_[1]);
				$_[1];		
		}
	],
	[#Rule 20
		 'cmd', 1,
sub
#line 104 "../parser/parser.yp"
{
			&tts_split_caps($_[1]);
			$_[1];
		}
	],
	[#Rule 21
		 'cmd', 1,
sub
#line 109 "../parser/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 22
		 'code', 5,
sub
#line 116 "../parser/parser.yp"
{
			&tts_c($_[3]);
			$_[1];
		}
	],
	[#Rule 23
		 'code', 3,
sub
#line 121 "../parser/parser.yp"
{
			&tts_c($_[2]);
			$_[1];
		}
	],
	[#Rule 24
		 'speech', 1,
sub
#line 128 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 25
		 'speech', 1,
sub
#line 129 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 26
		 'speech', 1,
sub
#line 130 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 27
		 'immediate_speech', 5,
sub
#line 135 "../parser/parser.yp"
{
			&tts_say($_[3]);
			$_[1];
		}
	],
	[#Rule 28
		 'immediate_speech', 3,
sub
#line 140 "../parser/parser.yp"
{
			&tts_say($_[2]);
			$_[1];
		}
	],
	[#Rule 29
		 'character', 5,
sub
#line 148 "../parser/parser.yp"
{
			&tts_l($_[3]);
			$_[1];
		}
	],
	[#Rule 30
		 'character', 3,
sub
#line 153 "../parser/parser.yp"
{
			&tts_l($_[2]);
			$_[1];
		}
	],
	[#Rule 31
		 'queued_speech', 5,
sub
#line 161 "../parser/parser.yp"
{
			&tts_q($_[3]);
			$_[1];
		}
	],
	[#Rule 32
		 'queued_speech', 3,
sub
#line 166 "../parser/parser.yp"
{
			&tts_q($_[2]);
			$_[1];
		}
	],
	[#Rule 33
		 'dispatch', 2,
sub
#line 173 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 34
		 'version', 2,
sub
#line 177 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 35
		 'stop', 2,
sub
#line 181 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 36
		 'silence', 5,
sub
#line 186 "../parser/parser.yp"
{
			$_[3];
		}
	],
	[#Rule 37
		 'silence', 3,
sub
#line 190 "../parser/parser.yp"
{
			$_[2];
		}
	],
	[#Rule 38
		 'beep', 6,
sub
#line 197 "../parser/parser.yp"
{
			&tts_b($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 39
		 'beep', 4,
sub
#line 202 "../parser/parser.yp"
{
			&tts_b($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 40
		 'tone', 6,
sub
#line 210 "../parser/parser.yp"
{
			&tts_t($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 41
		 'tone', 4,
sub
#line 215 "../parser/parser.yp"
{
			&tts_t($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 42
		 'sound', 5,
sub
#line 223 "../parser/parser.yp"
{
			&tts_a($_[3]);
			$_[1];
		}
	],
	[#Rule 43
		 'sound', 3,
sub
#line 228 "../parser/parser.yp"
{
			&tts_a($_[2]);
			$_[1];
		}
	],
	[#Rule 44
		 'tts_pause', 2,
sub
#line 235 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 45
		 'tts_reset', 2,
sub
#line 239 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 46
		 'tts_resume', 2,
sub
#line 243 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 47
		 'tts_allcaps_beep', 5,
sub
#line 247 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 48
		 'tts_allcaps_beep', 3,
sub
#line 248 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 49
		 'tts_capitalize', 5,
sub
#line 252 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 50
		 'tts_capitalize', 3,
sub
#line 253 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 51
		 'tts_set_character_scale', 5,
sub
#line 258 "../parser/parser.yp"
{
			&tts_set_character_scale($_[3]);
			$_[1];
		}
	],
	[#Rule 52
		 'tts_set_character_scale', 3,
sub
#line 263 "../parser/parser.yp"
{
			&tts_set_character_scale($_[2]);
			$_[1];
		}
	],
	[#Rule 53
		 'tts_set_punctuations', 5,
sub
#line 270 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 54
		 'tts_set_punctuations', 3,
sub
#line 271 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 55
		 'tts_set_speech_rate', 5,
sub
#line 275 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 56
		 'tts_set_speech_rate', 3,
sub
#line 276 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 57
		 'tts_split_caps', 5,
sub
#line 280 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 58
		 'tts_split_caps', 3,
sub
#line 281 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 59
		 'tts_sync_state', 9,
sub
#line 286 "../parser/parser.yp"
{ 
			&tts_sync_state($_[3], $_[4], $_[5], $_[6], $_[7]);
			$_[1];
		}
	],
	[#Rule 60
		 'tts_sync_state', 7,
sub
#line 291 "../parser/parser.yp"
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

#line 303 "../parser/parser.yp"


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

		if ($parser->YYData->{STATE} & X_INBRACES ) {
			print "State is X_INBRACES\n" if $debug;
			s/^\s*([^}]+)\s*//
			and do {
				$parser->YYData->{STATE} = X_INITIAL;
				print "About to return text: >$1<\n" if $debug;
				return('TEXT',$1);
			};
		}

		if ($parser->YYData->{STATE} & X_SPEECH ) {
			print "State is X_INBRACES\n" if $debug;
			s/^([^ {}\n]+)//
			and do {
				print "About to return ATOM\n" if $debug;
				$parser->YYData->{STATE} = X_INITIAL;
				return('ATOM',$1);
			};
		}

		# tts_say, immediate speech
		s/^(tts_say)//i
		and do {
			$parser->YYData->{STATE} |= X_SPEECH;
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
			$parser->YYData->{STATE} |= X_SPEECH;
			return($1,$1);
		};

		# single letter 'l'
		s/^(l)//i
		and return($1,$1);

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
			print "Found left brace\n" if $debug;
			if ( $parser->YYData->{STATE} & X_SPEECH ) {
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
