#!/bin/sh

# This script starts the ethereum miner and caps the GPU power to prevent
# overusage and increase benefits.
#
# Made by LONYELON (lonyelon@lony.xyz) for personal use, 2021

#                                                                        PARAMS
###############################################################################

LOGFILE=/tmp/miner.log
WATTAGE="110000000"
LINK="stratum+tcp://0xeaf0ddcba2042ab739b788fd7c0f77e8366445cd.worker@eu1.ethermine.org:4444"

#                                                                          CODE
###############################################################################

export NO_COLOR=1

[ "$(id -u)" -ne 0 ] && >&2 echo "This script has to be run as root with: sudo $0" && exit

echo "$WATTAGE" > /sys/class/drm/card0/device/hwmon/hwmon2/power1_cap

ethminer -G -P "$LINK" --cl-devices 1 --nocolor --syslog --stdout | tee $LOGFILE
