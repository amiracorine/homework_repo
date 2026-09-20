#!/bin/bash

QUERY=$1
SUBJECT=$2
EVALUE=$3
OUTFILE=$4

tblastn -query "$QUERY" -subject "$SUBJECT" -evalue "$EVALUE" -outfmt 6 | \
awk '$3 >= 30 && $4 >= 100' > "$OUTFILE"
