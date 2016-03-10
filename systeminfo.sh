#! /bin/bash

echo
dmidecode -t 1 | grep -iE "Manufacturer:|Product Name:|Serial Number:"
echo
