#!/bin/bash

sysserial=$(dmidecode -t 1 | grep Serial)
git pull

$sysserial >> logcpu.txt
./cpu.sh >> logcpu.txt
echo >> logcpu.txt

$sysserial >> loggraphics.txt
./graphics.sh >> loggraphics.txt
echo >> loggraphics.txt

git add logcpu.txt loggraphics.txt
git commit -m "Added $sysserial to log files"
git push
