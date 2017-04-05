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
use constant X_INBRACES			=> 8;

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
			"q" => 33,
			"a" => 9,
			"d" => 10,
			'TTS_RESUME' => 6,
			'TTS_SET_SPEECH_RATE' => 30,
			'SH' => 25,
			'TTS_SAY' => 23,
			'TTS_CAPITALIZE' => 28,
			'VERSION' => 29,
			'TTS_SET_PUNCTUATIONS' => 3,
			'TTS_SYNC_STATE' => 5,
			"l" => 41,
			'TTS_RESET' => 45,
			'' => 43,
			'TTS_SPLIT_CAPS' => 38,
			"t" => 17,
			'TTS_PAUSE' => 37,
			"c" => 15,
			"b" => 35,
			'TTS_ALLCAPS_BEEP' => 34,
			'TTS_SET_CHARACTER_SCALE' => 13,
			"s" => 36
		},
		GOTOS => {
			'sound' => 12,
			'tts_set_speech_rate' => 14,
			'stop' => 16,
			'speech' => 18,
			'tts_capitalize' => 39,
			'beep' => 19,
			'tone' => 40,
			'tts_pause' => 42,
			'cmd' => 44,
			'code' => 46,
			'version' => 20,
			'tts_reset' => 2,
			'dispatch' => 21,
			'character' => 22,
			'tts_set_character_scale' => 4,
			'tts_resume' => 24,
			'queued_speech' => 26,
			'tts_allcaps_beep' => 27,
			'tts_split_caps' => 8,
			'silence' => 31,
			'tts_set_punctuations' => 7,
			'immediate_speech' => 32,
			'tts_sync_state' => 11
		}
	},
	{#State 2
		DEFAULT => -13
	},
	{#State 3
		ACTIONS => {
			'PUNCTLEVEL' => 47,
			"{" => 48
		}
	},
	{#State 4
		DEFAULT => -17
	},
	{#State 5
		ACTIONS => {
			'SOME' => 52,
			'ALL' => 51,
			'NONE' => 50,
			"{" => 53
		},
		GOTOS => {
			'punctlevel' => 49
		}
	},
	{#State 6
		ACTIONS => {
			"\n" => 54
		}
	},
	{#State 7
		DEFAULT => -18
	},
	{#State 8
		DEFAULT => -20
	},
	{#State 9
		ACTIONS => {
			'ATOM' => 55,
			"{" => 56
		}
	},
	{#State 10
		ACTIONS => {
			"\n" => 57
		}
	},
	{#State 11
		DEFAULT => -21
	},
	{#State 12
		DEFAULT => -11
	},
	{#State 13
		ACTIONS => {
			'DOUBLE' => 58,
			"{" => 59
		}
	},
	{#State 14
		DEFAULT => -19
	},
	{#State 15
		ACTIONS => {
			'ATOM' => 60,
			"{" => 61
		}
	},
	{#State 16
		DEFAULT => -6
	},
	{#State 17
		ACTIONS => {
			"{" => 63,
			'INTEGER' => 62
		}
	},
	{#State 18
		DEFAULT => -4
	},
	{#State 19
		DEFAULT => -9
	},
	{#State 20
		DEFAULT => -7
	},
	{#State 21
		DEFAULT => -5
	},
	{#State 22
		DEFAULT => -26
	},
	{#State 23
		ACTIONS => {
			"{" => 65,
			'ATOM' => 64
		}
	},
	{#State 24
		DEFAULT => -14
	},
	{#State 25
		ACTIONS => {
			"{" => 66,
			'INTEGER' => 67
		}
	},
	{#State 26
		DEFAULT => -25
	},
	{#State 27
		DEFAULT => -15
	},
	{#State 28
		ACTIONS => {
			"{" => 68,
			'FLAG' => 69
		}
	},
	{#State 29
		ACTIONS => {
			"\n" => 70
		}
	},
	{#State 30
		ACTIONS => {
			'INTEGER' => 72,
			"{" => 71
		}
	},
	{#State 31
		DEFAULT => -8
	},
	{#State 32
		DEFAULT => -24
	},
	{#State 33
		ACTIONS => {
			'ATOM' => 74,
			"{" => 73
		}
	},
	{#State 34
		ACTIONS => {
			"{" => 75,
			'FLAG' => 76
		}
	},
	{#State 35
		ACTIONS => {
			'INTEGER' => 77,
			"{" => 78
		}
	},
	{#State 36
		ACTIONS => {
			"\n" => 79
		}
	},
	{#State 37
		ACTIONS => {
			"\n" => 80
		}
	},
	{#State 38
		ACTIONS => {
			'FLAG' => 82,
			"{" => 81
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
			'CHAR' => 84,
			"{" => 83
		}
	},
	{#State 42
		DEFAULT => -12
	},
	{#State 43
		DEFAULT => 0
	},
	{#State 44
		DEFAULT => -2
	},
	{#State 45
		ACTIONS => {
			"\n" => 85
		}
	},
	{#State 46
		DEFAULT => -3
	},
	{#State 47
		ACTIONS => {
			"\n" => 86
		}
	},
	{#State 48
		ACTIONS => {
			'PUNCTLEVEL' => 87
		}
	},
	{#State 49
		ACTIONS => {
			'FLAG' => 88
		}
	},
	{#State 50
		DEFAULT => -61
	},
	{#State 51
		DEFAULT => -63
	},
	{#State 52
		DEFAULT => -62
	},
	{#State 53
		ACTIONS => {
			'NONE' => 50,
			'ALL' => 51,
			'SOME' => 52
		},
		GOTOS => {
			'punctlevel' => 89
		}
	},
	{#State 54
		DEFAULT => -46
	},
	{#State 55
		ACTIONS => {
			"\n" => 90
		}
	},
	{#State 56
		ACTIONS => {
			'ATOM' => 91
		}
	},
	{#State 57
		DEFAULT => -33
	},
	{#State 58
		ACTIONS => {
			"\n" => 92
		}
	},
	{#State 59
		ACTIONS => {
			'DOUBLE' => 93
		}
	},
	{#State 60
		ACTIONS => {
			"\n" => 94
		}
	},
	{#State 61
		ACTIONS => {
			'TEXT' => 95
		}
	},
	{#State 62
		ACTIONS => {
			'INTEGER' => 96
		}
	},
	{#State 63
		ACTIONS => {
			'INTEGER' => 97
		}
	},
	{#State 64
		ACTIONS => {
			"\n" => 98
		}
	},
	{#State 65
		ACTIONS => {
			'TEXT' => 99
		}
	},
	{#State 66
		ACTIONS => {
			'INTEGER' => 100
		}
	},
	{#State 67
		ACTIONS => {
			"\n" => 101
		}
	},
	{#State 68
		ACTIONS => {
			'FLAG' => 102
		}
	},
	{#State 69
		ACTIONS => {
			"\n" => 103
		}
	},
	{#State 70
		DEFAULT => -34
	},
	{#State 71
		ACTIONS => {
			'INTEGER' => 104
		}
	},
	{#State 72
		ACTIONS => {
			"\n" => 105
		}
	},
	{#State 73
		ACTIONS => {
			'TEXT' => 106
		}
	},
	{#State 74
		ACTIONS => {
			"\n" => 107
		}
	},
	{#State 75
		ACTIONS => {
			'FLAG' => 108
		}
	},
	{#State 76
		ACTIONS => {
			"\n" => 109
		}
	},
	{#State 77
		ACTIONS => {
			'INTEGER' => 110
		}
	},
	{#State 78
		ACTIONS => {
			'INTEGER' => 111
		}
	},
	{#State 79
		DEFAULT => -35
	},
	{#State 80
		DEFAULT => -44
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
		ACTIONS => {
			'CHAR' => 114
		}
	},
	{#State 84
		ACTIONS => {
			"\n" => 115
		}
	},
	{#State 85
		DEFAULT => -45
	},
	{#State 86
		DEFAULT => -54
	},
	{#State 87
		ACTIONS => {
			"}" => 116
		}
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
		DEFAULT => -52
	},
	{#State 93
		ACTIONS => {
			"}" => 120
		}
	},
	{#State 94
		DEFAULT => -23
	},
	{#State 95
		ACTIONS => {
			"}" => 121
		}
	},
	{#State 96
		ACTIONS => {
			"\n" => 122
		}
	},
	{#State 97
		ACTIONS => {
			'INTEGER' => 123
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
		DEFAULT => -37
	},
	{#State 102
		ACTIONS => {
			"}" => 126
		}
	},
	{#State 103
		DEFAULT => -50
	},
	{#State 104
		ACTIONS => {
			"}" => 127
		}
	},
	{#State 105
		DEFAULT => -56
	},
	{#State 106
		ACTIONS => {
			"}" => 128
		}
	},
	{#State 107
		DEFAULT => -32
	},
	{#State 108
		ACTIONS => {
			"}" => 129
		}
	},
	{#State 109
		DEFAULT => -48
	},
	{#State 110
		ACTIONS => {
			"\n" => 130
		}
	},
	{#State 111
		ACTIONS => {
			'INTEGER' => 131
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
		DEFAULT => -30
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
		DEFAULT => -41
	},
	{#State 123
		ACTIONS => {
			"}" => 140
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
		DEFAULT => -39
	},
	{#State 131
		ACTIONS => {
			"}" => 147
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
			'INTEGER' => 150
		}
	},
	{#State 136
		ACTIONS => {
			'FLAG' => 151
		}
	},
	{#State 137
		DEFAULT => -42
	},
	{#State 138
		DEFAULT => -51
	},
	{#State 139
		DEFAULT => -22
	},
	{#State 140
		ACTIONS => {
			"\n" => 152
		}
	},
	{#State 141
		DEFAULT => -27
	},
	{#State 142
		DEFAULT => -36
	},
	{#State 143
		DEFAULT => -49
	},
	{#State 144
		DEFAULT => -55
	},
	{#State 145
		DEFAULT => -31
	},
	{#State 146
		DEFAULT => -47
	},
	{#State 147
		ACTIONS => {
			"\n" => 153
		}
	},
	{#State 148
		DEFAULT => -57
	},
	{#State 149
		DEFAULT => -29
	},
	{#State 150
		ACTIONS => {
			"\n" => 154
		}
	},
	{#State 151
		ACTIONS => {
			'INTEGER' => 155
		}
	},
	{#State 152
		DEFAULT => -40
	},
	{#State 153
		DEFAULT => -38
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
#line 56 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 4
		 'cmd', 1,
sub
#line 57 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 5
		 'cmd', 1,
sub
#line 58 "../parser/parser.yp"
{ &tts_d; $_[1]; }
	],
	[#Rule 6
		 'cmd', 1,
sub
#line 59 "../parser/parser.yp"
{ &tts_s; $_[1]; }
	],
	[#Rule 7
		 'cmd', 1,
sub
#line 60 "../parser/parser.yp"
{ &tts_version; $_[1]; }
	],
	[#Rule 8
		 'cmd', 1,
sub
#line 62 "../parser/parser.yp"
{ 
			&tts_silence($_[1]);
$_[1];
		}
	],
	[#Rule 9
		 'cmd', 1,
sub
#line 66 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 10
		 'cmd', 1,
sub
#line 67 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 11
		 'cmd', 1,
sub
#line 68 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 12
		 'cmd', 1,
sub
#line 70 "../parser/parser.yp"
{
			&tts_pause;
			$_[1];
		}
	],
	[#Rule 13
		 'cmd', 1,
sub
#line 75 "../parser/parser.yp"
{
			&tts_reset;
			$_[1];
		}
	],
	[#Rule 14
		 'cmd', 1,
sub
#line 79 "../parser/parser.yp"
{ &tts_resume; $_[1]; }
	],
	[#Rule 15
		 'cmd', 1,
sub
#line 81 "../parser/parser.yp"
{
			&tts_allcaps_beep($_[1]);
			$_[1];
		}
	],
	[#Rule 16
		 'cmd', 1,
sub
#line 86 "../parser/parser.yp"
{
			&tts_capitalize($_[1]);
			$_[1];
		}
	],
	[#Rule 17
		 'cmd', 1,
sub
#line 91 "../parser/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 18
		 'cmd', 1,
sub
#line 95 "../parser/parser.yp"
{
			&tts_set_punctuations($_[1]);
			$_[1];
		}
	],
	[#Rule 19
		 'cmd', 1,
sub
#line 100 "../parser/parser.yp"
{ 
			&tts_set_speech_rate($_[1]);
				$_[1];		
		}
	],
	[#Rule 20
		 'cmd', 1,
sub
#line 105 "../parser/parser.yp"
{
			&tts_split_caps($_[1]);
			$_[1];
		}
	],
	[#Rule 21
		 'cmd', 1,
sub
#line 110 "../parser/parser.yp"
{
			$_[1];
		}
	],
	[#Rule 22
		 'code', 5,
sub
#line 117 "../parser/parser.yp"
{
			&tts_c($_[3]);
			$_[1];
		}
	],
	[#Rule 23
		 'code', 3,
sub
#line 122 "../parser/parser.yp"
{
			&tts_c($_[2]);
			$_[1];
		}
	],
	[#Rule 24
		 'speech', 1,
sub
#line 129 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 25
		 'speech', 1,
sub
#line 130 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 26
		 'speech', 1,
sub
#line 131 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 27
		 'immediate_speech', 5,
sub
#line 136 "../parser/parser.yp"
{
			&tts_say($_[3]);
			$_[1];
		}
	],
	[#Rule 28
		 'immediate_speech', 3,
sub
#line 141 "../parser/parser.yp"
{
			&tts_say($_[2]);
			$_[1];
		}
	],
	[#Rule 29
		 'character', 5,
sub
#line 149 "../parser/parser.yp"
{
			&tts_l($_[3]);
			$_[1];
		}
	],
	[#Rule 30
		 'character', 3,
sub
#line 154 "../parser/parser.yp"
{
			&tts_l($_[2]);
			$_[1];
		}
	],
	[#Rule 31
		 'queued_speech', 5,
sub
#line 162 "../parser/parser.yp"
{
			&tts_q($_[3]);
			$_[1];
		}
	],
	[#Rule 32
		 'queued_speech', 3,
sub
#line 167 "../parser/parser.yp"
{
			&tts_q($_[2]);
			$_[1];
		}
	],
	[#Rule 33
		 'dispatch', 2,
sub
#line 174 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 34
		 'version', 2,
sub
#line 178 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 35
		 'stop', 2,
sub
#line 182 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 36
		 'silence', 5,
sub
#line 187 "../parser/parser.yp"
{
			$_[3];
		}
	],
	[#Rule 37
		 'silence', 3,
sub
#line 191 "../parser/parser.yp"
{
			$_[2];
		}
	],
	[#Rule 38
		 'beep', 6,
sub
#line 198 "../parser/parser.yp"
{
			&tts_b($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 39
		 'beep', 4,
sub
#line 203 "../parser/parser.yp"
{
			&tts_b($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 40
		 'tone', 6,
sub
#line 211 "../parser/parser.yp"
{
			&tts_t($_[3], $_[4]);
			$_[1];
		}
	],
	[#Rule 41
		 'tone', 4,
sub
#line 216 "../parser/parser.yp"
{
			&tts_t($_[2], $_[3]);
			$_[1];
		}
	],
	[#Rule 42
		 'sound', 5,
sub
#line 224 "../parser/parser.yp"
{
			&tts_a($_[3]);
			$_[1];
		}
	],
	[#Rule 43
		 'sound', 3,
sub
#line 229 "../parser/parser.yp"
{
			&tts_a($_[2]);
			$_[1];
		}
	],
	[#Rule 44
		 'tts_pause', 2,
sub
#line 236 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 45
		 'tts_reset', 2,
sub
#line 240 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 46
		 'tts_resume', 2,
sub
#line 244 "../parser/parser.yp"
{ $_[1]; }
	],
	[#Rule 47
		 'tts_allcaps_beep', 5,
sub
#line 248 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 48
		 'tts_allcaps_beep', 3,
sub
#line 249 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 49
		 'tts_capitalize', 5,
sub
#line 253 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 50
		 'tts_capitalize', 3,
sub
#line 254 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 51
		 'tts_set_character_scale', 5,
sub
#line 259 "../parser/parser.yp"
{
			&tts_set_character_scale($_[3]);
			$_[1];
		}
	],
	[#Rule 52
		 'tts_set_character_scale', 3,
sub
#line 264 "../parser/parser.yp"
{
			&tts_set_character_scale($_[2]);
			$_[1];
		}
	],
	[#Rule 53
		 'tts_set_punctuations', 5,
sub
#line 271 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 54
		 'tts_set_punctuations', 3,
sub
#line 272 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 55
		 'tts_set_speech_rate', 5,
sub
#line 276 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 56
		 'tts_set_speech_rate', 3,
sub
#line 277 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 57
		 'tts_split_caps', 5,
sub
#line 281 "../parser/parser.yp"
{ $_[3]; }
	],
	[#Rule 58
		 'tts_split_caps', 3,
sub
#line 282 "../parser/parser.yp"
{ $_[2]; }
	],
	[#Rule 59
		 'tts_sync_state', 9,
sub
#line 287 "../parser/parser.yp"
{ 
			&tts_sync_state($_[3], $_[4], $_[5], $_[6], $_[7]);
			$_[1];
		}
	],
	[#Rule 60
		 'tts_sync_state', 7,
sub
#line 292 "../parser/parser.yp"
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

#line 304 "../parser/parser.yp"


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
#####
		if ($parser->YYData->{STATE} & X_LETTER ) {
			s/^([^ {}\n])//
			and do {
				print "About to return CHAR\n" if $debug;
				$parser->YYData->{STATE} = X_INITIAL;
				return('CHAR',$1);
			};
		}

#####

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
			$parser->YYData->{STATE} |= X_SPEECH;
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
				( $parser->YYData->{STATE} & X_LETTER ) ) {
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
