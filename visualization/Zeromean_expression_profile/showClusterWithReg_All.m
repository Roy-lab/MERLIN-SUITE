function csize = showClusterWithReg_All(clust, clustreg, alldata1, allregdata, minsize, samplelocs, samplenames, figfname)
% showClusterWithReg_All - Visualize MERLIN clusters with regulators
% and save module gene/regulator lists as text files
%
% Inputs:
%   clust       : struct with fields .data (cluster IDs) and .textdata (gene names)
%   clustreg    : struct with fields .data (cluster IDs) and .textdata (gene names of regulators)
%   alldata1    : gene expression matrix for all genes
%   allregdata  : expression matrix for regulator genes
%   minsize     : minimum cluster size to show
%   samplelocs  : vector of number of cells per sample
%   samplenames : cell array of sample names
%   figfname    : directory to save figures
%
% Output:
%   csize       : number of genes per cluster

%% Prepare cluster data
gclust = clust.data;
gnames = clust.textdata;

% Convert regulator cluster column from text (e.g., 'Cluster2') to numeric
regclust = str2double(strrep(clustreg.textdata(:, 2), 'Cluster', ''));
regnames = clustreg.textdata;

% Compute size of each cluster
cids = unique(gclust);
csize = histc(gclust, cids);

% Only show clusters above minimum size
toshowcids = find(csize > minsize);
fprintf('Found %d modules of size at least %d\n', length(toshowcids), minsize);

% Define a custom colormap
v1 = (0:0.01:1)';
v2 = (1:-0.01:0)';
v3 = ones(101, 1);
cmap = [v1, v1, v3; v3, v2, v2];
colormap(cmap);

% Initialize matrices for final overview
mattoshow = [];
clusterparts = [];
samplepos = [];

%% Create folder to save module files if it doesn't exist
subnetworks_dir = 'visualization/Zeromean_expression_profile';
if ~exist(subnetworks_dir, 'dir')
    mkdir(subnetworks_dir);
end

%% Loop over clusters to generate figures and save gene/regulator lists
for i = 1:length(toshowcids)
    moduleofinterest = cids(toshowcids(i));
    ids = find(gclust == moduleofinterest);
    
    if length(ids) < minsize
        fprintf('Skipping module: %d size=%d\n', moduleofinterest, length(ids));
        continue;
    end
    
    hold off;
    subplot(1, 1, 1);
    
    % Module expression centered by row
    cmat = alldata1(ids, :);
    cmat = cmat - mean(cmat, 2);
    
    % Module regulator expression
    regids = find(regclust == moduleofinterest);
    regmat = allregdata(regids, :);
    regmat = regmat - mean(regmat, 2);
    
    % Combine gene and regulator expression for visualization
    toshowmat = [cmat; ones(1, size(regmat, 2)); regmat];
    
    imagesc(toshowmat, [-1 1]);
    set(gca, 'yticklabels', [gnames(ids); ' '; regnames(regids)], 'fontsize', 5);
    yticks(1:size(toshowmat, 1));
    colorbar;
    
    % Draw vertical lines separating samples
    cellcnt = 0;
    for c = 1:length(samplelocs)
        cnt = samplelocs(c);
        cellcnt = cellcnt + cnt;
        line([cellcnt cellcnt], [0 size(toshowmat,1)], 'color', [0 0 0], 'linewidth', 1);
        samplepos(c) = cellcnt;
    end
    
    set(gca, 'xticklabels', strrep(samplenames, '_', '-'), 'fontsize', 5);
    xticks(samplepos);
    xtickangle(45);
    
    mattoshow = [mattoshow; cmat];
    clusterparts = [clusterparts length(ids)];
    
    % Save figure
    height = size(toshowmat, 1) * 0.1;
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 6 height+1],'PaperSize',[6 height+1]);
    % saveas(gcf, sprintf('%s/C%d.png', figfname, moduleofinterest), 'png');
    % print(gcf, sprintf('%s/C%d_highres.png', figfname, moduleofinterest), '-dpng', '-r300');

    print(gcf, sprintf('%s/C%d.svg', figfname, moduleofinterest), '-dsvg');

    %% Save module genes and regulators as text files
    module_genes = gnames(ids);
    module_regs = regnames(regids,1); % regulator names
    
    genes_file = fullfile(subnetworks_dir, sprintf('C%d_genes.txt', moduleofinterest));
    regs_file  = fullfile(subnetworks_dir, sprintf('C%d_regulators.txt', moduleofinterest));
    
    fid = fopen(genes_file, 'w');
    fprintf(fid, '%s\n', module_genes{:});
    fclose(fid);
    
    fid = fopen(regs_file, 'w');
    fprintf(fid, '%s\n', module_regs{:});
    fclose(fid);
    
    fprintf('Saved module %d genes (%d) and regulators (%d)\n', ...
        moduleofinterest, length(module_genes), length(module_regs));
end

%% Overview figure for all clusters
subplot(1,1,1);
[~, order] = sort(gclust);
imagesc(mattoshow, [-2 2]);

% Draw vertical lines separating samples
cellcnt = 0;
for c = 1:length(samplelocs)
    cnt = samplelocs(c);
    cellcnt = cellcnt + cnt;
    line([cellcnt cellcnt], [0 size(alldata1,1)], 'color', [0 0 0], 'linewidth', 1);
end

% Draw horizontal lines separating clusters
gcnt = 0;
gcntset = [];
for c = 1:length(clusterparts)
    cnt = clusterparts(c);
    gcnt = gcnt + cnt;
    line([0 size(alldata1,2)], [gcnt gcnt], 'color', [0 0 0], 'linewidth', 1);
    gcntset = [gcntset gcnt]; 
end

set(gca,'xticklabels',strrep(samplenames,'_','-'),'fontsize',5);
xticks(samplepos);
xtickangle(45);
set(gca,'yticklabels',cids(toshowcids));
yticks(gcntset);
colorbar;

% Save final overview figure
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 6 10],'PaperSize',[6 10]);
%saveas(gcf, sprintf('%s/allcids_min5.png',figfname), 'png');
%print(gcf, sprintf('%s/allcids_min5_highres.png',figfname), '-dpng', '-r300');

% OR equivalently for svg (often better rendering):
print(gcf, sprintf('%s/allcids_min5.svg', figfname), '-dsvg');

end
