function bulkexp_labeled=pseudoBulk(expfile,clusters,clusterlabels)
%
d=importdata(expfile);
gnames=d.textdata(1,2:end);
barcodes=d.textdata(2:end,1);
expmat=d.data; 
cids=importdata(clusters);
fprintf('Done reading expression: %d genes, %d cells, %d clusterlabels',length(gnames),length(barcodes),length(clusterlabels));


cid_set=unique(cids.data); %assuming clusterID is barcode clusterID format
bulkexp=[];
for c=1:length(cid_set)
	mems=find(cids.data==cid_set(c));
	gene_samplemean=mean(expmat(mems,:)); %get sample mean for all genes
	bulkexp=[bulkexp gene_samplemean']; %store in bulkexp after transposing so it is gene by samples.
end
bulkexp_labeled.data=bulkexp;
%bulkexp_labeled.clusterlabels=clabels;
bulkexp_labeled.clusterlabels=clusterlabels;
bulkexp_labeled.gnames=gnames;

