#!/bin/bash

# This is a script that organizes your downloads folder.
#
# Made by LONYELON (lonyelon@lony.xyz) for private use, 2021.

#                                                                         PARAMS
################################################################################

DIRS=("iso img vid aud pdf zip")
DWDIR="$HOME/dw"

#                                                                           CODE
################################################################################

function show_help {
	echo -e "USAGE: $0 [OPTIONS] DOWNLOADS_FOLDER\n"
	echo -e "OPTIONS:"
	echo -e "\t-h\tShow this help."
}

while getopts h option; do
	case "${option}"
	in
		h) show_help;;
	esac
done

# Check if the directory exists.
if [ ! -d "$DWDIR" ]; then
	>&2 echo "Directory \"$DWDIR\ does not exist."
	exit
fi

# Enter the downloads dir.
cd "$DWDIR"

# Check if every subdir exists, if not, create it.
for d in $DIRS; do
	[[ ! -d "$d" ]] && mkdir "$DWDIR/$d"
done

# Move files to their corresponding directories.
for f in *; do
	if [[ -f "$f" ]]; then 
		[[ "$f" =~ \.(img|iso) ]] && mv "$f" iso
		[[ "$f" =~ \.(png|jpg|jpeg|gif)$ ]] && mv "$f" img
		[[ "$f" =~ \.(webm|mp4|mov|mkv) ]] && mv "$f" vid
		[[ "$f" =~ \.(mp3|flac|ogg|wav|acc) ]] && mv "$f" aud
		[[ "$f" =~ \.(pdf) ]] && mv "$f" pdf
		[[ "$f" =~ \.(zip|tar|gzip|7z) ]] && mv "$f" zip
	fi
done
