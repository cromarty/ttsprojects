#!/bin/bash

if [ `whoami` != 'root' ]; then
	echo 'script must be run as root'
	exit 1
fi

set -e
service piespeakup stop
echo 'uninstalling the previous library version'
make uninstall >/dev/null
echo 'installing the new library version'
make install >/dev/null
echo 'truncating the libilctts debug log'
truncate -s 0 /tmp/libilctts.log
service piespeakup start
exit 0
