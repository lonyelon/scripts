#!/bin/sh

# This script acts as a front-end for ledger to make commands easier and
# shorter.
#
# To first start using this software you must create the $FILE document. Change
# the path as you wish. You also need to create the price database in $PRICEDB.
#
# Made by Sergio Miguéns Iglesias <sergio@lony.xyz> for personal use, 2022.


FILE=~/doc/cuentas/$(date +%Y).ledger
PRICEDB=~/doc/cuentas/pricedb

ASSETS_NAME=assets
LIABILITIES_NAME=liabilities
REVENUES_NAME=revenues
EXPENSES_NAME=expenses

help () {
	printf "Usage: $0 ACTIONS|OPTIONS\n\n"
	printf 'ACTIONS:\n'
	printf '\t-A\tAdd a new entry to the registry.\n\n'
	printf 'OPTIONS:\n'
	printf '\t-m\tOnly show entries since the beginning of the month.\n'
	printf '\t-t\tShow entries before today.\n'
	printf '\t-c X\tCompute asset prices based on the price database. Show
		prices in X currency.\n'
	printf '\t-n\tShow net worth (assets and liabilities).\n'
	printf '\t-b\tShow balance (expenses and revenues).\n\n'
}

while getopts stnbAc:h flag; do
	case "$flag" in
		h) help;exit;;
		m) args="$args -b $(date +%Y-%m-01)";;
		t) args="$args -e $(date -I --date='tomorrow')";;
		c) args="$args --price-db $PRICEDB --exchange $OPTARG";;
		n) args="$args ^ASSETS_NAME ^LIABILITIES_NAME";;
		b) args="$args ^REVENUES_NAME ^EXPENSES_NAME";;
		A)
			/bin/echo -n 'Title: '
			read title
			/bin/echo -n "Origin account: "
			read from
			/bin/echo -n "Destination account: "
			read to
			/bin/echo -n "Amount: "
			read amm
			/bin/echo -n "Date: "
			read d
			[ -z "$d" ] && d=`date -I`
			sed -i "1i $d $title\n $from\t-$amm\n $to" $FILE
			;;
	esac
done

ledger -f $FILE b $args
