#!/bin/bash

QUERY="$1"
SUBJECT="$2"
OUTFILE="$3"

tblastn -query "$QUERY" -subject "$SUBJECT" -outfmt '6 std qlen' \
  | awk '$3 > 30 && $4 > 0.9 * $13' > "$OUTFILE"

wc -l < "$OUTFILE"
