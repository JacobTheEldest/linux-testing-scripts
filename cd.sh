#!/bin/bash

if [ -d "/media/ubuntu/" ]; then
	while [ 1 ]; do
		ls /media/ubuntu/
	done
else
	while [ 1 ]; do
		ls /media/
	done
fi
