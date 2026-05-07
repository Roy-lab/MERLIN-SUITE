#!/bin/bash

# Input expression matrix
input_file="expression_with_reordered_cellmetadata_transpose.txt"

# Output directory
output_dir="expression_matrices"

# Check if input file exists
if [[ ! -f "$input_file" ]]; then
    echo "ERROR: Input file not found: $input_file"
    exit 1
fi

# Create output directory
mkdir -p "$output_dir"

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

# Extract header
header=$(head -n 1 "$input_file")

# Create empty condition-specific files with header
for condition in "${conditions[@]}"; do

    output_file="${output_dir}/${condition}.txt"

    echo "$header" > "$output_file"

done

# Split rows by condition
tail -n +2 "$input_file" | while IFS= read -r line; do

    col1=$(echo "$line" | cut -f1)

    for condition in "${conditions[@]}"; do

        if [[ "$col1" == *"$condition"* ]]; then

            echo "$line" >> "${output_dir}/${condition}.txt"

        fi

    done

done

# Transpose each condition-specific file
for condition in "${conditions[@]}"; do

    input_txt="${output_dir}/${condition}.txt"
    output_t="${output_dir}/${condition}_t.txt"

    awk -F'\t' '
    BEGIN {
        OFS="\t"
    }
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
                    printf OFS
            }

            printf "\n"
        }
    }' "$input_txt" > "$output_t"

    echo "Generated:"
    echo "  $input_txt"
    echo "  $output_t"
    echo

done

echo "All condition-specific files generated successfully."