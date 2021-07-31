#!/bin/sh

# Lonyelon's music player script.
# Depends on: fzf find mpv
#
# Made by SERGIO MIGUÉNS IGLESIAS (lonyelon@lony.xyz) for personal use, 2021.

music_dir="/home/shared/aud"

# Get albums
album="$(find "$music_dir" -mindepth 2 -maxdepth 2 -type d | cut -d"/" -f5- | fzf)"

# Check is album exists
[ -z "$album" ] && exit

# Play it
mpv --no-video "$music_dir/$album"
