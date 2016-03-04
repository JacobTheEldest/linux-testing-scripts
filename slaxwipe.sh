#!/bin/bash

#This script allows the user to safely overwrite a disk with zeroes using a slax Live USB.

#Require an argument
if [ -z $1 ]; then
    echo "Please enter the device to be wiped as an argument."
    exit
fi

slaxdev=$(lsblk | grep "/mnt/live/memory/data")
slaxdev=$(echo "{slaxdev:2: -1}")

#if $1 is the slax live device
if [ $1 = $slaxdev ]; then
    echo "You're trying to wipe the slax usb. Quit it."
    exit
else
    dd bs=4M if=/dev/zero of=/dev/$1 && sync
fi
