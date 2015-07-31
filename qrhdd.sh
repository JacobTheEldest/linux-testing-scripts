#!/bin/bash

# Tests whether the "Model Number:" field includes the manufacturer name
col4=$(hdparm -I /dev/sda | grep "Model\ Number" | awk '{print $4}')

# Write HDD fields to variables
if [ -n "$col4" ] ; then
	hddmanu=$(hdparm -I /dev/sda | grep "Model\ Number" | awk '{print $3}')
	hddmodelnumber=$(hdparm -I /dev/sda | grep "Model\ Number" | awk '{print $4}')
else
	hddmodelnumber=$(hdparm -I /dev/sda | grep "Model\ Number" | awk '{print $3}')
fi
hddserial=$(hdparm -I /dev/sda | grep "Serial\ Number" | awk '{print $NF}')
hddrate=$(hdparm -I /dev/sda | grep Rate | awk '{print $NF}')
hddsize=$(hdparm -I /dev/sda | grep GB | awk '{print $(NF-1)}')
hddsize=${hddsize:1}

# Encodes the "Model Number:" field into appropriate files
if [ ! -d /tmp/qrhdd/ ]; then
	mkdir /tmp/qrhdd
fi
rm /tmp/qrhdd/* #Clear the directory before creating new files
qrencode -l H -o /tmp/qrhdd/0HDDManu.png $hddmanu
qrencode -l H -o /tmp/qrhdd/1HDDModelNumber.png $hddmodelnumber
qrencode -l H -o /tmp/qrhdd/2HDDSerialNumber.png $hddserial
qrencode -l H -o /tmp/qrhdd/3HDDSize.png $hddsize
qrencode -l H -o /tmp/qrhdd/4HDDRate.png $hddrate

# Display QR Codes
echo "You can cycle through the QR Codes with the arrow keys."
if [ -e /tmp/qrhdd/0HDDManu.png ]; then
	eog /tmp/qrhdd/0HDDManu.png
else
	eog /tmp/qrhdd/1HDDModelNumber.png
fi
