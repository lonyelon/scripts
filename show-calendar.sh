#!/bin/sh

# This script shows a calendar of the enxt two months.
#
# Made by LONYELON (lonyelon@lony.xyz) for personal use, 2021.


remind -c1 -c2 -m -w150 -@2,0 $HOME/.config/remind/reminders.rem | less -R
