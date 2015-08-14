#!/bin/bash

amixer sset 'Master' unmute
amixer sset 'Master' 100%
amixer sset 'Front' unmute
amixer sset 'Front' 100%
amixer sset 'Headphone' unmute
amixer sset 'Headphone' 100%
amixer sset 'Speaker' unmute
amixer sset 'Speaker' 100%
amixer sset 'Bass Speaker' unmute
amixer sset 'Bass Speaker' 100%
mplayer ./sound.mp3
