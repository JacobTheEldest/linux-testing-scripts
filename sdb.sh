#!/bin/bash

hdparm -I /dev/sdb | grep -E "Number|GB|Rate"
