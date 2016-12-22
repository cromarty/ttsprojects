#!/bin/bash
#
# Install dependancies and make and install piespeakup
#


# Detect type of Linux and act accordingly
OS=`uname -r`
Processor=`uname -m`

case "${OS}" in
	*ARCH)
		echo 'Running on Arch Linux...'
		ArchLinux=1
		Raspbian=0
		ESPEAKLIBDIR=/usr/lib
		PACKAGEINSTALLER="pacman -S --noconfirm --noprogressbar --needed "
	;;
	*)
		echo 'Not running on Arch Linux...'
		ArchLinux=0
		Raspbian=1
		ESPEAKLIBDIR=/usr/lib/arm-linux-gnueabihf
		PACKAGEINSTALLER="apt-get install -yyq "
esac

if [ `whoami` != 'root' ]; then
   echo "script must be run as root, try: 'sudo ./$(basename $0)'"
   exit 1
fi

echo 'Checking whether the piespeakup service is running...'
if [ $ArchLinux -eq 1 ]; then
	echo 'Arch: Using systemctl to check...'
	systemctl --quiet is-active piespeakup
elif [ $Raspbian -eq 1 ]; then
	echo 'Not Arch: Using SysVInit to check...'
	service piespeakup status >/dev/null 2>&1
fi

if [ $? -eq 0 ]; then
	echo 'Stopping the piespeakup service...'
	if [ $ArchLinux -eq 1 ]; then
		echo 'Arch: Using systemctl to stop it...'
		systemctl stop piespeakup
	elif [ $Raspbian -eq 1 ]; then
		echo 'Not Arch: Using SysVInit to stop it...'
		service piespeakup stop
	fi
fi

echo 'Checking to see if espeak is installed...'
which espeak >/dev/null 2>&1
if [ $? -ne 0 ]; then
   echo 'espeak is not installed, installing it...'
   $PACKAGEINSTALLER espeak
fi

set -e
if ! [ -L ${ESPEAKLIBDIR}/libespeak.so ]; then
	echo 'Fixing the missing espeak lib soft-link...'
	ln -s ${ESPEAKLIBDIR}/libespeak.so.1 ${ESPEAKLIBDIR}/libespeak.so
fi

if [ $ArchLinux -eq 1 ]; then
	# piespeakup is looking for /usr/local/lib/libilctts.so on arch and not finding it, linking it to find it.
	ln -s /usr/local/lib/libilctts.so /usr/lib
	if [ -z "$(grep speakup_soft /etc/modules-load.d/raspberrypi.conf)" ]; then
		echo 'Adding speakup_soft to the end of /etc/modules-load.d/raspberrypi.conf...'
		echo -e "\n# Load speakup_soft at boot\nspeakup_soft\n\n" >> /etc/modules-load.d/raspberrypi.conf
	fi
elif [ $Raspbian -eq 1 ]; then
	if [ -z "$(grep speakup_soft /etc/modules)" ]; then
		echo 'Adding speakup_soft to the end of /etc/modules...'
		echo -e "\n# Load speakup_soft at boot\nspeakup_soft\n\n" >> /etc/modules
	fi
fi

echo 'Load it for this session...'
modprobe speakup_soft

echo 'Making the piespeakup connector...'
# Are we running on a Raspberry Pi2?
# If so, lets make use of it.
if [ $Processor == 'armv7l' ]; then
	make -j 5
else
	make
fi

echo 'Installing the piespeakup connector...'
if [ $ArchLinux -eq 1 ];then
	make archinstall
elif [ $Raspbian -eq 1 ]; then
	make raspbianinstall
fi

echo 'Enabling the piespeakup service...'
if [ $ArchLinux -eq 1 ]; then
	systemctl enable piespeakup
elif [ $Raspbian -eq 1 ]; then
	update-rc.d piespeakup defaults
fi

echo 'Starting it for this session...'
if [ $ArchLinux -eq 1 ];then
	systemctl start piespeakup
elif [ $Raspbian -eq 1 ]; then
	service piespeakup start
fi

echo 'You should now have speech in the console with no stuttering!'
exit 0



