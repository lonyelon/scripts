#!/bin/awk -f
#
# This was a temporary script I made to convert my library csv file to yaml. The
# purpose of this file was to keep track of the books I read, own or want.
#
# The CSV file's format is the following:
# Title,Author,Tags,Buy date,Format,Read start,Read end,Notes?
#
# Since the file has been converted, there is no longer a point in having this
# script outside the archive directory, so there it goes.
#
# Made by SERGIO MIGUÉNS IGLESIAS <sergio@lony.xyz> for personal use, 2022. 

BEGIN {
    FS=",";
}

{
    split($2, authors, ";");
    split($3, tags, ";");
    split($7, rDates, ";");

    printf "- title: %s\n", $1
    if (length(authors) > 0) {
      printf "  authors:\n";
      for (i = 1; i <= length(authors); ++i)
          printf "  - %s\n", authors[i];
    }
    if (length(tags) > 0) {
      printf "  tags:\n";
      for (i = 1; i <= length(tags); i++)
          printf "  - %s\n", tags[i];
    }
    if ($4 != "")
        printf "  buyDate: %s\n", $4;
    if (length(rDates) > 0) {
      printf "  readDates:\n";
      for (i = 1; i <= length(rDates); i++)
          printf "  - %s\n", rDates[i];
    }
    if ($8 != "")
        printf "  notes: %s\n", $8
}
