#!/bin/bash

# Create autologin group and add root user to it
groupadd -r autologin
gpasswd -a root autologin

# copy config enabling autologin
cp dmconf /etc/lightdm/lightdm.conf
