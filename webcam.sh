#!/bin/bash

if [ ! -d /tmp/webcam/ ]; then
	mkdir /tmp/webcam
fi
rm -f /tmp/webcam/* #Clear the directory before creating new files

fswebcam /tmp/webcam/test.jpeg
eog /tmp/webcam/test.jpeg
