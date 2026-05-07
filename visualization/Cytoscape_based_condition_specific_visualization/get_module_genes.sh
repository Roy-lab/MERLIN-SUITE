#!/bin/bash

# Input files
values_file="modules.txt"
module_file="results/Merlinp/Lambda_0100/consensus_module_0_2_geneset.txt"
regulator_file="results/Merlinp/Lambda_0100/list.0_8.0_2.txt"

# Loop through module IDs
while IFS= read -r i; do

    outdir="visualization/Cytoscape_based_condition_specific_visualization/module_${i}"
    outfile="${outdir}/genes_in_mod${i}.txt"

    mkdir -p "$outdir"

    # Step 1:
    # Extract genes belonging to module i
    awk -v mod="$i" '
        $2 == mod {
            print $1
        }
    ' "$module_file" > "$outfile"

    # Step 2:
    # Add ONLY regulators:
    # Cluster<i> and third column == 2
    awk -v mod="Cluster${i}" '
        $2 == mod && $3 == 2 {
            print $1
        }
    ' "$regulator_file" >> "$outfile"

    # Remove duplicates
    sort -u "$outfile" -o "$outfile"

done < "$values_file"