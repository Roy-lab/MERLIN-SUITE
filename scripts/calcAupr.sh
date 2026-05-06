# originally adapted from Saptarshi MERLIN-P-TFA analysis protocol. Reference elogs: https://elog.discovery.wisc.edu/RegNetInference/810, https://elog.discovery.wisc.edu/RegNetInference/814
#!/bin/bash

## Input gold standard directory
gs_dir=data/mesc_gold

## Marina's MERLIN-P-TFA inferred network directory
net_dir=results/Merlinp

## Output result directory
outdir=/mnt/dv/wid/projects7/Roy-singlecell2/bookchapter_MERLIN_2026/suvo_work/AUPR/aupr_results
mkdir -p ${outdir}

## Output file for saving aggregated AUPR scores
agg_outfile=${outdir}/agg_aupr.txt
> ${agg_outfile}

## Use all edges of the inferred networks
n_edges=all_edges

aupr_wrapper=/mnt/dv/wid/projects2/Roy-regnet-inference/NCA_project/from_royfs_write/new_yeast_aupr/aupr_wrapper.sh

for gs in mESC_bothko_array.txt mESC_chip_array.txt mESC_chip.bothko_array.txt mESC_bothko_rnaseq.txt mESC_chip_rnaseq.txt mESC_chip.bothko_rnaseq.txt
do
	gs_name=${gs%%.txt}

	## Output file for collecting the AUPR scores
	scores=${outdir}/${gs}
	> ${scores}

	outsubdir=${outdir}/${gs_name}
	mkdir -p ${outsubdir}
	
	gold=${gs_dir}/${gs}

	for param in 0000 0005 0020 0100
	do
		inferred=${net_dir}/Lambda_${param}/consensus/n20_subsamples_lambda_${param}_0_8_sorted.txt
			
		outfile_prefix=mESC.${param}
		outprefix=${outsubdir}/${outfile_prefix}

		algo=`echo ${gs} | sed 's/.txt//g'`
	
		## Calculate AUPR against the filtered gold standard
		bash ${aupr_wrapper} ${gold} ${inferred} ${outprefix}
	
		## Extract the AUPR score and save it in the "scores" file
		val=`grep "Area Under the Curve for Precision" ${outsubdir}/${outfile_prefix}.out.txt | cut -d' ' -f10`
		echo -e ${outfile_prefix}"\t"${val} >> ${scores}
	
		if [ "${param}" == "0000" ]; then
			tfa=Unreg_TFA
		elif [ "${param}" == "0005" ]; then
			tfa=TFA_0005
		elif [ "${param}" == "0020" ]; then
			tfa=TFA_0020
		elif [ "${param}" == "0100" ]; then
			tfa=TFA_0100	
		else
			tfa=No_TFA
		fi
		echo -e ${algo}"\t"${tfa}"\t"${n_edges}"\t"${GS_src}"\t"${val} >> ${agg_outfile}
	done
done 
