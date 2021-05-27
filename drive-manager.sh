#!/bin/sh

# This script allows for easy mounting of drives.
#
# Made by LONYELON (lonyelon@lony.xyz) for personal use, 2021.

# List devices with cool colors
lsblk | sed -e "s/\ \ */\ /g" | cut -d" " -f1,4,7 | grep "^[^a-z]" | sed -e "s/\ /\t/g;s/^[^a-z][^a-z]//g" \
	| awk 'BEGIN{OFS=""}m=/[0-9][PGMKB][\t ]$/{print "\033[1;32m",$0,"\033[0;0m"}!m{print $0}'

# Select device
echo "Select a device (in dmenu): "
dev="$(ls /dev/sd* | sed -e "s/\ /\n/g" | grep "[0-9]$" | dmenu)"

[ -z "$dev" ] && >&2 echo "Device not specified, aborting..." && exit

# Mount or unmount devices
if [ -z "$(mount | grep $dev)" ]; then
	echo "Specify a directory to mount $dev to: "
	read path

	[ -z "$path" ] && >&2 echo "Mount point no specified, aborting..." && exit

	[ ! -d $path ] && mkdir -p $path

	sudo mount $dev $path
	sudo chown -R $(id -un):$(id -gn) $path
else
	echo "Unmount disk? [y/N]: "
	read sel
	[ "$sel" = "y" -o "$sel" = "Y" ] && sudo umount $dev
fi
