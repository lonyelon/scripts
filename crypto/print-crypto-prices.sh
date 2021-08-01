#!/bin/sh

# This script reads a CSV file with coin prices and prints the data read to
# stdout with cool colors.
#
# CSV file must contain a first line as a header and one line per coin, each
# containing the following fields:
# Coin name, Symbol, Price, Change 24h, Change 7d, Change 30d, Change 90d
#
# Made by SERGIO MIGUÉNS IGLESIAS (lonyelon@lony.xyz) for personal use, 2021.

# Names of the coins you are interested in, separated by spaces
coins="Monero Ethereum Bitcoin Cardano"

[ ! -f "$1" ] && >&2 echo "Usage: $0 CSV_DATA_FILE" && exit

# Get the coin data from the file and print it
grep -E "^($(echo "$coins" | sed -r "s/^/(/;s/\ /)|(/g;s/$/)/"))," $1 | tr ',' '\t' | cut -f2- | awk '{
	if ( $3 < 0 ) col0="\033[31m";
	else if ( $3 > 0 ) col0="\033[32m";

	if ( $4 < 0 ) col1="\033[31m";
	else if ( $4 > 0 ) col1="\033[32m";

	if ( $5 < 0 ) col2="\033[31m";
	else if ( $5 > 0 ) col2="\033[32m";

	if ( $6 < 0 ) col3="\033[31m";
	else if ( $6 > 0 ) col3="\033[32m";

	printf "%s: %.2f€\n\
		%s  - 24h: %.1f%\t(%.2f€)\033[0;0m\n\
		%s  -  7d: %.1f%\t(%.2f€)\033[0;0m\n\
		%s  - 30d: %.1f%\t(%.2f€)\033[0;0m\n\
		%s  - 90d: %.1f%\t(%.2f€)\033[0;0m\n\n",
		$1, $2,
		col0, $3, $2 / ( $3 / 100 + 1 ),
		col1, $4, $2 / ( $4 / 100 + 1 ),
		col2, $5, $2 / ( $5 / 100 + 1 ),
		col3, $6, $2 / ( $6 / 100 + 1 )
}'
