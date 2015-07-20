#!/bin/bash


col4=$(hdparm -I /dev/sda | grep "Model\ Number" | awk '{print $4}')
modelexists=$(expr length "$col4")

if $modelexists
then
	qrencode -l H -o /tmp/HDDModelNumber.png $(hdparm -I /dev/sda | grep "Model\ Number" | awk '{print $3}'); eog /tmp/HDDModelNumber.png
else
	qrencode -l H -o /tmp/HDDModel.png $(hdparm -I /dev/sda | grep "Model\ Number" | awk '{print $3}'); eog /tmp/HDDModel.png
	qrencode -l H -o /tmp/HDDModelNumber.png $(hdparm -I /dev/sda | grep "Model\ Number" | awk '{print $4}'); eog /tmp/HDDModelNumber.png
fi

qrencode -l H -o /tmp/HDDSerialNumber.png $(hdparm -I /dev/sda | grep "Serial\ Number" | awk '{print $NF}'); eog /tmp/HDDSerialNumber.png

qrencode -l H -o /tmp/HDDRate.png $(hdparm -I /dev/sda | grep Rate | awk '{print $NF}'); eog /tmp/HDDRate.png

hdparm -I /dev/sda | grep GB | awk '{print $(NF-1),$NF}'
