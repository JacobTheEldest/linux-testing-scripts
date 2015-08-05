#!/bin/bash

program_exists () {
    type "$1" &> /dev/null ;
}

if program_exists pacman; then
    pacman -S --noconfirm git mplayer qrencode bc fswebcam eog hdparm
elif program_exists apt-get; then
    apt-get install -y git mplayer qrencode bc fswebcam eog hdparm
else
    echo "Cannot detect Package Manager. Install git, mplayer, bc, eog, hdparm, fswebcam, and qrencode manually."
fi
