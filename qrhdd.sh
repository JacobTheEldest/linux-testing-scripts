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

# Adjust the variables to match what the database expects
if [ "$hddmanu" = "WDC" ]; then
	hddmanu="Western Digital"
fi

if [ "$hddmanu" = "Hitachi" ]; then
	hddmanu="HGST"
fi

if [ $hddsize -ge 1000 ] && [ $hddsize -le 1024 ]; then
	hddsize="1 TB"
elif [ $hddsize -ge 2000 ] && [ $hddsize -le 2048 ]; then
	hddsize="2 TB"
elif [ $hddsize -ge 3000 ] && [ $hddsize -le 3072 ]; then
	hddsize="3 TB"
fi

# Encodes the "Model Number:" field into appropriate files
if [ ! -d /tmp/qrhdd/ ]; then
	mkdir /tmp/qrhdd
fi
rm -f /tmp/qrhdd/* #Clear the directory before creating new files
qrencode -t UTF8 -o /tmp/qrhdd/Manufacturer "$hddmanu"
qrencode -t UTF8 -o /tmp/qrhdd/ModelNumber "$hddmodelnumber"
qrencode -t UTF8 -o /tmp/qrhdd/Size "$hddsize"
qrencode -t UTF8 -o /tmp/qrhdd/RPM "$hddrate"
qrencode -t UTF8 -o /tmp/qrhdd/Serial "$hddserial"

# Display QR Codes
if [ -e /tmp/qrhdd/Manufacturer ]; then
	echo "Manufacturer:"
	cat /tmp/qrhdd/Manufacturer
fi
echo "Model Number:"
cat /tmp/qrhdd/ModelNumber
echo "Size:"
cat /tmp/qrhdd/Size
read -n1
echo "RPM:"
cat /tmp/qrhdd/RPM
echo "Serial Number:"
cat /tmp/qrhdd/Serial

echo
echo
echo "Use Shift + Page Up or Shift + Page Down to scroll."
echo
