#!/bin/bash

#This script allows the user to safely overwrite a disk with zeroes using a slax Live USB.

#Require an argument
if [ -z $1 ]; then
    echo "Please enter the device as an argument."
    exit
fi

slaxdev=$(lsblk | grep "/mnt/live/memory/data")
contains=$(echo $slaxdev | grep -v $1)

#if $1 is not the slax live device
if [ -n $contains ]; then
    dd bs=4M if=/dev/zero of=/dev/$1 && sync
else
    echo "You're trying to wipe the slax usb. Quit it." 
fi
