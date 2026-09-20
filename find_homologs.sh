QUERY=$1
SUBJECT=$2
EVALUE=$3
OUTFILE=$4

tblastn -query "$QUERY" -subject "$SUBJECT" -evalue "$EVALUE" -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore" | awk '$3 > 30 && $4 > 90 {print $2}' | sort -u > "$OUTFILE"
