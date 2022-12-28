#!/bin/awk -f

# A program to transform my personal journal file from my old format into the
# new one.
#
# My old journal was an org file with the following format:
# * yyyy
# ** yyyy-mm
# **** yyyy-mm-dd
# ...
# **** yyyy-mm-dd
# ** yyyy-mm
# ...
# ** yyyy-mm
# * yyyy
# ...
# * yyyy
#
# As one can see, my journal was one large file with all the things written in
# it.
#
# My new way of doing it is to split it into daily files, named yyyy-mm-dd.org
# to make access easier.
#
# Made by SERGIO MIGUÉNS IGLESIAS <sergio@lony.xyz> for personal use, 2022.

BEGIN {
    DESTDIR="~/doc/org/roam/daily"
}

/^\*\*? / {
    if (reading) {
        printf "EOF\n";
    }
    reading = 0;
}

/^\*{3} / {
    if (reading) {
        printf "EOF\n";

    }

    reading = 1;

    gsub(/^\*{3} /, "", $0);
    gsub(/ .*$/, "", $0);

    printf "cat>%s/%s.org<<EOF\n", DESTDIR, $0;
    printf ":PROPERTIES:\n"
    printf ":ID: awk-import-roam-daily_%s\n", $0;
    printf ":END:\n";
    printf "#+TITLE: %s\n", $0;
    printf "\n";
    printf "* Diario\n";
}

{
    if (reading == 2) {
        gsub(/^\*\*\*/, "", $0);
        gsub(/`/, "\\`", $0);
        print $0;
    } else if (reading == 1) {
        reading++;
    }
}

END {
    if (reading) {
        printf "EOF\n";
    }
}
