#!/bin/bash

## The enrichAnalyzer executable
script=enrichanalyzer_Nongraph/enrichAnalyzer

# The background genelist
bg_genelist=data/targets.txt

# The prefix of the afum GO index files
go_prefix=data/mousegotermap_regnet.txt


## FDR p-value cutoff
fdr=0.05

## The type of multiple testing correction for adjusting p-values.
## If "persg" i.e. per sub graph, then consider each input line as its own GO test. 
## Else if "fullgraph," consider all input lines as a single GO test.
test_type="persg"

for lambda in 0100; do

    # The consensus network file
    consensus_net=results/Merlinp/Lambda_${lambda}/n20_subsamples_lambda_${lambda}_0_8_sorted_regnet.txt
    # The output dir must be created prior to running enrichAnalyzer.
    outdir=results/Merlinp/Lambda_${lambda}

    for i in 1 2 3 4; do

        # The consensus module assignment file
        consensus_module_assign=results/Merlinp/Lambda_${lambda}/consensus_module_0_${i}_geneset_enrichAnalyzer.txt

        ## For GO enrichment
        ${script} ${consensus_module_assign} ${bg_genelist} ${go_prefix} ${fdr} ${outdir}/go_enrichAnalysis_0_${i} ${test_type} >/dev/null;

        ## Identify enriched regulators for each module. These are the regulators whose target genes are overrepresented in a module.
        ${script} ${consensus_module_assign} ${bg_genelist} ${consensus_net} ${fdr} ${outdir}/regulator_enrichAnalysis_0_${i} ${test_type} >/dev/null;
    done
done
