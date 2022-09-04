#!/bin/sh

# This script gets the mining info for the computer (hashrate,
# temperature.. etc).
#
# Made by Lonyelon (lonyelon@lony.xyz) for private use, 2021.

#                                                                         PARAMS
################################################################################

LOGFILE=/var/log/miner.log
DEST=server

#                                                                           CODE
################################################################################

help() {
	echo "Usage: $0 [options]" >&2
	echo "\nOPTIONS" >&2
	echo "\t-h\tShow this help" >&2
	echo "\t-d\tDestination server (default value: $LOGFILE)" >&2
	echo "\t-l\tLog file to read data from (default value: $DEST)" >&2
}

while getopts 'hl:d:' OPTION; do
    case "$OPTION" in
		l) LOGFILE="$OPTARG";;
		d) DEST="$OPTARG";;
        h) help && exit 0;;
        *) help && exit 1;;
    esac
done

SPD="$(grep -a -E '[-1-9]+\.[0-9]+\s[GMH]?h' $LOGFILE | tail -n 1 \
	| cut -d ' ' -f 7-8 | tr -d " " \
	| sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g")ps"
POWER="$(cat /sys/class/drm/card0/device/hwmon/hwmon2/power1_average \
	| cut -c 1-3) W"
TEMP="$(sensors amdgpu-pci-0800 -u | grep "temp1_input" | rev | cut -d ' ' -f 1\
	| rev | cut -d '.' -f 1) C"
CPU="$(grep 'cpu ' /proc/stat \
	| awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}' | rev \
	| cut -c 4- | rev) %"

RUN=`systemctl status ethminer.service | grep "active (running)" | wc -l`

[ "$RUN" = "0" ] || [ "$SPD" = "" ] && SPD="-1"

# Print data
echo "SPD:\t$SPD"
echo "POWER:\t$POWER"
echo "TEMP:\t$TEMP"
