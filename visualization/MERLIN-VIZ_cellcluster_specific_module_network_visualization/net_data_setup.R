### App Setup! 

library(tidyverse)
library(tidygraph)
library(pracma)
library(DT)
library(Matrix)
library(data.table)

source('aux_functions.R')

### Files used for netData generation. 

all_nodes_file <- "visualization/MERLIN-VIZ_cellcluster_specific_module_network_visualization/unique_nodes.txt"
edge_list_file <- "results/Merlinp/Lambda_0100/n20_subsamples_lambda_0100_0_8.txt"
module2gene_file <- "results/Merlinp/Lambda_0100/consensus_module_0_2_geneset.txt"
module_file <- "results/Merlinp/Lambda_0100/consensus_module_0_2_geneset_enrichAnalyzer.txt"
go_file = "data/mousegotermap_regnet.txt"
regulator_enrich_file <- "results/Merlinp/Lambda_0100/regulator_enrichAnalysis_0_2_details.txt"
go_enrich_file <- "results/Merlinp/Lambda_0100/go_enrichAnalysis_0_2_details.txt"

gene2genename_file <- NULL
Ortholog_1_to_1_file <- NULL
Ortholog_file <- NULL

gene_desc_file <- "visualization/MERLIN-VIZ_cellcluster_specific_module_network_visualization/consensus_module_0_2_geneset_names.txt"
regulator_list_file <- "data/net1_transcription_factors.tsv"

expression_file <- "data/net1_expression_with_header_gene_by_cell.txt" #header "Gene"
cell_mapping_file <- "data/cell_clusters.txt"

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



