#!/bin/sh

# A script to analyze disk usage in a given directory.
#
# Made by LONYELON (lonyelon@lony.xyz) for personal use, 2021.

path="."
[ ! -z "$1" ] && path="$1"

du "$path" -a -d 1 2> /dev/null | sort -n -r | sed -r "s/\t\.\//\t/g" | awk '
BEGIN {
	OFS=""
}

{

	if ( $1 > 1024*1024 )
		printf( "%3.1fG\t%s\n", $1/1024/1024, $2 )
	
	else if ( $1 > 1024 )
		printf( "%3.1fM\t%s\n", $1/1024, $2 )
	
	else
		printf( "%3.1fK\t%s\n", $1, $2 )
}'
