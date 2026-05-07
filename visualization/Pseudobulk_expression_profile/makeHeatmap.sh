#Module average expression plot over all-clusters

cat heatmap_in/ModuleAvg.txt | ./Heatmap.awk -vC="0:(0,0,255);0.1:(255,255,255);3:(255,0,0);6:(139,0,0)" -vD=" " -vFontSize=7 -vFont="Arial" -vSFontSize=5 -vBoxHeight=8 -vBoxWidth=8 -vStrokeC="-" -vStrokeW=0.5 -vStrokeSC="black"  -vL="Average_Expression"  > heatmap_out/ModuleAvg.svg;


#Module-wise average expression plot along with regulators and GO terms over all-clusters

for i in `ls heatmap_in/ |grep _attrib.txt |sed 's/_attrib\.txt//g'`; 
do
	echo ${i};
	cat heatmap_in/${i}_attrib.txt heatmap_in/${i}_regulators.txt | ./Heatmap.awk -vC="0:(255,255,255);1:(128,0,128);2:(0,255,255);3:(0,100,100) 0:(0,0,255);0.1:(255,255,255);3:(255,0,0);6:(139,0,0)" -vD=" " -vFontSize=7 -vFont="Arial" -vSFontSize=5 -vBoxHeight=8 -vBoxWidth=8 -vStrokeC="-" -vStrokeW=0.5 -vStrokeSC="black"  -vL="enrichments expression"  > heatmap_out/${i}.svg;
done;

