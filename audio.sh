#!/bin/bash

amixer -q sset 'Master' unmute
amixer -q sset 'Master' 100%
amixer -q sset 'PCM' unmute
amixer -q sset 'PCM' 100%
amixer -q sset 'Front' unmute
amixer -q sset 'Front' 100%
amixer -q sset 'Headphone' unmute
amixer -q sset 'Headphone' 100%
amixer -q sset 'Speaker' unmute
amixer -q sset 'Speaker' 100%
amixer -q sset 'Bass Speaker' unmute
amixer -q sset 'Bass Speaker' 100%
amixer -q sset 'Mono' unmute
amixer -q sset 'Mono' 100%
mplayer ./sound.mp3
