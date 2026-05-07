#!/bin/bash

# Read values from modules.txt
while read i; do
    # Ensure the directory exists
    mkdir -p visualization/Cytoscape_based_condition_specific_visualization/module_${i}

    # Process each gene in the module
    cat visualization/Cytoscape_based_condition_specific_visualization/module_${i}/genes_in_mod${i}.txt | 
    while read line; do 
        awk -v OFS="\t" -v l="${line}" 'BEGIN {found=0} {if($2==l) print; found=1} END {if(found==0) print "No matches found for value: " 1 > "/dev/stderr"}' results/Merlinp/Lambda_0100/n20_subsamples_lambda_0100_0_8.txt >> visualization/Cytoscape_based_condition_specific_visualization/module_${i}/subnet_glut_mod_${i}.txt
    done
done < modules.txt
