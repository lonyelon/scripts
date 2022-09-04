#!/bin/bash

TMPFILE="/tmp/sortedbooks.tsv"

# Show help
usage () {
	echo "Modo de empleo: $0 [OPCIÓN...] FICHERO_TSV"
	echo "Opciones obligatorias:"
	echo "\t-l\tFichero de plantilla a emplear, ha de contener el texto {{LIST}} donde se quiera introducir la lista de libros."
	echo "Opciones opcionales:"
	echo "\t-h\tMuestra esta ayuda."
	echo "\t-t\tEspecifica el fichero temporal a emplear, por defecto \'$TMPFILE\'."
}

# Get arguments
while getopts t:l:b:w:h option; do
	case "${option}" in
		h) usage; exit;;
		t) TMPFILE="${OPTARG}";;
		l) LAYOUTFILE="${OPTARG}";;
		b) BOOKFILE="${OPTARG}";;
		w) WISHLIST="${OPTARG}";;
	esac
done

# Check if bookfile was specified
[ "$BOOKFILE" = "" ] && echo "Se necesita el argumento \"-b\"." >&2 && exit 1

# Check if layout file was specified
[ "$LAYOUTFILE" = "" ] && echo "Se necesita el argumento \"-l\".">&2 && exit 1

# sort "$BOOKFILE" > "$TMPFILE"
TMPFILE="$BOOKFILE"

list="<table><tr><th>Estado<\/th><th>Título<\/th><th>Autor<\/th><th>Formato<\/th><\/tr>"
while read l; do
	# TODO awk this
	title=$(echo "$l" | cut -f 1)
	author=$(echo "$l" | cut -f 2)
	format=$(echo "$l" | cut -f 3)
	date_started=$(echo "$l" | cut -f 4)
	date_finished=$(echo "$l" | cut -f 5)
	
	for i in $(echo $format | sed -r 's/\ //g;s/:/\t/g'); do
		if [[ $i = \** ]]; then # TODO un-bash this
			style="unavailable "
		else
			style=""
			break;
		fi
	done
	
	if [ "$date_started" = "" ]; then
		state="Sin leer"
		style=$style"unread "
	else
		[ "$date_finished" = "" ] && state="Leyendo" && style=$style"reading " || state="Leído" && style=$style"read"
	fi

	list=$list"<tr class=\"$style\"><td>$state<\/td><td>$title<\/td><td>$author<\/td><td>$format<\/td><\/tr>\n"
done <$TMPFILE
list=$list"<\/table>"

RESULT=$(sed -r "s/\{\{LIST\}\}/$list/" $LAYOUTFILE)

if [ "$WISHLIST" != "" ]; then
	list="<table><tr><th>Título<\/th><th>Autor<\/th><th>Notas<\/th><\/tr>"
	while read l; do
		title=$(echo "$l" | cut -f 1)
		author=$(echo "$l" | cut -f 2)
		notes=$(echo "$l" | cut -f 3)

		list=$list"<tr><td>$title<\/td><td>$author<\/td><td>$notes<\/td><\/tr>\n"
	done <$WHISHLIST
	list=$list"<\/table>"

	RESULT=$(echo "$RESULT" | sed -r "s/\{\{WHISHLIST\}\}/$list/")
fi

echo "$RESULT"
