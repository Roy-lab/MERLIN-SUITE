import pandas as pd

# Load the expression data
expression_file = 'data/net1_expression_with_header_gene_by_cell.txt'
expression_df = pd.read_csv(expression_file, sep='\t', index_col=0)

# Load the cluster ID information
cluster_file = 'data/cell_clusters.txt'
cluster_df = pd.read_csv(cluster_file, sep='\t', header=None, index_col=0)

# Map columns to cluster IDs
cluster_map = cluster_df[1].to_dict()

# Rename columns with cluster IDs
expression_df.columns = [cluster_map.get(cell, cell) for cell in expression_df.columns]

# Group by cluster IDs and calculate the mean for each cluster
averaged_df = expression_df.groupby(expression_df.columns, axis=1).mean()
ordered_avg_df = averaged_df[["C2", "C7", "C3", "C5", "C12", "C13", "C14", "C11", "C4", "C8", "C6", "C10", "C9", "C1"]]

# Save the result to a new file
ordered_avg_df.to_csv('visualization/Pseudobulk_expression_profile/pseudobulk_expr.txt', sep='\t')
print("Averaged expression data by cluster ID has been saved")

