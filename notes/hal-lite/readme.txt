Hal Lite Screen Reader
User's Guide

Dolphin systems for people with disabilities
PO Box 83
Worcester  WR3 8TU  U.K.
Tel: 01905 754577   Int: +44 1905 754577
Fax: 01905 754559  Int: +44 1905 754559

hlitpman1095


Table of Contents


1. INTRODUCTION 
2. INSTALLING Hal Lite 
2.1 Installing Environments     
3. RUNNING Hal Lite   
4. USING Hal Lite      
4.1 How to read the manuals on your Hal Lite disk       
4.2 Using environment files with Hal Lite       
5. COMMAND SUMMARY      
5.1 Commands available in live mode     
5.2 Commands available in reading mode  
5.3 Other commands      
5.4 Screen reading with cursor keys in reading mode     
6. SPECIAL FEATURES     
6.1 Command line entries        
7. LICENSE AGREEMENT    

1. Introduction

Hal Lite is a screen reader which addresses the needs of computer users who 
are unable to take advantage of more advanced products such as HAL5.

It is a very cut-down version of our old product, HAL version 4, and is 
intended for use on computers with the 8086, 8088, or 80286 processor, and 
having only 512Kb or 640Kb of memory (RAM).  It features all of the screen 
reading capabilities of HAL version 4, but with the omission of several 
inessential features of that product.  All of the HAL version 4 environment 
files are included with the product, thus ensuring that you have the correct 
configuration for your own applications package.

Relative to HAL version 4, we have also cut down the amount of documentation.  
In print, you will find a guide to installing and running Hal Lite, and a 
command summary.  Other information, including full details of how to adjust 
Hal Lite's parameters, and how to write your own environment files, are 
included in machine readable (ASCII) text on the Hal Lite disks.

2. Installing Hal Lite

If you have purchased an ORION computer with Hal Lite from Dolphin

There is no need for you to install Hal Lite yourself - it will have been set 
up for you.

If you already own a computer and have bought Hal Lite separately

You will only need the Hal Lite disks and:

* An IBM XT or higher specification computer.
* MS-DOS 3.2 or higher.
* A Dolphin Series 2 Synthesiser.

To install Hal Lite you must use the installation program supplied. 

Using the Installation Program:

* Turn on the computer.
* Insert the Hal Lite Master disk into drive A: or B:
* Log on to the appropriate drive.
* Remove from memory any screen reading software that is currently running.
* At the DOS prompt type:

INSTALL  -port    <ENTER>

Where -port is the serial port to which your synthesiser is connected, or the 
location of your internal speech card.

If you do not specify a port, the installation program will automatically 
search for a synthesiser on your COM ports and card slots.

Here are the valid values for port:

For a synthesiser connected to a serial port

-1      selects COM1
-2      selects COM2
-3      selects COM3
-4      selects COM4

For an internally fitted synthesiser

-cd     selects PC 2 card in first position (address 308 hex)
-c2d    selects PC 2 card in second position (address 318 hex)

If you have a Braille display, or otherwise wish the installation not to 
'talk'

-n      provides no speech output during the installation.

* Once the program has loaded, you will be asked to enter your name.  The 
name entered must be two words, each word being two or more letters.  
Punctuation and graphics characters are not allowed.

At this stage you may find a couple of keystrokes helpful: 

To get help on the current operation, press:
<F1>

To mute what is currently being said by the speech synthesiser, press:
<TAB>

* The installation program will ask you if you want to run SETSYNTH.  If you 
wish to change the voice characteristics of your speech synthesiser then you 
should choose 'Yes', if you do not then the default settings will be used.
After installation has completed you will then be prompted to press any key 
to return to DOS.

You must now re-boot your machine before running Hal Lite.

* If for some reason you experience difficulty in installing Hal Lite, please 
consult the `Trouble Shooting Guide' on the Hal Lite disks.

2.1 Installing Environments

Installing environments for your application

When Hal Lite was installed onto your computer, environment files for 40 or 
so of the most popular PC packages were also copied onto your system.

Environment files configure Hal Lite to work optimally with a wide range of 
applications software and are available for all the commonly-used word 
processors, spreadsheets, databases, communications packages, and other 
applications.

To copy the environments and `Getting Started' guide for a particular 
application into your Hal Lite directory, at the DOS prompt type:

INSTENVS  <ENTER>

You will be given a list A to Z of the applications for which environments 
exist.  Simply press the appropriate letter to install the selected 
environments or press <3> to exit to DOS.

