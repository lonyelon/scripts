#!/bin/awk -f

# This script takes a file with weight data and gives a week-by-week report of
# it (weight loss/gained, total calories consumed that week, etc).
#
# The data file MUST have the following structure (dates follow ISO format*):
#	HEADER_LINE (IGNORED)
#	DATE_0,WEIGHT_0,...
#	DATE_1,WEIGHT_1,...
#	...
#	DATE_n,WEIGHT_n,...
# * YYYY-MM-DDTHH:MM+HH:MM
#
# EXAMPLE lines from my own data (I am in the Madrid summer timezone (+02:00)
# and record other parameters aside from weight, thus the extra commas):
#	2022-07-03T11:00+02:00,78.6,,,,,,,,,,
#	2022-07-04T11:00+02:00,77.3,,,,,,,,,,
#	2022-07-05T10:00+02:00,77.6,,,,,,,,,,
#	2022-07-06T10:00+02:00,77.4,,,,,,,,,,
#	2022-07-07T10:00+02:00,76.8,,,,,,,,,,
#	2022-07-13T10:00+02:00,76.6,,,,,,,,,,
#	2022-07-14T10:00+02:00,76.6,,,,,,,,,,
#	2022-07-15T13:00+02:00,75.6,,,,,,,,,,
#	2022-07-16T14:40+02:00,77.2,,,,,,,,,,
#
# Made by SERGIO MIGUÉNS IGLESIAS <sergio@lony.xyz> for personal use, 2022.

BEGIN {
	OFS="\t"
	FS=","
	if (ARGV[1] == "-m")
		print "Week number\tWeight min.\tWeight min. diff.\tKcal min. diff.";
	else
		print "Week number\tWeight avg.\tWeight diff.\tKcal diff.";
}

function printData() {

	weightAvg = weightTotal/weekDataCount;
	weightDiff = weightAvg - lastWeekWeight;
	minWeightDiff = minWeekWeight - lastWeekMinWeight;

	if (ARGV[1] == "-m")
		printf "%d-%d\t%.2f\t%.2f\t%d\n", lastYear, lastWeek, minWeekWeight, \
			minWeightDiff, minWeightDiff * 7000;
	else
		printf "%d-%d\t%.2f\t%.2f\t%d\n", lastYear, lastWeek, weightAvg, \
			weightDiff, weightDiff * 7000;
}

/^20[0-9][0-9]-/ {
	str = "date -d " $1 " +%u";
	str | getline weekDayNu;

	if (weekDayNu != 6 && weekDaytNu != 7) {
		str = "date -d " $1 " +%Y";
		str | getline yearNu;
		str = "date -d " $1 " -I";
		str | getline isoDate;
		str = "date -d " $1 " +%V";
		str | getline weekNu;

		if ((yearNu != lastYear || weekNu != lastWeek ) && weekDataCount != 0) {
			printData();

			lastWeekWeight = weightTotal/weekDataCount;
			lastWeekMinWeight = minWeekWeight;
			lastWeek = weekNu;
			lastYear=yearNu;
			weightTotal = 0;
			weekDataCount = 0;
			minWeekWeight = 0;
		}

		if (previousRowIsoDate == isoDate)
			weightTotal -= previousRowWeight;
		else
			weekDataCount++;
		weightTotal += $2;

		previousRowIsoDate = isoDate;
		previousRowWeight = $2;

		if (minWeekWeight == 0 || minWeekWeight > $2)
			minWeekWeight = $2;
	}
}

END {
	printData();
}
