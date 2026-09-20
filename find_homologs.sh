#!/bin/bash

QUERY=$1
SUBJECT=$2
EVALUE=$3
OUTFILE=$4

# Run tblastn and write output to OUTFILE
tblastn -query "$QUERY" -subject "$SUBJECT" -evalue "$EVALUE" -outfmt 6 -out "$OUTFILE"
