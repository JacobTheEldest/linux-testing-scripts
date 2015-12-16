#!/bin/bash

#create Master File
#strip all but the keycode name and number
#dumpkeys | grep = | grep -vE 'alt|control|nul|string'
#!!!Create Code

#remove temp files from previous keytest
rm -rf /tmp/keytest/* > /dev/null
rmdir /tmp/keytest > /dev/null

#Make keytest temp log file directory
mkdir /tmp/keytest

#Wait for user to acknowledge they are ready to begin pressing keys
#When ready set test variable to true
#!!!Create Code

#repeat while test variable is set to true
#!!!Create while loop

	#write all keypresses to a log file
	showkey > /tmp/keytest/keylograw

	#Clean up log file
	#Remove duplicate lines and key release lines then remove 'press' from remaining lines
	awk '!x[$0]++' /tmp/keytest/keylograw > /tmp/keytest/keylognodup
	cat /tmp/keylognodup | grep press > /tmp/keytest/keylog
	#!!!Remove 'press' from every line

	#Compare keylog to unpressedkeys file if it exists, else compare to master
	#Write difference to /tmp/keytest/unpressed
	#!!!Create Code

	#Show list of unpressed keys
	cat
