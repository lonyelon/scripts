#!/bin/sh

# This scripts installs pipewrire as a replacement for pulseaudio.
#
# Made by SERGIO MIGUÉNS IGLESIAS (lonyelon@lony.xyz) for personal use, 2021.

# Check for root
[ "$(id -u)" -ne 0 ] && >&2 echo "Please execute this script as root." && exit

# Install pipewire
pacman -S pipewire pipewire-pulse

# Start pipewire in current session
systemctl start --user pipewire-pulse.service

# Ask for reboot
echo "Installation complete! you may now restart your computer."
