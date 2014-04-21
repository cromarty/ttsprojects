package SpeechDispatcherClient;

use IO::File;
use IO::Socket;

sub new {
	my $pkg = shift;
	my $self = {
		config => shift,
		communicationmethod => 'unix_socket',
		socketpath => 'default',
		port => 6560,
		localhostaccessonly => 1,
		logdir => 'default',
		defaultrate => 0,
		defaultpitch => 0,
		defaultvolume => 0,
		defaultvoicetype => 'MALE1',
		defaultlanguage => 'en',
		defaultpausecontext => 0,
		defaultpunctuationmode => 'none',
		defaultcapletrecognition => 'none',
		defaultspelling => 'off',
		disableautospawn => 1,
socket => undef,
connected => 0,
charswritten => 0
	};
	return bless $self, $pkg;
}

sub config {
	my $self = shift;
	my $config = shift;
	my $ret = $self->{config};
	if ($config) {
		$self->{config} = $config;
	}
	return $ret;
}

sub loadconfig {
	my $self = shift;
	my $key;
	my $value;
	my $fh = new IO::File $self->config, 'r';
	my $clientsection = 0;
	while(<$fh>) {
		chomp;
		s/#.*//;
		s/^\s+//;
		s/\s+$//;
		next unless length;
	next if /Include/;
		next if /AddModule/;
		$clientsection = 0 if /EndClient/;
		if ( ( $clientsection) || ( /BeginClient/) ) {
			$clientsection = 1;
			next;
		}
		($key, $value) = split(/\s+/, $_, 2);
		$value =~ s/[\"\']//g;
		$key = lc($key);
		$self->{$key} = $value;
	}
	undef $fh;
	return;
}


#---- auto generated

sub communicationmethod {
    my $self = shift;
    my $communicationmethod = shift;
    my $ret = $self->{communicationmethod};
    if ($communicationmethod) {
	$self->{communicationmethod} = $communicationmethod;
    }
    return $ret;
}


sub socketpath {
    my $self = shift;
    my $socketpath = shift;
    my $ret = $self->{socketpath};
    if ($socketpath) {
	$self->{socketpath} = $socketpath;
    }
    return $ret;
}


sub port {
    my $self = shift;
    my $port = shift;
    my $ret = $self->{port};
    if ($port) {
	$self->{port} = $port;
    }
    return $ret;
}


sub localhostaccessonly {
    my $self = shift;
    my $localhostaccessonly = shift;
    my $ret = $self->{localhostaccessonly};
    if ($localhostaccessonly) {
	$self->{localhostaccessonly} = $localhostaccessonly;
    }
    return $ret;
}


sub logdir {
    my $self = shift;
    my $logdir = shift;
    my $ret = $self->{logdir};
    if ($logdir) {
	$self->{logdir} = $logdir;
    }
    return $ret;
}


sub defaultrate {
    my $self = shift;
    my $defaultrate = shift;
    my $ret = $self->{defaultrate};
    if ($defaultrate) {
	$self->{defaultrate} = $defaultrate;
    }
    return $ret;
}


sub defaultpitch {
    my $self = shift;
    my $defaultpitch = shift;
    my $ret = $self->{defaultpitch};
    if ($defaultpitch) {
	$self->{defaultpitch} = $defaultpitch;
    }
    return $ret;
}


sub defaultvolume {
    my $self = shift;
    my $defaultvolume = shift;
    my $ret = $self->{defaultvolume};
    if (defined $defaultvolume) {
print "Default volume: $defaultvolume\n";
	$self->{defaultvolume} = $defaultvolume;
    }
    return $ret;
}


sub defaultvoicetype {
    my $self = shift;
    my $defaultvoicetype = shift;
    my $ret = $self->{defaultvoicetype};
    if ($defaultvoicetype) {
	$self->{defaultvoicetype} = $defaultvoicetype;
    }
    return $ret;
}


sub defaultlanguage {
    my $self = shift;
    my $defaultlanguage = shift;
    my $ret = $self->{defaultlanguage};
    if ($defaultlanguage) {
	$self->{defaultlanguage} = $defaultlanguage;
    }
    return $ret;
}


sub defaultpausecontext {
    my $self = shift;
    my $defaultpausecontext = shift;
    my $ret = $self->{defaultpausecontext};
    if ($defaultpausecontext) {
	$self->{defaultpausecontext} = $defaultpausecontext;
    }
    return $ret;
}


sub defaultpunctuationmode {
    my $self = shift;
    my $defaultpunctuationmode = shift;
    my $ret = $self->{defaultpunctuationmode};
    if ($defaultpunctuationmode) {
	$self->{defaultpunctuationmode} = $defaultpunctuationmode;
    }
    return $ret;
}


sub defaultcapletrecognition {
    my $self = shift;
    my $defaultcapletrecognition = shift;
    my $ret = $self->{defaultcapletrecognition};
    if ($defaultcapletrecognition) {
	$self->{defaultcapletrecognition} = $defaultcapletrecognition;
    }
    return $ret;
}


sub defaultspelling {
    my $self = shift;
    my $defaultspelling = shift;
    my $ret = $self->{defaultspelling};
    if ($defaultspelling) {
	$self->{defaultspelling} = $defaultspelling;
    }
    return $ret;
}


sub disableautospawn {
    my $self = shift;
    my $disableautospawn = shift;
    my $ret = $self->{disableautospawn};
    if ($disableautospawn) {
	$self->{disableautospawn} = $disableautospawn;
    }
    return $ret;
}

#----- network stuff

sub connect {
	my $self = shift;
	$self->{connected} = 0;
	if ( $self->communicationmethod == 'unix_socket' ) {
		$self->{socket} = IO::Socket::UNIX->new(
			Peer => $self->socketpath,
			Type => SOCK_STREAM,
Blocking => 0,
			Timeout => 10
		) || return undef;
	} elsif ( $self->communicationmethod == 'inet_socket' ) {
		$self->socket = IO::Socket::INET->new(
			PeerAddr => $self->host,
			PeerPort => $self->port,
			Proto => 'tcp',
			Type => SOCK_STREAM,
Blocking => 0,
			Timeout => 10
		) || return undef;
	} else {
		return undef;
	}
	$self->{connected} = 1;
	return $self->connected;
}

sub disconnect {
	my $self = shift;
	$self->socket->print("quit\r\n");
$self->socket->close();
	$self->{connected} = 0;
$self->socket = undef;
}


sub connected {
    my $self = shift;
    return $self->{connected};
}

sub socket {
    my $self = shift;
    my $socket = shift;
    my $ret = $self->{socket};
    if ( $socket ) {
	$self->{socket} = $socket;
    }
    return $ret;
}





1;

=head1 NAME

SpeechDispatcherClient

=head2 SYNOPSIS

	use SpeechDispatcherClient;

	my $sdc = new SpeechDispatcherClient('/etc/speech-dispatcher/speechd.conf');

	$sdc->loadconfig;
	$sdc->connect;

=head1 DESCRIPTION

Provides a wrapper for creating a complete SpeechDispatcher client application in Perl.

Reads specified speech-dispatcher configuration file.

Stores configuration settings from the file as object members.

Connects to either UNIX or INET domain socket, whichever sd is configured for.

Provides wrapper functions for text-speaking SSIP commands and synthesiser setting commands.

Does NOT use the speech-dispatcher API, so will not auto-spawn the server.

=head1 CONSTRUCTOR

	my $sdc = new SpeechDispatcherClient('/path/to/speechd.conf');
