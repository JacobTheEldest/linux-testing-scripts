#!/bin/bash

if [ -n "$(upower -e | grep BAT)" ]; then
    cpus=$(lscpu | grep -v "NUMA" | grep "CPU(s)": | awk {'print $2'})
    i="0"

    while [ $i -lt $cpus ]; do
    	./stress.sh
    	i=$((i + 1))
    done

    ./batteryinfo.sh
    sleep 300
    killall yes
    ./batteryinfo.sh
    
else
    echo "No battery to test."
fi
