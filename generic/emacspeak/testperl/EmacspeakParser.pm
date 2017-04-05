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
			'TTS_PAUSE' => 34,
			'VERSION' => 7,
			'TTS_SYNC_STATE' => 10,
			"b" => 11,
			'TTS_SET_SPEECH_RATE' => 3,
			"q" => 2,
			"t" => 4,
			'TTS_RESUME' => 29,
			'TTS_SPLIT_CAPS' => 5,
			'TTS_RESET' => 21,
			'TTS_ALLCAPS_BEEP' => 46,
			"c" => 26,
			'' => 44,
			'TTS_SET_PUNCTUATIONS' => 14,
			'TTS_CAPITALIZE' => 15,
			"d" => 38,
			"a" => 13,
			"s" => 19,
			"l" => 17,
			'SH' => 16,
			'TTS_SET_CHARACTER_SCALE' => 18,
			'TTS_SAY' => 41
		},
		GOTOS => {
			'tts_set_punctuations' => 31,
			'tts_set_character_scale' => 32,
			'cmd' => 27,
			'immediate_speech' => 28,
			'queued_speech' => 30,
			'silence' => 35,
			'beep' => 33,
			'tone' => 6,
			'tts_resume' => 36,
			'tts_allcaps_beep' => 8,
			'sound' => 9,
			'tts_capitalize' => 12,
			'stop' => 37,
			'tts_split_caps' => 20,
			'tts_sync_state' => 42,
			'tts_pause' => 39,
			'code' => 40,
			'character' => 22,
			'dispatch' => 43,
			'tts_reset' => 25,
			'tts_set_speech_rate' => 24,
			'version' => 23,
			'speech' => 45
		}
	},
	{#State 2
		ACTIONS => {
			'ATOM' => 48,
			"{" => 47
		}
	},
	{#State 3
		ACTIONS => {
			"{" => 49,
			'INTEGER' => 50
		}
	},
	{#State 4
		ACTIONS => {
			'INTEGER' => 52,
			"{" => 51
		}
	},
	{#State 5
		ACTIONS => {
			"{" => 53,
			'FLAG' => 54
		}
	},
	{#State 6
		DEFAULT => -10
	},
	{#State 7
		ACTIONS => {
			"\n" => 55
		}
	},
	{#State 8
		DEFAULT => -15
	},
	{#State 9
		DEFAULT => -11
	},
	{#State 10
		ACTIONS => {
			'NONE' => 57,
			'ALL' => 60,
			"{" => 56,
			'SOME' => 58
		},
		GOTOS => {
			'punctlevel' => 59
		}
	},
	{#State 11
		ACTIONS => {
			"{" => 61,
			'INTEGER' => 62
		}
	},
	{#State 12
		DEFAULT => -16
	},
	{#State 13
		ACTIONS => {
			"{" => 64,
			'ATOM' => 63
		}
	},
	{#State 14
		ACTIONS => {
			"{" => 65,
			'PUNCTLEVEL' => 66
		}
	},
	{#State 15
		ACTIONS => {
			"{" => 67,
			'FLAG' => 68
		}
	},
	{#State 16
		ACTIONS => {
			'INTEGER' => 69,
			"{" => 70
		}
	},
	{#State 17
		ACTIONS => {
			'CHAR' => 72,
			"{" => 71
		}
	},
	{#State 18
		ACTIONS => {
			'DOUBLE' => 74,
			"{" => 73
		}
	},
	{#State 19
		ACTIONS => {
			"\n" => 75
		}
	},
	{#State 20
		DEFAULT => -20
	},
	{#State 21
		ACTIONS => {
			"\n" => 76
		}
	},
	{#State 22
		DEFAULT => -26
	},
	{#State 23
		DEFAULT => -7
	},
	{#State 24
		DEFAULT => -19
	},
	{#State 25
		DEFAULT => -13
	},
	{#State 26
		ACTIONS => {
			"{" => 77,
			'ATOM' => 78
		}
	},
	{#State 27
		DEFAULT => -2
	},
	{#State 28
		DEFAULT => -24
	},
	{#State 29
		ACTIONS => {
			"\n" => 79
		}
	},
	{#State 30
		DEFAULT => -25
	},
	{#State 31
		DEFAULT => -18
	},
	{#State 32
		DEFAULT => -17
	},
	{#State 33
		DEFAULT => -9
	},
	{#State 34
		ACTIONS => {
			"\n" => 80
		}
	},
	{#State 35
		DEFAULT => -8
	},
	{#State 36
		DEFAULT => -14
	},
	{#State 37
		DEFAULT => -6
	},
	{#State 38
		ACTIONS => {
			"\n" => 81
		}
	},
	{#State 39
		DEFAULT => -12
	},
	{#State 40
		DEFAULT => -3
	},
	{#State 41
		ACTIONS => {
			"{" => 82,
			'ATOM' => 83
		}
	},
	{#State 42
		DEFAULT => -21
	},
	{#State 43
		DEFAULT => -5
	},
	{#State 44
		DEFAULT => 0
	},
	{#State 45
		DEFAULT => -4
	},
	{#State 46
		ACTIONS => {
			"{" => 85,
			'FLAG' => 84
		}
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
			'INTEGER' => 88
		}
	},
	{#State 50
		ACTIONS => {
			"\n" => 89
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
			'FLAG' => 92
		}
	},
	{#State 54
		ACTIONS => {
			"\n" => 93
		}
	},
	{#State 55
		DEFAULT => -34
	},
	{#State 56
		ACTIONS => {
			'ALL' => 60,
			'NONE' => 57,
			'SOME' => 58
		},
		GOTOS => {
			'punctlevel' => 94
		}
	},
	{#State 57
		DEFAULT => -61
	},
	{#State 58
		DEFAULT => -62
	},
	{#State 59
		ACTIONS => {
			'FLAG' => 95
		}
	},
	{#State 60
		DEFAULT => -63
	},
	{#State 61
		ACTIONS => {
			'INTEGER' => 96
		}
	},
	{#State 62
		ACTIONS => {
			'INTEGER' => 97
		}
	},
	{#State 63
		ACTIONS => {
			"\n" => 98
		}
	},
	{#State 64
		ACTIONS => {
			'ATOM' => 99
		}
	},
	{#State 65
		ACTIONS => {
			'PUNCTLEVEL' => 100
		}
	},
	{#State 66
		ACTIONS => {
			"\n" => 101
		}
	},
	{#State 67
		ACTIONS => {
			'FLAG' => 102
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
			'INTEGER' => 105
		}
	},
	{#State 71
		ACTIONS => {
			'CHAR' => 106
		}
	},
	{#State 72
		ACTIONS => {
			"\n" => 107
		}
	},
	{#State 73
		ACTIONS => {
			'DOUBLE' => 108
		}
	},
	{#State 74
		ACTIONS => {
			"\n" => 109
		}
	},
	{#State 75
		DEFAULT => -35
	},
	{#State 76
		DEFAULT => -45
	},
	{#State 77
		ACTIONS => {
			'TEXT' => 110
		}
	},
	{#State 78
		ACTIONS => {
			"\n" => 111
		}
	},
	{#State 79
		DEFAULT => -46
	},
	{#State 80
		DEFAULT => -44
	},
	{#State 81
		DEFAULT => -33
	},
	{#State 82
		ACTIONS => {
			'TEXT' => 112
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
			'FLAG' => 115
		}
	},
	{#State 86
		ACTIONS => {
			"}" => 116
		}
	},
	{#State 87
		DEFAULT => -32
	},
	{#State 88
		ACTIONS => {
			"}" => 117
		}
	},
	{#State 89
		DEFAULT => -56
	},
	{#State 90
		ACTIONS => {
			'INTEGER' => 118
		}
	},
	{#State 91
		ACTIONS => {
			"\n" => 119
		}
	},
	{#State 92
		ACTIONS => {
			"}" => 120
		}
	},
	{#State 93
		DEFAULT => -58
	},
	{#State 94
		ACTIONS => {
			'FLAG' => 121
		}
	},
	{#State 95
		ACTIONS => {
			'FLAG' => 122
		}
	},
	{#State 96
		ACTIONS => {
			'INTEGER' => 123
		}
	},
	{#State 97
		ACTIONS => {
			"\n" => 124
		}
	},
	{#State 98
		DEFAULT => -43
	},
	{#State 99
		ACTIONS => {
			"}" => 125
		}
	},
	{#State 100
		ACTIONS => {
			"}" => 126
		}
	},
	{#State 101
		DEFAULT => -54
	},
	{#State 102
		ACTIONS => {
			"}" => 127
		}
	},
	{#State 103
		DEFAULT => -50
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
		ACTIONS => {
			"}" => 129
		}
	},
	{#State 107
		DEFAULT => -30
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
		DEFAULT => -23
	},
	{#State 112
		ACTIONS => {
			"}" => 132
		}
	},
	{#State 113
		DEFAULT => -28
	},
	{#State 114
		DEFAULT => -48
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
			"}" => 136
		}
	},
	{#State 119
		DEFAULT => -41
	},
	{#State 120
		ACTIONS => {
			"\n" => 137
		}
	},
	{#State 121
		ACTIONS => {
			'FLAG' => 138
		}
	},
	{#State 122
		ACTIONS => {
			'FLAG' => 139
		}
	},
	{#State 123
		ACTIONS => {
			"}" => 140
		}
	},
	{#State 124
		DEFAULT => -39
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
		DEFAULT => -31
	},
	{#State 135
		DEFAULT => -55
	},
	{#State 136
		ACTIONS => {
			"\n" => 150
		}
	},
	{#State 137
		DEFAULT => -57
	},
	{#State 138
		ACTIONS => {
			'FLAG' => 151
		}
	},
	{#State 139
		ACTIONS => {
			'INTEGER' => 152
		}
	},
	{#State 140
		ACTIONS => {
			"\n" => 153
		}
	},
	{#State 141
		DEFAULT => -42
	},
	{#State 142
		DEFAULT => -53
	},
	{#State 143
		DEFAULT => -49
	},
	{#State 144
		DEFAULT => -36
	},
	{#State 145
		DEFAULT => -29
	},
	{#State 146
		DEFAULT => -51
	},
	{#State 147
		DEFAULT => -22
	},
	{#State 148
		DEFAULT => -27
	},
	{#State 149
		DEFAULT => -47
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
