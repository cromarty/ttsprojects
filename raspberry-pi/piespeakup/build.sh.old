#!/bin/bash
#
# Install dependancies and make and install piespeakup
#

ESPEAKLIBDIR=/usr/lib/arm-linux-gnueabihf

if [ `whoami` != 'root' ]; then
	echo "script must be run as root, try: 'sudo ./$(basename $0)'"
	exit 1
fi

echo 'Checking whether the piespeakup service is running...'
service piespeakup status &>/dev/null
if [ $? -eq 0 ]; then
	echo 'Stopping the piespeakup service...'
	service piespeakup stop
fi

which espeak &>/dev/null
if [ $? -ne 0 ]; then
	echo 'espeak is not installed, installing it...'
	apt-get install -yyq espeak
fi

set -e
if ! [ -L ${ESPEAKLIBDIR}/libespeak.so ]; then
echo 'Fixing the missing espeak lib soft-link...'
	ln -s ${ESPEAKLIBDIR}/libespeak.so.1 ${ESPEAKLIBDIR}/libespeak.so
fi

if [ -z "$(grep speakup_soft /etc/modules)" ]; then
	echo 'Adding speakup_soft to the end of /etc/modules...'
	echo -e "\n# Load speakup_soft at boot\nspeakup_soft\n\n" >> /etc/modules
fi

echo 'Load it for this session...'
modprobe speakup_soft
echo 'Making the piespeakup connector...'
make
echo 'Installing the piespeakup connector...'
make install
echo 'Enabling the piespeakup service...'
update-rc.d piespeakup defaults
echo 'Starting it for this session...'
service piespeakup start
echo 'You should now have speech in the console with no stuttering!'
exit 0



