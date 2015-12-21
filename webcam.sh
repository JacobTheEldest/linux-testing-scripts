#!/bin/bash

if [ ! -d /tmp/webcam/ ]; then
	mkdir /tmp/webcam
fi
rm -f /tmp/webcam/* #Clear the directory before creating new files

fswebcam /tmp/webcam/test.jpeg 2> /dev/null
if [ -a /tmp/webcam/test.jpeg ]; then
	echo "Pass!"
else
	echo "Fail!"
fi
