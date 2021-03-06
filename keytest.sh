#!/bin/bash

echo
echo "This test must be run from a TTY"
echo

#remove temp files from previous keytest
if [ -d /tmp/keytest ]; then
	rm -rf /tmp/keytest/* > /dev/null
	rmdir /tmp/keytest > /dev/null
fi

#Make keytest temp log file directory
mkdir /tmp/keytest

#create Master File
#strip all but the keycode name and number
dumpkeys | grep = | grep -vE "alt|control|nul|string" | awk '{print $1, $2, $3, $4}' > /tmp/keytest/master
dumpkeys | grep = | grep -vE "alt|control|nul|string|keycode  69|keycode  70|keycode  84|keycode  86|keycode 101|keycode 112|keycode 116|keycode 117|keycode 118" | awk '{print $1, $2}' > /tmp/keytest/masternoname

#Wait for user to acknowledge they are ready to begin pressing keys
#When ready set test variable to true
test='y'

#repeat while test variable is set to true
while [ $test == 'y' ]; do

	#write all keypresses to a log file
	echo "Press every key you can. Detection will stop 10 seconds after last keypress."
	showkey > /tmp/keytest/keylograw

	#Clean up log file
	#Remove duplicate lines and key release lines then remove 'press' from remaining lines
	awk '!x[$0]++' /tmp/keytest/keylograw | grep press | grep -v any | awk '{print $1, $2}' > /tmp/keytest/keylog

	#Compare keylog to unpressedkeys file if it exists, else compare to master
	#Write difference to /tmp/keytest/unpressed
	if [ -a /tmp/keytest/unpressed ]; then
		sort /tmp/keytest/keylog /tmp/keytest/masternoname | uniq -u > /tmp/keytest/unpressed2
		comm -12 <( sort /tmp/keytest/unpressed2 ) <( sort /tmp/keytest/unpressed ) > /tmp/keytest/unpressed3
		rm /tmp/keytest/unpressed
		mv /tmp/keytest/unpressed3 /tmp/keytest/unpressed
	else
		sort /tmp/keytest/keylog /tmp/keytest/masternoname | uniq -u > /tmp/keytest/unpressed
	fi

	#Show list of unpressed keys
	cat /tmp/keytest/unpressed | awk '{print $0 " = "}' > /tmp/keytest/unpresseddisplay
	grep -f /tmp/keytest/unpresseddisplay /tmp/keytest/master > /tmp/keytest/unpresseddisplay2
	rm /tmp/keytest/unpresseddisplay
	mv /tmp/keytest/unpresseddisplay2 /tmp/keytest/unpresseddisplay
	if [ -s /tmp/keytest/unpresseddisplay ]; then
	    cat /tmp/keytest/unpresseddisplay
    else
        echo "PASS!"
    fi

	#Retry?
	if [ -s /tmp/keytest/unpresseddisplay ]; then
    	echo "Do you want to try again? (y/n)"
	    read -n1 test
    else
        test='n'
	fi

done
