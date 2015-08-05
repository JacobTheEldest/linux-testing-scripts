#!/bin/bash

program_exists () {
    type "$1" &> /dev/null ;
}

if program_exists pacman; then
    pacman -S --noconfirm git mplayer qrencode bc
elif program_exists apt-get; then
    apt-get install -y git mplayer qrencode bc
else
    echo "Cannot detect Package Manager. Install git, mplayer, and qrencode manually."
fi
