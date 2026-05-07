#!/bin/bash

# ----------- Paths -----------
GENELIST="module_921/genes_in_mod921.txt"

INPUT_DIR="module_921/module_outputs"

OUTPUT_DIR="module_921/filtered_networks"
mkdir -p "$OUTPUT_DIR"

echo "Filtering reg and cc files..."
echo "Using gene list: $GENELIST"
echo ""

# ----------- Loop through reg and cc files -----------
for file in "$INPUT_DIR"/reg.*_expr_t.txt "$INPUT_DIR"/cc.*_expr_t.txt
do
    # Skip if no matching files exist
    [ -e "$file" ] || continue

    filename=$(basename "$file")
    echo "Processing $filename ..."

    awk 'NR==FNR {genes[$1]; next}
         ($1 in genes) && ($2 in genes) {
             if ($3 !~ /^-?[0-9.]+$/) $3 = 0;
             print
         }' \
         "$GENELIST" "$file" > "$OUTPUT_DIR/$filename"

done

echo ""
echo "Filtering completed."
