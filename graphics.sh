#!/bin/bash

lshw -C video | grep -E "product|vendor"
