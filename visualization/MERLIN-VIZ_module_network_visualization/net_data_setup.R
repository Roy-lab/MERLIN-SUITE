### App Setup! 

library(tidyverse)
library(tidygraph)
library(pracma)
library(DT)
library(Matrix)
library(data.table)

source('aux_functions.R')

### Files used for netData generation. 
prefix <- "/Volumes/"


all_nodes_file <- paste0(prefix, "/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2026/suvo_work/spencer_style_network/unique_nodes_v2.txt")

##NOTE: all_nodes_file information obtained from Marina's script file: /mnt/dv/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/scripts/run_enrichAnalyzer.sh [elog: https://elog.discovery.wisc.edu/MarinaActionItems/114]

edge_list_file <- paste0(prefix, "/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/results/Merlinp_results/Lambda_0100/consensus/n20_subsamples_lambda_0100_0_8.txt")

##NOTE: edge_list_file information obtained from Marina's elog: https://elog.discovery.wisc.edu/MarinaActionItems/114]

module2gene_file <- paste0(prefix, "/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/results/Merlinp_results/Lambda_0100/consensus/consensus_module_0_2_geneset.txt")

##NOTE: module2gene_file information obtained from Marina's elog: https://elog.discovery.wisc.edu/MarinaActionItems/114]


module_file <- paste0(prefix, "/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/results/Merlinp_results/Lambda_0100/consensus/consensus_module_0_2_geneset_enrichAnalyzer.txt")

##NOTE: module_file information obtained from Marina's elog: https://elog.discovery.wisc.edu/MarinaActionItems/114]

go_file = paste0(prefix, "/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/data/mousegotermap_regnet.txt")

##NOTE: go_file information obtained from Marina's script file: /mnt/dv/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/scripts/run_enrichAnalyzer.sh [elog: https://elog.discovery.wisc.edu/MarinaActionItems/114]

regulator_enrich_file <- paste0(prefix, "/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/results/Merlinp_results/Lambda_0100/consensus/regulator_enrichAnalysis_0_2_details.txt")

##NOTE: regulator_enrich_file information obtained from Marina's elog: https://elog.discovery.wisc.edu/MarinaActionItems/114]

go_enrich_file <- paste0(prefix, "/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/results/Merlinp_results/Lambda_0100/consensus/go_enrichAnalysis_0_2_details.txt")

##NOTE: go_enrich_file information obtained from Marina's elog: https://elog.discovery.wisc.edu/MarinaActionItems/114]

gene2genename_file <- NULL
Ortholog_1_to_1_file <- NULL
Ortholog_file <- NULL

gene_desc_file <- paste0(prefix, "/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2026/suvo_work/spencer_style_network/consensus_module_0_2_geneset_names.txt")

## I have created gene_desc_file from "all_nodes_file"  i.e., "/mnt/dv/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2026/suvo_work/spencer_style_network/consensus_module_0_2_geneset.txt" by column duplication. [Related elog: https://elog.discovery.wisc.edu/scRNAseqProjects/874]

regulator_list_file <- paste0(prefix, "/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2026/suvo_work/spencer_style_network/net1_transcription_factors.txt")

##NOTE: regulator_list_file obtained from Marina's file: "/mnt/dv/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/results/Nca/Lambda_0100/Merlinp_inputs/net1_transcription_factors.tsv" elog: https://elog.discovery.wisc.edu/MarinaActionItems/114

expression_file <- paste0(prefix, "/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/results/Nca/Lambda_0100/Merlinp_inputs/net1_expression_with_header_gene_by_cell.txt") #header "Gene"

##NOTE: expression_file information obtained from Marina's script file: /mnt/dv/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/scripts/sort_expression.py [Related elog: https://elog.discovery.wisc.edu/MarinaActionItems/114]


#cell_mapping_file <- paste0(prefix, "/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2026/suvo_work/livvy_style_heatmap/cell_clusters.txt")
cell_mapping_file <- paste0(prefix, "/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2026/suvo_work/spencer_style_network/sample_annotation.txt")
##NOTE: cell_mapping_file information obtained from: https://elog.discovery.wisc.edu/scRNAseqProjects/873

################### Make R Data Files *Only need to run once###################
expression_data <- prepareExpression(expression_file, save_struct = FALSE)
grouping_indice <- prepareCellMapping(expression_data, cell_mapping_file, save_struct = FALSE)

makePostProcessDataStruct(all_nodes_file, 
                          edge_list_file,
                          module2gene_file = module2gene_file, 
                          go_file = go_file,
                          module_file = module_file, 
                          regulator_enrich_file = regulator_enrich_file,
                          go_enrich_file = go_enrich_file, 
                          gene_desc_file = gene_desc_file, 
                          regulator_list_file = regulator_list_file, 
                          expression_data = expression_data, 
                          grouping_indices = grouping_indice)



