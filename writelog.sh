#!/bin/bash

dmidecode -t 1 | grep Serial >> logcpu.txt
./cpu.sh >> logcpu.txt

dmidecode -t 1 | grep Serial >> loggraphics.txt
./graphics.sh >> loggraphics.txt
