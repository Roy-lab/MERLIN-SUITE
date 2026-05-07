#!/bin/bash

# Define the input and output file names
input_file="data/expression_with_reordered_cellmetadata.txt"
output_file="data/expression_with_reordered_cellmetadata_transpose.txt"

# Transpose the file using awk
awk '
{
    # For each line in the input file
    for (i = 1; i <= NF; i++) {
        # Append each field to a temporary array with the field index as the key
        data[NR, i] = $i
        # Track the maximum number of fields (columns) encountered
        if (i > max_fields) {
            max_fields = i
        }
    }
}
END {
    # Output the transposed data
    for (i = 1; i <= max_fields; i++) {
        for (j = 1; j <= NR; j++) {
            # Print the transposed data, separated by tabs
            printf "%s", data[j, i]
            if (j < NR) {
                printf "\t"
            }
        }
        printf "\n"
    }
}
' "$input_file" > "$output_file"

echo "File has been transposed and saved to $output_file."
