function [gid,actualid]=getGeneIDs(genenames,markers)
	genename_idmap=containers.Map(genenames,[1:size(genenames,1)]);
	gid=[];
	actualid=[];
	for j=1:length(markers)
		if(genename_idmap.isKey(markers{j}))
			id=genename_idmap(markers{j});
			gid=[gid id];
			actualid=[actualid j];
		end
	end
