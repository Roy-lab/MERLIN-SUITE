export HMAWK=Heatmap.awk

#Color map
COLORMAP="0.00:(148,0,211);0.02:(75,0,130);0.04:(0,0,255);0.06:(0,255,255);0.08:(0,255,0);0.10:(255,255,0);0.12:(255,127,0);0.16:(255,0,0)"

#Making AUPR plot
cat results/aupr_results/plot_input.txt | ${HMAWK} -vStrokeC="-" -vStrokeSC="black" -vL="Value" -vD="space" -vC="${COLORMAP}" -vFontSize=8 > results/aupr_results/AUPR_Fscore.svg



