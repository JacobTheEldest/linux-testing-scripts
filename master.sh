#!/bin/bash

#Initialize variables
#!!!vars

#Ask user for initial info
#!!!Desktop or laptop

 








# Info Scripts
./batteryinfo.sh $1
./cpu.sh $1
./graphics.sh $1
./hddinfo.sh $1
./memory.sh $1
./network.sh $1
./systeminfo.sh $1

# Test Scripts
./webcam.sh $1
./monitor.sh $1
./keytest.sh $1
./audio.sh $1
./batterytest.sh $1
