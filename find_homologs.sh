QUERY=$1
SUBJECT=$2
OUTPUT=$3

makeblastdb -in "$SUBJECT" -dbtype nucl -out temp_subj_db > /dev/null 2>&1

QUERY_LEN=$(grep -v '^>' "$QUERY" | tr -d '\n\r' | wc -c)

tblastn -query "$QUERY" -db temp_subj_db -outfmt 6 | awk -v qlen="$QUERY_LEN" '$3 > 30 && $4 > (0.9 * qlen)' > "$OUTPUT"

wc -l < "$OUTPUT" | tr -d ' '

rm -f temp_subj_db*