The `Getting Started' guides supplied with the environment files contain 
specific information on using Hal Lite with that application.

3. Running Hal Lite

To run Hal Lite, type:
HLITE <ENTER>

You need an environment file in order to make Hal Lite work correctly with 
your application.  If you know the name of the environment file that you 
wish to load at the time of running Hal Lite you can enter this name from the 
command line.  For example, to run the main environment file for WordPerfect 
5.1, at the DOS prompt, type:

HLITE -FWP51MAIN.HAL

Hal Lite will then load with the startup environment file for WordPerfect 5.1.

4. Using Hal Lite

You should now have Hal Lite installed and running.  Your keys should 'speak' 
as you press them and certain parts of the screen will automatically be 
spoken to you.  You should now refer either to the Hal Lite command summary, 
or to the getting started guide for your particular application.

4.1 How to read the manuals on your Hal Lite disk

We have supplied a program on your synthesiser disk called VIEW, which 
enables you to read the ASCII text file version of this or any other manual 
using Hal Lite and your synthesiser.  To read your Hal Lite manual:

1.      Install Hal Lite in the manner described.

2.      At the DOS prompt type:

	VIEW HLITE.TXT    <ENTER>

3.      Finally, to start Hal Lite reading your manual, press:

	<ALT> and <P>, then <C>


4.2 Using environment files with Hal Lite

If you did not load an environment file at the time of running Hal Lite, you 
will need to do so in order to get the most from Hal Lite and your 
application.  You will have installed environments for your application into 
your Hal Lite directory.  You now need to load one of these, depending on 
which application you are running.  To load an environment file:

* Hold down the <ALT> key and tap and release <F>

Hal Lite will respond with 'load or save?'.  Type <L> for load and then enter 
the name of the environment file you wish to load.  You can do this before 
running your application or from within your application.  Once the first 
environment file is loaded in this way, you will find that other environment 
files are loaded automatically as you use different screens within your 
application.  You should now find that you can use your application 
satisfactorily making some reference to the brief command summary that 
follows.

If you wish to know more about Hal Lite in depth, you could read the manual 
on disk, which will teach you how to set up Hal Lite for yourself.

5. Command Summary

In this command summary we will refer to Hal Lite being used in 'live mode' 
or 'reading mode'.  While you are using your application, moving around 
within its screens, and listening to Hal Lite tell you what is on the screen, 
this is 'live mode'.  If for any reason you wish to 'freeze' your application 
and to take a closer look at what is written on the screen then you will need 
to enter reading mode.  'Reading mode' lets you move your cursor to parts of 
the screen that you may not be able to go to in live mode and to navigate 
around the screen a single character position at a time.

5.1 Commands available in live mode

Use these commands to read different parts of your screen whilst you are 
using your application.  Remember also to refer to the 'Getting Started' 
guide in your Hal Lite directory, for more detailed information on using 
Hal Lite with your particular package.

All of the following commands use the <ALT> key.  When we write <ALT> and <Q> 
for example, this means hold down the <ALT> key and tap and release the <Q> 
key.
 
Read the character at the cursor position.  Pressing this character a second 
time will read the phonetic equivalent of the character.
<ALT> and <I>

Read the word at the cursor position.  Pressing this a second time will 
spell the word.
<ALT> and <O>

Read text up to the current cursor location.
<ALT> and <K>

Read the current line of text.
<ALT> and <L>

Increase the volume of the speech
<ALT> and <X>

Decrease the volume of the speech.
<ALT> and <Z>

Mute the synthesiser
<ALT> and <M>

Set the speed of the speech.
<ALT> and <S>

Restore default speech settings
<ALT> and <B>

Read the and column where the cursor is positioned.
<ALT> and <G>

Read a window.  This key will prompt you for a window number. To read the 
whole screen choose window 0.  To abort press any other key.
<ALT> and <P>

Search the highlight window for any highlighted text, and read it.  Pressing 
this a second time will spell the highlighted text.
<ALT> and <Y>

Toggle speech on and off.
<ALT> and <V>

Load and save environment files.
<ALT> and <F>

Allow the next character through.
<ALT> and <N>

Enter reading mode.
<ALT> and <J>

5.2 Commands available in reading mode

Go to top of screen
<T>

Go to bottom of the screen
<B>

Go up a line
<U>

Go down a line
<D>

Go to start of line
<S>

Go to end of line
<E>

Go to home position (e.g. where you entered screen reading)
<H>

Read from the cursor position to the end of the line
<L>

Read word
<R>

Back a word (no speech)
<Q>

Read character at cursor position, and move right by a character
<C>

Left one character (no speech)
<,>

Right one character (no speech)
<.>

Set marker specified by the next letter
<M>

Go to marker specified by the next letter
<G>

This will tell you the state of your lockable keys i.e. caps lock, numlock, 
insert, and scroll lock.
<@>

This will tell you the current column of the cursor
<X>

This will tell you the current row of the cursor
<Y>

This will tell you the ASCII value of the character under the cursor, and 
its attributes
<A>

Find a character
<F>

Initiates string search.
</>

5.3 Other commands
 
Enters parameter menu
<P>

Defines or enters a window
<W>

Teaches a key
<CTRL> and <T>

Gives the version number of Hal Lite. Pressing it a second time in screen 
reading mode will cause the serial number of the copy of Hal Lite that you 
are using to be spoken.

(You need to know about this function, because Dolphin offers a free 
telephone support service to its registered users, and you will need to quote 
your serial number in order to be eligible for support.)
<CTRL> and <N>

Exits reading mode (this is an alternative to <ENTER>)
<CTRL> and <M>

Set soft cursor
<CTRL> and <C>

Teaches a screen character
<CTRL> and <S>

Enter monitor marker menu
<CTRL> and <W>

Exits reading mode
<ENTER>

Set whether <DEL> works on current or previous character
<DEL>

Alters the voice characteristics
Function keys

Reads the current Hal Lite environment filename.
<?>

5.4 Screen reading with cursor keys in reading mode
 
This takes the cursor to the start of  the current line
<HOME>

This takes the cursor to the end of the current line
<END>

This takes the cursor to the top left hand corner of the screen
<PgUp>

This takes the cursor to the bottom left hand corner of the screen
<PgDn>

This takes the cursor left by a character, and speaks the character
<left cursor>

Takes the cursor right by a character, and speaks the character 
<right cursor>

Takes the cursor up by a line, and speaks the new line
<curosr up> 

Takes the cursor down by a line, and speaks the new line
<cursor down>

Takes the cursor left by a word and speaks the word
<CTRL> and <cursor left> 

Takes the cursor right by a word and speaks the word.
<CTRL> and <cursor right> 

6. Special Features

This section completes the description of Hal Lite's basic command set and 
describes some special features not mentioned in the earlier lessons.  Most 
users may never need to know about these features.

6.1 Command line entries
 
All additional command line entries beyond the Hal Lite program name are 
separated by a space and the dash sign -.  It is important to note that this 
is not the underline character.

Remove Hal Lite from the system

HLITE  -r

Load the environment filename in to Hal Lite

HLITE  -ffilename

For files which have no path, e.g. hal.spc, prompt.hal and english.dic, this 
is the absolute "path" to be used

HLITE  -dpath

Set absolute path to the current directory

HLITE  -d

Load the prompt file filename

HLITE  -pfilename

Load the default Exceptions Dictionary 
english.dic
HLITE  -a

Load the Exceptions Dictionary "filename"

HLITE  -afilename

Bypass test for valid directory. (Needed for networks)

HLITE  -n

Where ## is the size in kilobytes of the largest Exceptions Dictionary 
needed

HLITE  -m##

Send speech output to PC 2 card (default address)

HLITE  -c

Send speech output to PC 2 card (secondary address)

HLITE  -c2

Send speech output to Apollo 2/Juno on COM1.

HLITE  -1

Send speech output to Apollo 2/Juno on COM2.

HLITE  -2

Send speech output to Apollo 2/Juno on COM3.

HLITE  -3

Send speech output to Apollo 2/Juno on COM4.

HLITE  -4

Disable monitor markers from firing in 'graphics mode'.

HLITE  -KG

Some HAL users experience a scrambled screen when using the 'graphics mode' 
page preview facility of WordPerfect.  If you experience this problem, then 
use the -KG command line option.

The following options can be used on the command line of a currently running 
Hal Lite.

	HLITE  -dpath
	HLITE  -ffilename
	HLITE  -pfilename
	(see above for details)

7. License Agreement 

Please see the README.TXT  file on your Hal Lite disk for details of any 
changes to Hal Lite since this manual was produced.

Licenses

This is a licensed product a Dolphin Systems Ltd 1995.  This program is 
usually licensed to a single user for installation on up to three machines at 
any one time.  If you have bought a `site license' you may use the program 
on one site on as many machines as the license will allow.  If you have a 
`network file server' version of the program a separate license agreement is 
supplied with it.  This defines how many users of your network are permitted 
to access the program.

Disclaimer

Dolphin gives no warranties with respect to the contents of this package in 
the case of any bugs or errors.  However, if you find any please let us know 
and we will try to fix them.  We also reserve the right to revise and update 
both this publication and product without prior notification.


Future Developments 

We do hope to keep you informed of future developments of this program.

* The free tape magazine, "The Whistler", will help you to keep in touch with 
what is going on - please telephone us for details.

* Dolphin's own newsletter, `SPLASH!', will contain information on new 
product releases from time to time.

* We try to keep users informed of developments by advertising in specialist 
publications.  However, these are periodicals and if you want to know the 
latest on our products please telephone us.

Trademarks

Any trademarks referred to in the Hal Lite program or documentation are the 
property of their respective companies.

