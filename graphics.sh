#!/bin/bash

echo
lshw -C video | grep -E "product|vendor"
echo
