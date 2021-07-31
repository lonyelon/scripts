#/bin/sh

# Allows to switch between QWERT and DVORAK.
#
# Made by LONYELON (lonyelon@lony.xyz) for personal use, 2021.

# Make CAPS LOCK the new BACKSPACE key
setxkbmap -option caps:backspace

# Swicth between DVORAK and QWERTY
[ -z "$(setxkbmap -query | grep 'dvorak')" ] && setxkbmap es -variant dvorak || setxkbmap es
