#!/bin/bash

network="results/Merlinp/Lambda_0100/n20_subsamples_lambda_0100_0_8.txt"

while IFS= read -r i; do

    outdir="visualization/Cytoscape_based_condition_specific_visualization/module_${i}"
    genes="${outdir}/genes_in_mod${i}.txt"
    outfile="${outdir}/subnet_mod_${i}.txt"

    mkdir -p "$outdir"

    # Keep edges where:
    # regulator (col1) and target (col2)
    # are both present in module gene list
    # Output:
    # regulator target score

    awk '
        NR==FNR {
            if ($1 != "")
                genes[$1]=1
            next
        }

        ($1 in genes) && ($2 in genes) {
            print $1 "\t" $2 "\t" $3
        }
    ' "$genes" "$network" | sort -u > "$outfile"

done < modules.txt