#!/bin/bash

cp ttyservice /usr/lib/systemd/system/autologin\@.service
systemctl disable getty@tty1
systemctl enable autologin@tty1
systemctl start autologin@tty1
