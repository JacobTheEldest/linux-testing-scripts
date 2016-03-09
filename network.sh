#! /bin/bash

lshw -class network | grep -iE "description|vendor|product"
