#!/bin/bash

REPEAT_QUERY=$1
ASSEMBLY=$2
OUTPUT=$3

makeblastdb -in "$ASSEMBLY" -dbtype nucl -out temp_assembly_db > /dev/null 2>&1

blastn -query "$REPEAT_QUERY" -db temp_assembly_db -outfmt "6 sseqid sstart send" | awk '$2 > $3 {tmp=$2; $2=$3; $3=tmp} {print $1, $2, $3}' | sort -k1,1 -k2,2n > repeats.txt

tail -n +2 repeats.txt > next_repeats.txt

paste repeats.txt next_repeats.txt | awk '$1 == $4 && $5 > $3 { print $1, $3, $5 - 1 }' | tr ' ' '\t' > spacers.bed
seqtk subseq "$ASSEMBLY" spacers.bed > "$OUTPUT"

rm -f temp_assembly_db* repeats.txt next_repeats.txt spacers.bed
