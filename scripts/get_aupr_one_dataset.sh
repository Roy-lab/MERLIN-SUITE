#!/bin/bash
set -euo pipefail

GS_BASE=""
INPUTS_BASE=""
OUT_BASE=""
FILTER_TOOL=""
AUPR_WRAPPER=""
PARAM=""
N_EDGE="all_edges"
AGG_OUT=""

while getopts ":g:i:o:t:w:p:x:A:h" opt; do
    case "$opt" in
        g) GS_BASE="$OPTARG" ;;
        i) INPUTS_BASE="$OPTARG" ;;
        o) OUT_BASE="$OPTARG" ;;
        t) FILTER_TOOL="$OPTARG" ;;
        w) AUPR_WRAPPER="$OPTARG" ;;
        p) PARAM="$OPTARG" ;;
        x) N_EDGE="$OPTARG" ;;
        A) AGG_OUT="$OPTARG" ;;
        h) echo "Usage: ..."; exit 0 ;;
    esac
done

[[ -n "$PARAM" ]] || { echo "ERROR: missing PARAM"; exit 1; }

# -----------------------------
# MAP tfa → Lambda directory
# -----------------------------
case "$PARAM" in
    tfa0.000) LAMBDA="0000" ;;
    tfa0.005) LAMBDA="0005" ;;
    tfa0.020) LAMBDA="0020" ;;
    tfa0.100) LAMBDA="0100" ;;
    *) echo "ERROR: unknown PARAM $PARAM"; exit 1 ;;
esac

# -----------------------------
# Paths
# -----------------------------
gs_dir="$GS_BASE"

net_file="results/Merlinp/Lambda_${LAMBDA}/n20_subsamples_lambda_${LAMBDA}_0_8_sorted.txt"

input_TFs="${INPUTS_BASE}/${PARAM}/regs.txt"
input_tgts="${INPUTS_BASE}/${PARAM}/tgts.txt"

[[ -s "$net_file" ]] || { echo "ERROR: missing network $net_file"; exit 1; }
[[ -s "$input_TFs" ]] || { echo "ERROR: missing TFs $input_TFs"; exit 1; }
[[ -s "$input_tgts" ]] || { echo "ERROR: missing TGTS $input_tgts"; exit 1; }

outdir="${OUT_BASE}/${PARAM}"
mkdir -p "$outdir"

gs_files=(
mESC_bothko_array.txt
mESC_chip_array.txt
mESC_chip.bothko_array.txt
mESC_bothko_rnaseq.txt
mESC_chip_rnaseq.txt
mESC_chip.bothko_rnaseq.txt
)

scores="${outdir}/scores.txt"
> "$scores"

echo "============================================"
echo "PARAM: $PARAM | LAMBDA: $LAMBDA"
echo "NETWORK: $net_file"
echo "============================================"

for gs in "${gs_files[@]}"; do

    gold="${gs_dir}/${gs}"
    gs_name="${gs%.txt}"

    [[ -s "$gold" ]] || { echo "Missing gold $gold"; exit 1; }

    outsub="${outdir}/${gs_name}"
    mkdir -p "$outsub"

    outprefix="${outsub}/aupr"

    python "$FILTER_TOOL" \
        "$net_file" "$gold" \
        --inferred-TFs "$input_TFs" \
        --inferred-targets "$input_tgts" \
        "${outprefix}.inf" "${outprefix}.gold"

    bash "$AUPR_WRAPPER" "${outprefix}.gold" "${outprefix}.inf" "$outprefix"

    val=$(grep -m1 "Area Under the Curve for Precision" "${outprefix}.out.txt" | awk '{print $10}')

    [[ -z "$val" ]] && val="0"

    echo -e "${gs_name}\t${PARAM}\t${val}" >> "$scores"
    echo -e "${gs_name}\t${PARAM}\t${val}" >> "$AGG_OUT"

done