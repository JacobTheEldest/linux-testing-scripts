#!/bin/bash

echo
echo
echo
echo "Use './master.sh l' for laptops."
echo

# Info Scripts
echo
echo "System Information:"
./systeminfo.sh
read -n1 test

echo
echo "Monitor Information:"
./monitor_info.sh
read -n1 test

echo
echo "Processor:"
./cpu.sh
read -n1 test

echo
echo "Memory:"
./memory.sh
read -n1 test

echo
echo "Battery:"
./batteryinfo.sh
read -n1 test

echo
echo "Networking:"
./network.sh
read -n1 test

echo
echo "Graphics:"
./graphics.sh
read -n1 test

echo
echo "Hard Drive:"
./hddinfo.sh sda
read -n1 test

echo
echo "Audio Test"
./audio.sh
read -n1 test

if [ "$1" = 'l' ]; then
    echo
    echo "Keyboard Test"
    ./keytest.sh
    read -n1 test

    echo
    echo "Monitor Test"
    ./monitor_test.sh
    read -n1 test

    echo
    echo "Webcam Test"
    ./webcam.sh
fi
