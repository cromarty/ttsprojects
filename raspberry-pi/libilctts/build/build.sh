#!/bin/bash
#

if [ `whoami` != 'root' ]; then
	echo "script must be run as root, try: 'sudo ./$(basename $0)'"
	exit 1
fi

set -e
make -C ../src
make install -C ../src
exit 0

