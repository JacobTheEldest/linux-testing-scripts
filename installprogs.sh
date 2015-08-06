#!/bin/bash

program_exists () {
    type "$1" &> /dev/null ;
}

if program_exists pacman; then
    pacman -S --noconfirm git mplayer qrencode bc fswebcam eog hdparm lshw alsa-utils
elif program_exists apt-get; then
    apt-get install -y git mplayer qrencode bc fswebcam eog hdparm lshw alsa-utils
else
    echo "Cannot detect Package Manager. Install git, alsa-utils, lshw, mplayer, bc, eog, hdparm, fswebcam, and qrencode manually."
fi
