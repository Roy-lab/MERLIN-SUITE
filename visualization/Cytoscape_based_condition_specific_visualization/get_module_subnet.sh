#!/bin/bash

network="results/Merlinp/Lambda_0100/n20_subsamples_lambda_0100_0_8.txt"

while read i; do

    outdir="visualization/Cytoscape_based_condition_specific_visualization/module_${i}"
    genes="${outdir}/genes_in_mod${i}.txt"
    outfile="${outdir}/subnet_mod_${i}.txt"

    mkdir -p "$outdir"

    # Extract subnetwork:
    # keep edges where BOTH regulator and target
    # are present in module gene list

    awk '
        NR==FNR {
            genes[$1]=1
            next
        }

        genes[$1] && genes[$2]
    ' "$genes" "$network" > "$outfile"

done < modules.txt
