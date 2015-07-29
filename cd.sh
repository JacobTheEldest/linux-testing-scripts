#!/bin/bash

./eject.sh
echo "Insert CD and close tray."

cddir=""

while [ "$cddir" = "" ]; do
	cddir=$(lsblk | grep sr0 | awk {'print $7'} | awk -F '[/]' {'print $NF'})
done

echo "Name of CD: $cddir"
echo "Pass"
sleep 1
./eject.sh
