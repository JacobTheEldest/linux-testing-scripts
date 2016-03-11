# linux-testing-scripts
Scripts for testing and gathering info with a linux live USB

Arch_repair.sh
Syntax: ./Arch_repair.sh sdx # Replace x with target device letter
This script runs the fix for the most common error caused by improperly shutting down.

Arch_update.sh
This script will update the Arch system and all its programs to their latest versions. Requires internet.

AUFISR.sh
Syntax: ./AUFISR.sh sdx # Replace x with target device letter
This script will replicate the running Arch USB onto another USB of sufficient size.
!!!Warning this will wipe entire target drive.

audio.sh
Maxes out volumes and plays sound.mp3 in order to test speakers and audio out ports.

batteryinfo.sh
Displays concise info about battery.

batterytest.sh
Displays battery info, stresses cpu for 5 minutes, then displays battery info again.

cd.sh
Opens the CD tray and waits for a disc to be read by the system.
If it can read the disc, it will output its label and eject.
If not, it will keep trying indefinitely until canceled with Ctrl+C.

cpu.sh
Displays processor info.

dmconf
Configuration file for lightdm. Used by GUI_autologin.sh

eject.sh
Ejects the cd tray.

graphics.sh
Displays the lspci info for graphics.

GUI_autologin.sh
Enables autologin for the GUI on TTY7

hddinfo.sh
Syntax: ./hddinfo.sh sdx # Replace x with target device letter
Displays hard drive info for target device.

installprogs.sh
Deprecated. Installs missing programs that the scripts require.

keytest.sh
Tests keyboard keypresses.

master.sh
Syntax: ./master.sh l # 'l' option includes laptop tests
Automatically display all info scripts output. Advance with any keypress.

memory.sh
Displays memory info.

monitor_info.sh
Displays current resolution (should be optimum supported resolution). Must be run in GUI terminal emulator.

monitor_test.sh
Cycles through colors at a keypress. 'q' to quit. Best run in a TTY.

network.sh
Displays network interfaces and their capablities.

qrhdd.sh
Displays ASCII QR codes with hard drive info for easy scanning.

qrsysteminfo.sh
Displays ASCII QR code of system serial number for easy scanning.

readhdd.sh
Syntax: ./readhdd.sh sdx # Replace x with target device letter
Check for wipe signature on target device.

README.md

shutdown.sh
Shutdown computer cleanly.

sound.mp3
Song for audio.sh.

stress.sh
Loads down one core of the cpu.

systeminfo.sh
Displays basic system info.

TTY_autologin.sh
Enables autologin to root on TTY1

ttyservice
Service customized for autologin. Used by TTY_autologin.sh.

updatetests.sh
Updates all scripts. Requires internet.

webcam.sh
Takes a quick test picture with the webcam. Outputs pass or fail.

