#!/bin/sh

# This script gets data from the coinmarketcap API for criptocurrencies and
# prints it to stdout in CSV format. The CSV file has a header that explains
# it's different fields.
#
# A coinmarketcap TOKEN has to be passed in order for this to work.
#
# Made by SERGIO MIGUÉNS IGLESIAS (lonyelon@lony.xyz) for personal use, 2021.

# Check if TOKEN was passed
[ -z "$1" ] && echo "Usage: $0 COINMARKETCAP_TOKEN" && exit

# Print header
echo "Coin,Symbol,Price (EUR),Change (24h),Change (7d),Change (30d),Change (90d)"

# Get data
curl -s -H "X-CMC_PRO_API_KEY: $1" \
	-H "Accept: application/json" \
	-d "start=1&limit=50&convert=EUR" \
	-G https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest | jq "
		.data[] | .name,
			.symbol,
			.quote.EUR.price,
			.quote.EUR.percent_change_24h,
			.quote.EUR.percent_change_7d,
			.quote.EUR.percent_change_30d,
			.quote.EUR.percent_change_90d
	" | paste -d ',' - - - - - - - | tr -d '"'
