#!/bin/bash

#Ensure that there is a valid argument
if [ -z $1 ]; then
    echo "Enter the target device as an argument"
    exit 1
fi

# Tests whether the "Model Number:" field includes the manufacturer name
col4=$(hdparm -I /dev/$1 | grep "Model\ Number" | awk '{print $4}')

# Write HDD fields to variables
if [ -n "$col4" ] ; then
	hddmanu=$(hdparm -I /dev/$1 | grep "Model\ Number" | awk '{print $3}')
	hddmodelnumber=$(hdparm -I /dev/$1 | grep "Model\ Number" | awk '{print $4}')
else
	hddmodelnumber=$(hdparm -I /dev/$1 | grep "Model\ Number" | awk '{print $3}')
fi
hddserial=$(hdparm -I /dev/$1 | grep "Serial\ Number" | awk '{print $NF}')
hddrate=$(hdparm -I /dev/$1 | grep Rate | awk '{print $NF}')
hddsize=$(hdparm -I /dev/$1 | grep GB | awk '{print $(NF-1) " " $NF}')
hddsize=${hddsize:1:-1}

# Adjust the variables to match what the database expects
if [ "$hddmanu" = "WDC" ]; then
	hddmanu="Western Digital"
fi

if [ "$hddmanu" = "Hitachi" ]; then
	hddmanu="HGST"
fi

if [ ${hddsize:0:4} -ge 1000 ] && [ ${hddsize:0:4} -le 1024 ]; then
	hddsize="1 TB"
elif [ ${hddsize:0:4} -ge 2000 ] && [ ${hddsize:0:4} -le 2048 ]; then
	hddsize="2 TB"
elif [ ${hddsize:0:4} -ge 3000 ] && [ ${hddsize:0:4} -le 3072 ]; then
	hddsize="3 TB"
fi

# Print the variables
echo
echo "Manufacturer:  $hddmanu"
echo "Model Number:  $hddmodelnumber"
echo "Capacity:      $hddsize"
echo "RPM:           $hddrate"
echo "Serial Number: $hddserial"
echo
