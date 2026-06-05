#!/bin/bash
set -euo pipefail

GS_BASE=data/mesc_gold

INPUTS_BASE=input_datasets

OUT_BASE=results/fscore_entries

FILTER_TOOL=filter_net_corrected.py

VALIDATE=fscore.py

N_EDGE=5000
PARAM=""

AGG_OUTFILE_OVERRIDE=""

while getopts ":g:i:o:t:c:n:p:A:" opt; do
    case "$opt" in
        g) GS_BASE="$OPTARG" ;;
        i) INPUTS_BASE="$OPTARG" ;;
        o) OUT_BASE="$OPTARG" ;;
        t) FILTER_TOOL="$OPTARG" ;;
        c) VALIDATE="$OPTARG" ;;
        n) N_EDGE="$OPTARG" ;;
        p) PARAM="$OPTARG" ;;
        A) AGG_OUTFILE_OVERRIDE="$OPTARG" ;;
    esac
done

[[ -n "$PARAM" ]] || {
    echo "Missing -p"
    exit 1
}

case "$PARAM" in
    tfa0.000) lambda=0000 ;;
    tfa0.005) lambda=0005 ;;
    tfa0.020) lambda=0020 ;;
    tfa0.100) lambda=0100 ;;
    *) echo "Unknown param: $PARAM"; exit 1 ;;
esac

NETWORK=results/Merlinp/Lambda_${lambda}/n20_subsamples_lambda_${lambda}_0_8_sorted.txt

[[ -s "$NETWORK" ]] || {
    echo "Missing network: $NETWORK"
    exit 1
}

input_TFs="${INPUTS_BASE}/${PARAM}/regs.txt"
input_tgts="${INPUTS_BASE}/${PARAM}/tgts.txt"

GS_FILES=(
mESC_bothko_array.txt
mESC_bothko_rnaseq.txt
mESC_chip_array.txt
mESC_chip.bothko_array.txt
mESC_chip.bothko_rnaseq.txt
mESC_chip_rnaseq.txt
)

if [[ -n "$AGG_OUTFILE_OVERRIDE" ]]; then
    agg_outfile="$AGG_OUTFILE_OVERRIDE"
else
    agg_outfile="${OUT_BASE}/agg_fscore.txt"
fi

mkdir -p "$OUT_BASE"

for gs in "${GS_FILES[@]}"; do

    GS_src="${gs%.txt}"

    gold="${GS_BASE}/${gs}"

    outsubdir="${OUT_BASE}/${PARAM}/${GS_src}"
    mkdir -p "$outsubdir"

    echo
    echo "Gold: $GS_src"
    echo "Param: $PARAM"

    python3 "$VALIDATE" \
        "$NETWORK" \
        "$gold" \
        --inferred-TFs "$input_TFs" \
        --inferred-targets "$input_tgts" \
        -k "$N_EDGE" \
        > "${outsubdir}/res.log"

    precision=$(awk '{print $1}' "${outsubdir}/res.log")
    recall=$(awk '{print $2}' "${outsubdir}/res.log")
    fscore=$(awk '{print $3}' "${outsubdir}/res.log")

    if [[ "$PARAM" == "tfa0.000" ]]; then
        tfa="Unreg_TFA"
    else
        tfa="Reg_TFA"
    fi

    printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" \
        "merlinp" \
        "$PARAM" \
        "$tfa" \
        "$N_EDGE" \
        "$GS_src" \
        "$precision" \
        "$recall" \
        "$fscore" \
        "ms_filter_yudafixed" \
        >> "$agg_outfile"

done
