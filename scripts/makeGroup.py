import sys

def readCluster(inname):
	clust = {}
	f = open(inname,'r')
	for l in f:
		parts = l.strip().split('\t')
		c = parts[1]
		g = parts[0]
		genes = clust.get(c,set([]))
		genes.add(g)
		clust[c] = genes
	f.close()
	return clust

def writeCluster(outname,clust,th):
	f = open(outname,'w')
	cids = clust.keys()
	cids.sort(key=lambda x:len(clust[x]))
	for c in cids:
		genes = clust[c]
		if len(genes)<th:
			continue
		f.write('Cluster%s\t%s\n' % (c,'#'.join(list(genes))))
	f.close()

if __name__ == '__main__':
	clust = readCluster(sys.argv[1])
	writeCluster(sys.argv[2],clust,int(sys.argv[3]))
