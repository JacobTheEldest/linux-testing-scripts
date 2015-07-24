#!/bin/bash

hdparm -I /dev/sda | grep -E "Number|GB|Rate"
