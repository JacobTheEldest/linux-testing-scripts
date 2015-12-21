#!/bin/bash

#Delete any existing test data
if [ -d /tmp/webcam/ ]; then
	rm -rf /tmp/webcam/*
	rm dir /tmp/webcam
fi

#create temporary directory for test files.
mkdir /tmp/webcam

#capture image (silence terminal output (stderr channel))
fswebcam /tmp/webcam/test.jpeg 2> /dev/null

#Check if a file exists
if [ -a /tmp/webcam/test.jpeg ]; then
	echo "Pass!"
else
	echo "Fail!"
fi
