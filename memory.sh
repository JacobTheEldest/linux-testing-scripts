#!/bin/bash

#goal is to display each module's values in this order:
#\n
#Bank Locator:
#Locator:
#Size:
#Form Factor:
#Type:
#Speed:

#Then have the script convert:
#Size from MB to GB where appropriate
#Type from DDRx to PCx
#Speed from 'Data transfers per second in millions' to 'Peak transfer rate in MB/s' (*8)

dmidecode -t memory | grep -E "Locator|Size|Form\ Factor|Type:|Speed" | grep -v "Correction"
