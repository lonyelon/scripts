#!/bin/sh

# Shows a calendar with next events.
#
# Made by LONYELON (lonyelon@lony.xyz) for personal use, 2021.

remind -c1 -c2 -w150 -@2,0 -m $HOME/.config/remind/reminders.rem | less -R
