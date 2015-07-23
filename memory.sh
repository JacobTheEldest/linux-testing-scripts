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
	echo
	dmidecode -t memory | grep -m $iteration "Bank Locator:" | tail -1
	dmidecode -t memory | grep -v Bank | grep -m $iteration "Locator:" | tail -1
	dmidecode -t memory | grep -m $iteration "Size:" | tail -1
	dmidecode -t memory | grep -m $iteration "Form Factor:" | tail -1
	dmidecode -t memory | grep -v Correction | grep -m $iteration "Type:" | tail -1
	dmidecode -t memory | grep -m $iteration "Speed:" | tail -1
done
