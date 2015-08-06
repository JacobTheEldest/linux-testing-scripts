#!/bin/bash

./eject.sh
echo
echo "Insert CD and close tray."

cddir=""
while [ "$cddir" = "" ]; do
	cddir=$(dd status=none if=/dev/sr0 bs=1 skip=32808 count=32 2>/dev/null)
done

echo
echo "Name of CD: $cddir"
echo "Pass"
sleep 1
./eject.sh
