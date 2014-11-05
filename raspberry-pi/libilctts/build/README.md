
## Building and Using the libilctts Library ##

First you need to compile and install the library code. From this directory:

	make -C ../src
	sudo make install -C ../src

Now to download and build eSpeak with the new sound interface for this library. 
Again in this directory:

	wget http://sourceforge.net/projects/espeak/files/espeak/espeak-${MAJOR}/espeak-${MAJOR}.${MINOR}-source.zip

	unzip espeak-${MAJOR}.${MINOR}-source.zip

At this point the directory extracted from the zip may have a slightly different 
minor version number than that in the name of the zip file, so, to go to the 
espeak src directory:

	cd $(ls -d espeak*source/src/)

Now copy the new wave_rpi.cpp file from the piespeak directory in this 
repository:

	cp ../../../../piespeak/wave_rpi.cpp .

And copy the new Makefile as well:

	cp ../../../../piespeak/Makefile .

Now build espeak with the new wave file and linking in the ilctts library:

	make
	sudo make install



