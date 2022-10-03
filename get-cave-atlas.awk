#!/bin//awk -f
#
# This script gets the "Atlas de Covas e Canóns de Galicia" and converts the
# data from it to YAML format.
#
# Run with:
#   curl -s http://www.espeleoloxia.org/atlas/atlas.php | ./get-cave-atlas.awk
#
# Made by Sergio Miguéns Iglesias <sergio@lony.xyz> for personal use, 2022.

BEGIN {
	count=0
	print "caves:"
}

/^[ \t]*<td>/ {
	sub(/^[ \t]*<td>/,"",$0);
	sub(/<\/td>$/,"",$0);
	data=$0;

	switch (count) {
		case 0:
			print "- name:", data
			break;
		case 1:
			print "  province:", data
			break;
		case 2:
			print "  city:", data
			break;
		case 3:
			print "  length:", data
			break;
		case 4:
			print "  depth:", data
			break;
		case 5:
			print "  type:", data
			break;
		case 6:
			print "  access:", data
			count = -1
	}
	count++;
}
