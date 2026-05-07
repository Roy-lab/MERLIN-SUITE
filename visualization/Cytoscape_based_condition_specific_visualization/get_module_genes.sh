#!/bin/bash

# Define the input file and directory
values_file="modules.txt"
input_file="results/Merlinp/Lambda_0100/consensus_module_0_2_geneset.txt"

# Loop through each value in the one-column file
while IFS= read -r i; do
    # Ensure the target directory exists
    mkdir -p "visualization/Cytoscape_based_condition_specific_visualization/module_${i}"
    
    # Process the file and output the results
    grep -w "${i}" "$input_file" | cut -f1 > "visualization/Cytoscape_based_condition_specific_visualization/module_${i}/genes_in_mod${i}.txt"
done < "$values_file"
