
# Notes about speech-dispatcher

Orca needs an environment variable to know where to connect to sd.  The format 
of this variable is:

SPEECHD_ADDRESS=unix_socket:/path/to/socket

or:

SPEECHD_ADDRESS=inet_socket:host:port

For example:

SPEECHD_ADDRESS=unix_socket:/var/tmp/speech-dispatcher/speechd.sock
SPEECHD_ADDRESS=inet_socket:localhost:6560

I got a lot of understanding about how speech-dispatcher works with Orca from
looking carefully at the setup of Knoppix 7.2, the Adriane edition.

speechd-up is currently useless if speech-dispatcher is set NOT to auto-spawn 
because it has a requirement for auto-spawn hard-coded into it.













