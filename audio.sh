#!/bin/bash

amixer sset 'Master' 100%
amixer sset 'Front' 100%
amixer sset 'Headphone' 100%
mplayer ./sound.mp3
