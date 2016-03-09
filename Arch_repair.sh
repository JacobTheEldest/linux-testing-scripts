#!/bin/bash

#Ensure that there is a valid argument
if [ -z $1 ]; then
    echo "Enter the target device as an argument"
    exit 1
fi

fsck -y /dev/${1}1
