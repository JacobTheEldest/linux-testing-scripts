#!/bin/bash

# Write to variables
serial=$(dmidecode -t 1 | grep "Serial\ Number" | awk '{print $NF}')

# Encodes the variables field into appropriate files
if [ ! -d /tmp/systeminfo/ ]; then
	mkdir /tmp/systeminfo
fi
rm -f /tmp/systeminfo/* #Clear the directory before creating new files
qrencode -l H -o /tmp/systeminfo/serial.png "$serial"

# Display QR Codes
echo "You can cycle through the QR Codes with the arrow keys."
eog /tmp/systeminfo/serial.png
