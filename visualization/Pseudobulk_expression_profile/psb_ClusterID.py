#Adapted from: https://elog.discovery.wisc.edu/scRNAseqProjects/861

import pandas as pd

# Load the expression data
expression_file = '/mnt/dv/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/results/Nca/Lambda_0100/Merlinp_inputs/net1_expression_with_header_gene_by_cell.txt'

#NOTE: expression_file information obtained from Marina's script file: /mnt/dv/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2025/marina_work/scripts/sort_expression.py [Related elog: https://elog.discovery.wisc.edu/MarinaActionItems/114]

#df = pd.read_csv(expression_file, sep='\t')

expression_df = pd.read_csv(expression_file, sep='\t', index_col=0)

# Load the cluster ID information
cluster_file = '/mnt/dv/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2026/suvo_work/livvy_style_heatmap/cell_clusters.txt'
cluster_df = pd.read_csv(cluster_file, sep='\t', header=None, index_col=0)

#NOTE: cluster_file I generated here: https://elog.discovery.wisc.edu/scRNAseqProjects/873]

# Map columns to cluster IDs
cluster_map = cluster_df[1].to_dict()

# Rename columns with cluster IDs
expression_df.columns = [cluster_map.get(cell, cell) for cell in expression_df.columns]

# Group by cluster IDs and calculate the mean for each cluster
averaged_df = expression_df.groupby(expression_df.columns, axis=1).mean()


ordered_avg_df = averaged_df[["C2", "C7", "C3", "C5", "C12", "C13", "C14", "C11", "C4", "C8", "C6", "C10", "C9", "C1"]]

# Save the result to a new file
ordered_avg_df.to_csv('/mnt/dv/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2026/suvo_work/livvy_style_heatmap/pseudobulk_expr.txt', sep='\t')

print("Averaged expression data by cluster ID has been saved")

