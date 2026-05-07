function runcc()

mods={"921"}
ds={"MEFDay0_t", "FBSDay3_t", "FBSDay9_t", "FBSDay12_t", "A2SDay2_t", "FBSmESCs_t", "FBSDay6_t", "A2SDay4_t", "A2SDay6_t"}

for i=1:length(mods)

    % Create module_outputs directory if it does not exist
    outdir = sprintf('module_%s/module_outputs', mods{i});

    if ~exist(outdir, 'dir')
        mkdir(outdir);
    end

	for j=1:length(ds)


		fprintf('%s\t%s\n',mods{i},ds{j})
		a = importdata(sprintf('module_%s/module_inputs/%s.txt',mods{i},ds{j}));
		names = a.textdata(:,1);
		%expression matrix
		train = a.data;
		train = zscore(train')';
		
		adj = load(sprintf('module_%s/module_inputs/adj.%s.txt',mods{i},ds{j}));
		adj = sparse(adj(:,1),adj(:,2),adj(:,3),size(train,1),size(train,1));
		adj = full(adj);
		%make sure there is no self loop
		for k=1:size(adj,1)
			adj(k,k)=0;
		end
		runOneNet(sprintf('module_%s/module_outputs/cc.%s.txt',mods{i},ds{j}),names,train,adj);
	end
end

function runOneNet(outname,names,train,adj)

fid = fopen(outname,'w');

for i=1:size(train,1)
	tfcount = sum(adj(i,:));
	if tfcount == 0
		%fprintf('%s\n',names{i});
		continue;
	end
	tfids = adj(i,:)~=0;
	%tf expression
	xx = train(tfids,:)';
	%tg expression
	yy = train(i,:)';
	v  = corr(xx,yy);
	% Replace NaN correlations with 0
	v(isnan(v)) = 0;

	tfids = find(tfids);
	for j=1:length(tfids)
		fprintf(fid,'%s\t%s\t%f\n',names{tfids(j)},names{i},v(j));
	end
end
fclose(fid);

