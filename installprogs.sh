#!/bin/bash

program_exists () {
    type "$1" &> /dev/null ;
}

if program_exists pacman; then
    pacman -S --noconfirm git mplayer qrencode
elif program_exists apt-get; then
    apt-get install -y git mplayer qrencode
else
    echo "Cannot detect Package Manager. Install git, mplayer, and qrencode manually."
fi