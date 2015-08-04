#!/bin/bash

sysserial=$(dmidecode -t 1 | grep Serial)
git pull
changed="no"

if grep -Fxq "$sysserial" ./logcpu.txt > /dev/null; then
	echo "Serial already exists in logcpu.txt"
else
	echo "$sysserial" >> logcpu.txt
	./cpu.sh >> logcpu.txt
	echo >> logcpu.txt
	echo "Entry added to logcpu.txt"
	changed="yes"
fi

if grep -Fxq "$sysserial" ./loggraphics.txt > /dev/null; then
	echo "Serial already exists in loggraphics.txt"
else
	echo "$sysserial" >> loggraphics.txt
	./graphics.sh >> loggraphics.txt
	echo >> loggraphics.txt
	echo "Entry added to loggraphics.txt"
	changed="yes"
fi

if [ $changed = "yes" ]; then
	echo "Preparing to push log updates."
	git add logcpu.txt loggraphics.txt
	git commit -m "Added $sysserial to log files"
	git push
fi
