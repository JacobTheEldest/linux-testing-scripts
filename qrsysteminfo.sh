#!/bin/bash

# Write to variables
serial=$(dmidecode -t 1 | grep "Serial\ Number" | awk '{print $NF}')

# Encodes the variables field into appropriate files
if [ ! -d /tmp/systeminfo/ ]; then
	mkdir /tmp/systeminfo
fi
rm -f /tmp/systeminfo/* #Clear the directory before creating new files
qrencode -t UTF8 -o /tmp/systeminfo/qrserial.txt "$serial"

# Display QR Codes
echo "Serial Number"
cat /tmp/systeminfo/qrserial.txt
