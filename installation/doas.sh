#!/bin/sh

# DOAS is a lightweight alternative to SUDO. Use DOAS.
#
# Made by SERGIO MIGUÉNS IGLESIAS (lonyelon@lony.xyz) for personal use, 2021.

# Install DOAS
pacman -S opendoas

# Allow wheel group to use root
echo "permit keepenv :wheel" > /etc/doas.conf

# Remove SUDO
pacman -Rns sudo

# Link DOAS to SUDO to prevent compatibility issues
ln -s /bin/doas /bin/sudo
