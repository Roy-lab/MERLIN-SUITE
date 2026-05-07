#!/bin/bash

input_file="data/expression_with_reordered_cellmetadata_transpose.txt"

# Define conditions
conditions=(
    "MEFDay0"
    "A2SDay2"
    "A2SDay4"
    "A2SDay6"
    "FBSDay3"
    "FBSDay6"
    "FBSDay9"
    "FBSDay12"
    "FBSmESCs"
)

# Get header
header=$(head -n 1 "$input_file")

# Create condition-specific .txt files
for condition in "${conditions[@]}"; do
    output_file="${condition}.txt"
    echo "$header" > "$output_file"
done

# Split rows into condition files
tail -n +2 "$input_file" | while IFS=$'\t' read -r line; do

    col1=$(echo "$line" | cut -f1)

    for condition in "${conditions[@]}"; do
        if [[ $col1 == *"$condition"* ]]; then
            echo "$line" >> "${condition}.txt"
        fi
    done
done

# Transpose each condition file
for condition in "${conditions[@]}"; do

    input_txt="${condition}.txt"
    output_t="${condition}_t.txt"

    awk '
    {
        for (i = 1; i <= NF; i++) {
            data[NR,i] = $i
            if (i > max_fields)
                max_fields = i
        }
    }
    END {
        for (i = 1; i <= max_fields; i++) {
            for (j = 1; j <= NR; j++) {
                printf "%s", data[j,i]
                if (j < NR)
                    printf "\t"
            }
            printf "\n"
        }
    }' "$input_txt" > "$output_t"

    echo "Generated: $input_txt and $output_t"

done