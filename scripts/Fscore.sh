#!/bin/bash
set -euo pipefail

# =====================================================
# Validator program
# =====================================================
code=scripts/validate

# =====================================================
# Gold standard directory
# =====================================================
gs_dir=data/mesc_gold

# =====================================================
# Inferred network directory
# =====================================================
net_dir=results/Merlinp

# =====================================================
# Output directory
# =====================================================
outdir=results/fscore
mkdir -p ${outdir}

# =====================================================
# Three separate output files
# =====================================================
edge_out=${outdir}/edge_validation.txt
regulator_out=${outdir}/regulator_validation.txt
target_out=${outdir}/target_validation.txt

echo -e "GoldStandard\tLambda\tRecall\tPrecision\tFscore" > ${edge_out}
echo -e "GoldStandard\tLambda\tRecall\tPrecision\tFscore" > ${regulator_out}
echo -e "GoldStandard\tLambda\tRecall\tPrecision\tFscore" > ${target_out}

# =====================================================
# Gold standard files
# =====================================================
for gs in \
mESC_bothko_array.txt \
mESC_chip_array.txt \
mESC_chip.bothko_array.txt \
mESC_bothko_rnaseq.txt \
mESC_chip_rnaseq.txt \
mESC_chip.bothko_rnaseq.txt
do

    gs_name=${gs%%.txt}
    gold=${gs_dir}/${gs}

    echo "Processing: ${gs_name}"

    for param in 0000 0005 0020 0100
    do

        inferred=${net_dir}/Lambda_${param}/n20_subsamples_lambda_${param}_0_8_sorted.txt

        echo "  Lambda_${param}"

        # =====================================================
        # 1. Edge-level validation
        # compares TF -> Target edges
        # =====================================================
        result_edges=$(${code} ${gold} ${inferred} yes | grep Recall)

        recall_edges=$(echo "${result_edges}" | awk '{print $2}')
        precision_edges=$(echo "${result_edges}" | awk '{print $4}')
        fscore_edges=$(echo "${result_edges}" | awk '{print $6}')

        echo -e "${gs_name}\tLambda_${param}\t${recall_edges}\t${precision_edges}\t${fscore_edges}" >> ${edge_out}

        # =====================================================
        # 2. Regulator-level validation
        # compares unique regulators (column 1)
        # =====================================================
        result_regulators=$(${code} \
            <(cut -f1 ${gold} | sort -u) \
            <(cut -f1 ${inferred} | sort -u) \
            yes | grep Recall)

        recall_reg=$(echo "${result_regulators}" | awk '{print $2}')
        precision_reg=$(echo "${result_regulators}" | awk '{print $4}')
        fscore_reg=$(echo "${result_regulators}" | awk '{print $6}')

        echo -e "${gs_name}\tLambda_${param}\t${recall_reg}\t${precision_reg}\t${fscore_reg}" >> ${regulator_out}

        # =====================================================
        # 3. Target-level validation
        # compares unique targets (column 2)
        # =====================================================
        result_targets=$(${code} \
            <(cut -f2 ${gold} | sort -u) \
            <(cut -f2 ${inferred} | sort -u) \
            yes | grep Recall)

        recall_tar=$(echo "${result_targets}" | awk '{print $2}')
        precision_tar=$(echo "${result_targets}" | awk '{print $4}')
        fscore_tar=$(echo "${result_targets}" | awk '{print $6}')

        echo -e "${gs_name}\tLambda_${param}\t${recall_tar}\t${precision_tar}\t${fscore_tar}" >> ${target_out}

    done
done

echo "======================================"
echo "Finished successfully"
echo "======================================"

echo "Edge validation file:"
echo "${edge_out}"

echo "Regulator validation file:"
echo "${regulator_out}"

echo "Target validation file:"
echo "${target_out}"