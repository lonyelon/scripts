#!/bin/sh

# This script counts the ammount of unread mails the user has.
#
# Made by SERGIO MIGUÉNS IGLESIAS (lonyelon@lony.xyz) for personal use, 2021.

c=0
for f in $HOME/.local/share/mail/*; do
	t="$(ls $f/INBOX/new | wc -l)"
	c="$(( $t + $c ))"
done
echo $c
