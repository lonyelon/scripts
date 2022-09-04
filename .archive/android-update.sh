#!/bin/sh

# This script gets the latest version from the lineage os website and flashes it
# to an android device. The device MUST be ready for ABD sideloading before
# executing this script-
#
# Made by SERGIO MIGUÉNS IGLESIAS (lonyelon@lony.xyz) for personal use, 2021.

# Device model to get the image from
device="jfltexx"

# Download website
wget "https://download.lineageos.org/$device" -O "/tmp/lineage-$device"

# Get the ROM
wget "$(grep '.zip"' "/tmp/lineage-$device" | cut -d'"' -f2 | head -n 1)" -O "/tmp/android.zip"

# Load OS to device
adb sideload "/tmp/android.zip"

# Clean the rom and 
rm "/tmp/android.zip" "/tmp/lineage-$device"
