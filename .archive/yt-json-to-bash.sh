#!/bin/sh

# This script creates a newsboat-compatible YouTube subscriptions list from a
# newpipe JSON file.
#
# Made by Sergio Miguéns Iglesias (sergio@lony.xyz) for personal use, 2020.

if [ ! $# -eq 1 ]; then 
	echo "Wrong number of arguments. Usage: $0 [json file]"
	exit
else
	echo "----YOUTUBE----"
	jq ".subscriptions[] | .url, .name" $1 | sed -z -r 's/channel\/([A-Za-z0-9\-\_]+)/feeds\/videos\.xml\?channel\_id\=\1/g;s/\"//g;s/\n([^h])/\ \1/g;s/\ ([A-Za-z0-9Á-Źá-ź\-\.\ \-]+)/\t\"~\1\"\t\"YouTube\"/g'
fi
