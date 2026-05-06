% MERLIN-SUITE
%cell-cluster label
samplenames = {'C2'; 'C7'; 'C3'; 'C5'; 'C12'; 'C13'; 'C14'; 'C11'; 'C4'; 'C8'; 'C6'; 'C10'; 'C9'; 'C1'}
%number of cells per cell-cluster
sampleloc = [486, 194, 488, 262, 240, 204, 138, 173, 543, 370, 288, 196, 292, 273]
%Output result figure directory
SRCLUSTERDIR=sprintf('visualization/Zeromean_expression_profile');
%Input expression file with cell metadata (header: cellnames) in the order of cell-cluster
EXPFILE=sprintf('data/expression_with_reordered_cellmetadata.txt');

alldata=importdata(EXPFILE);
gnames=alldata.textdata(2:end,1);
alldata=alldata.data;
figure;

CASSIGN=sprintf('results/Merlinp/Lambda_0100/consensus_module_0_2_geneset.txt');

cid=importdata(CASSIGN);
markers=cid.textdata;

CASSIGN_reg=sprintf('results/Merlinp/Lambda_0100/list.0_8.0_2.txt');

cid_reg=importdata(CASSIGN_reg);
idx = find(cid_reg.data == 2);
cid_reg.data=cid_reg.data(idx);
cid_reg.textdata=cid_reg.textdata(idx,:);
markers_reg=cid_reg.textdata; % gene names of the cluster assignment file
[gid,actualid]=getGeneIDs(gnames,markers);
expdata=alldata(gid,:);
[gid_reg,actualid_reg]=getGeneIDs(gnames,markers_reg);
expdata_reg=alldata(gid_reg,:);

fprintf('Found %d genes\n',length(gid));
outfname=sprintf('%s',SRCLUSTERDIR);
mkdir(outfname);
figure;
csize=showClusterWithReg_All(cid,cid_reg,expdata,expdata_reg,4,sampleloc,samplenames,outfname);
