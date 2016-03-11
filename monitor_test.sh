#!/bin/bash

echo
echo "Press any key to cycle through colors.  Press q to quit."
echo

#init variables
test='y'
color=1

#loop until 'q' is pressed
while [ "$test" != 'q' ]; do
	#wait for keypress before beginning (opportunity for ending loop with 'q')
	read -n1 test

	#display colors in sequence
	if [ $color -eq 0 ]; then
		setterm -background black
		clear
	elif [ $color -eq 1 ]; then
		setterm -background white
		clear
	elif [ $color -eq 2 ]; then
		setterm -background red
		clear
	elif [ $color -eq 3 ]; then
		setterm -background green
		clear
	elif [ $color -eq 4 ]; then
		setterm -background blue
		clear
	fi

	#increment color count
	color=$((color+1))

	#reset color to beginning if past end of cycle
	if [ $color -eq 5 ]; then
		color=0
	fi

done

#reset color to black when done
setterm -background black
clear
