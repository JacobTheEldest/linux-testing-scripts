#!/bin/bash

program_exists () {
    type "$1" &> /dev/null ;
}

if program_exists pacman; then
    pacman -S --noconfirm git mplayer qrencode bc fswebcam hdparm lshw alsa-utils cdrkit
elif program_exists apt-get; then
    apt-get update
    apt-get install -y git mplayer2 qrencode bc fswebcam hdparm lshw alsa-utils
else
    echo "Cannot detect Package Manager. Install git, cdrkit, alsa-utils, lshw, mplayer, bc, hdparm, fswebcam, and qrencode manually."
fi
