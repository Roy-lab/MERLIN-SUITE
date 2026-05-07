#!/bin/bash

# Define the list of expression matrix identifiers
expression_matrices=("MEFDay0_expr" "FBSDay3_expr" "FBSDay9_expr" "FBSDay12_expr" "A2SDay2_expr" "FBSmESCs_expr" "FBSDay6_expr" "A2SDay4_expr" "A2SDay6_expr")

# Read the module IDs from values.txt
while read j; do
    for i in "${expression_matrices[@]}"; do
        # Create the module_inputs directory
        mkdir -p module_${j}/module_inputs

        # Run the Python script
        #Usage: python convertNet.py <condition-specific expression_matrix> <Module-specific edges> <Output adjacency matrix> <Output expression matrix>
        python convertNet.py expression_matrices/${i}.txt module_${j}/subnet_mod_${j}.txt module_${j}/module_inputs/adj.${i}.txt module_${j}/module_inputs/${i}.txt
    done
done < modules.txt
