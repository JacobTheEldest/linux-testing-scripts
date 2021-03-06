#!/bin/bash

#Script converts:
#Size from MB to GB where appropriate
#Type from DDRx to PCx
#Speed from 'Data transfers per second in millions in MHz' to 'Peak transfer rate in MB/s' (*8)



#count the number of slots (empty and full)
#total=$(dmidecode -t memory | grep "Number Of Devices:" | awk {'print $4'})
total=$(dmidecode -t memory | grep "Memory Device" | wc -l)
for i in $memory_device; do
	total=$((total + 1))
done

#print the info for each module
iteration="0"
while [ $iteration -lt $total ]; do
	iteration=$((iteration + 1))

	# store the results in variables
	bank=$(dmidecode -t memory | grep -m $iteration "Bank Locator:" | tail -1)
	locator=$(dmidecode -t memory | grep -v Bank | grep -m $iteration "Locator:" | tail -1)
	size=$(dmidecode -t memory | grep -vE "Enabled|Maximum" | grep -m $iteration "Size:" | tail -1 | awk {'print $2'})
	form=$(dmidecode -t memory | grep -m $iteration "Form Factor:" | tail -1)
	type=$(dmidecode -t memory | grep -vE "DIMM|Correction" | grep -m $iteration "Type:" | tail -1 | awk {'print $2'})
	speed=$(dmidecode -t memory | grep -v "Current" | grep -m $iteration "Speed:" | tail -1 | awk {'print $2'})

	# convert size into GB if necessary
	if [ $size != "No" ]; then
		if [ $size -gt 512 ]; then
			size=$((size / 1024))
			size="Size: $size GB"
		else
			size="Size: $size MB"
		fi

		# convert Type from DDR to PC
		type=${type:3}
		if [ "$type" = "" ]; then
		    if [ $speed -ge 533 ] && [ $speed -le 800 ]; then
		        type="2"
	        elif [ $speed -ge 1066 ]; then
	            type="3"
	        fi
	    fi
		type="Type: PC$type"

		# convert speed
		speed=$((speed * 8))
		speed=$((speed - (speed % 100)))
		speed="Speed: $speed"

	else
		size="Size: No Memory Module"
		form="Form Factor: No Memory Module"
		type="Type: No Memory Module"
		speed="Speed: No Memory Module"
	fi

	#display the results
	echo
	echo $bank
	echo $locator
	echo $size
	echo $form
	echo $type
	echo $speed
done
echo
