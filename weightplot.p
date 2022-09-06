#!/usr/bin/gnuplot

# This scripts takes my weight data and plots it. The data has to have the same
# format as the one in "weight.awk".
#
# I know this is ugly, but I don't know much about GNUPlot.
#
# Made by SERGIO MIGUÉNS IGLESIAS <sergio@lony.xyz> for personal use, 2022.

set title "Sergio's weight and bodyfat percentage"

a1title='Weight (kg)'
#a2title='Bodyfat %'

set terminal png size 800,500 enhanced
set output '~/doc/img/weightplot.png'

set timefmt '%Y-%m-%d %H'
set xdata time
set datafile separator ','

set format x "%m-%d"
set ylabel a1title tc lt 1
#set yrange [80:90]
#set y2label a2title tc lt 2
#set y2range [5:30]
#set y2tics

plot '~/doc/weight.csv' u 1:2 w lp lw 1 ps 2 axes x1y1 title a1title
#'~/doc/weight.csv' u 1:3 w lp lw 1 ps 2 axes x1y2 title a2title
