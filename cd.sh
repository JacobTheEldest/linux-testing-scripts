#!/bin/bash

cddir=""

while [ "$cddir" = "" ]; do
	cddir=$(lsblk | grep sr0 | awk {'print $7'})
done

ls $cddir
