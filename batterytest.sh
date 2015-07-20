#!/bin/bash

upower -i $(upower -e | grep BAT); sleep 300; killall yes; upower -i $(upower -e | grep BAT)
