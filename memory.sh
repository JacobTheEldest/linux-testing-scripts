#!/bin/bash

#+goal is to display each module's values in this order:
#+\n
#+Bank Locator:
#+Locator:
#+Size:
#+Form Factor:
#+Type:
#+Speed:

#Then have the script convert:
#Size from MB to GB where appropriate
#Type from DDRx to PCx
#Speed from 'Data transfers per second in millions' to 'Peak transfer rate in MB/s' (*8)

#dmidecode -t memory | grep -E "Locator|Size|Form\ Factor|Type:|Speed" | grep -v "Correction"

#count the number of slots (empty and full)
#total=$(dmidecode -t memory | grep "Number Of Devices:" | awk {'print $4'})
total="0"
memory_device=$(dmidecode -t memory | grep "Memory Device")
for i in $memory_device; do
	total=$((total + 1))
done
total=$((total / 2))

#print the info for each module
iteration="0"
while [ $iteration -lt $total ]; do
	iteration=$((iteration + 1))
	
	# store the results in variables
	bank=$(dmidecode -t memory | grep -m $iteration "Bank Locator:" | tail -1)
	locator=$(dmidecode -t memory | grep -v Bank | grep -m $iteration "Locator:" | tail -1)
	size=$(dmidecode -t memory | grep -vE "Installed|Enabled|Maximum" | grep -m $iteration "Size:" | tail -1 | awk {'print $2'})
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
		echo $type
		type=${type:3}
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
