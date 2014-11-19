#!/bin/bash
#

ESPEAKLIBDIR=/usr/lib/arm-linux-gnueabihf

if [ `whoami` != 'root' ]; then
	echo "script must be run as root, try: 'sudo ./$(basename $0)'"
	exit 1
fi

dpkg -s espeak &>/dev/null
if [ $? -ne 0 ]; then
	echo 'espeak is not installed, installing it...'
	apt-get install espeak
fi

set -e
echo 'Fixing the missing espeak lib soft-link...'
[ ! -f ${ESPEAKLIBDIR}/libespeak.so ] && ln -s ${ESPEAKLIBDIR}/libespeak.so.1 ${ESPEAKLIBDIR}/libespeak.so.1
echo 'Adding speakup_soft to /etc/modules...'
echo -e "\n# Load speakup_soft at boot\nspeakup_soft\n\n" >> /etc/modules
echo 'Load it for this session...'
modprobe speakup_soft
echo 'Making the piespeakup connector...'
make
make install
echo 'Enabling the piespeakup service...'
update-rc.d piespeakup defaults
echo 'Starting it for this session...'
service piespeakup start
echo 'You should now have speech in the console with no stuttering!'
exit 0



