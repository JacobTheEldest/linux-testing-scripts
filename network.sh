#! /bin/bash

#count the number of slots (empty and full)
#total=$(dmidecode -t memory | grep "Number Of Devices:" | awk {'print $4'})
total=$(lshw -class network | grep "description" | wc -l)

echo
echo "Number of interfaces: $total"
echo
lshw -class network | grep -iE -m 4 "description|vendor|product|capabilities"
echo
lshw -class network | grep -iE "description|vendor|product|capabilities" | tail -4
echo
