export HMAWK=Heatmap.awk

#Color map
COLORMAP="0.00:(148,0,211);0.04:(75,0,130);0.08:(0,0,255);0.12:(0,255,255);0.16:(0,255,0);0.20:(255,255,0);0.24:(255,127,0);0.28:(255,0,0)"

#Making AUPR plot
cat results/aupr_entries/plot_input.txt | ${HMAWK} -vStrokeC="-" -vStrokeSC="black" -vL="Value" -vD="space" -vC="${COLORMAP}" -vFontSize=8 > results/aupr_entries/AUPR_Fscore.svg



