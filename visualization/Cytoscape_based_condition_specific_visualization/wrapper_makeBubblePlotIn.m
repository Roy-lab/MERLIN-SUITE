%This is the wrapper function that can be invoked to output the bubble plot in compatible outputs for any input gene list

%Specify the location of expression, samplenames, cell-cluster annotations
expdatafile='data/net1_expression_with_header_gene_by_cell_t.txt';
samplenames={'MEFDay0';'FBSDay3';'FBSDay9';'FBSDay12';'A2SDay2';'FBSmESCs';'FBSDay6';'A2SDay4';'A2SDay6'};
clusters='sample_reference.txt';


pseudobulk_exp=pseudoBulk(expdatafile,clusters,samplenames);


genelist='genes_in_mod921.txt'

outputdir='Cytoscape_based_condition_specific_visualization/module_921';
%mkdir(outputdir);

makeBubblePlotIn(genelist,pseudobulk_exp,sprintf('%s/mod921_genes_pseudobulk.txt',outputdir));