%This function will make a bubble plot compatible script that can go inside a python script. The input is a list of genes and the output from pseudoBulk

function makeBubblePlotIn(genelist,pseudobulk_exp,outfilename)
%get the gene names
gnames=pseudobulk_exp.gnames;
samplenames=pseudobulk_exp.clusterlabels;
expmat=pseudobulk_exp.data;
fprintf('Found pseudobulk exp with %d genes %d clusterlabels\n',size(expmat,1),size(expmat,2));
genestoshow=importdata(genelist);
%Now make a key value pair for genelist
gene_nameidmap=containers.Map(gnames,1:length(gnames));
fid=fopen(outfilename,'w');
%Now for each gene in genelist write its exp out in gname, samplename, val format
%fprintf(fid,'gene\tsample\tgeneid\tsampleid\texp\n');
fprintf(fid,'gene\tMEFDay0\tFBSDay3\tFBSDay9\tFBSDay12\tA2SDay2\tFBSmESCs\tFBSDay6\tA2SDay4\tA2SDay6\n');
for g=1:length(genestoshow)
	mygene=genestoshow{g};
	if(isKey(gene_nameidmap,mygene))
		geneid=gene_nameidmap(mygene);
		fprintf('gene %s found with ID=%d!\n',mygene,geneid);
		%for s=1:length(samplenames)
			%fprintf(fid,'%s\t%s\t%d\t%d\t%f\n',mygene,samplenames{s},g,s,expmat(geneid,s));
		fprintf(fid,'%s\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n',mygene,expmat(geneid,1),expmat(geneid,2),expmat(geneid,3),expmat(geneid,4),expmat(geneid,5),expmat(geneid,6),expmat(geneid,7),expmat(geneid,8),expmat(geneid,9));
	else
		fprintf('gene %s not found skipping it!\n',mygene);
	end
end
fclose(fid);
