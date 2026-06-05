#!/bin/bash
set -euo pipefail

module load conda3-py311_23.11.0-2

GET_FSCORE=get_fscore_one_dataset.sh

FILTER_TOOL=filter_net_corrected.py

VALIDATE=fscore.py

GS_BASE=data/mesc_gold

INPUTS_BASE=input_datasets

OUT_BASE=results/fscore_entries

mkdir -p "$OUT_BASE"

N_EDGE=5000

PARAMS=(
tfa0.000
tfa0.005
tfa0.020
tfa0.100
)

GLOBAL_AGG="${OUT_BASE}/agg_fscore_all.txt"

printf "algo\tparam\ttfa\tn_edges\tGS_src\tprecision\trecall\tfscore\tnetwork_filter\n" > "$GLOBAL_AGG"

for param in "${PARAMS[@]}"; do

    echo "===================================="
    echo "Running PARAM: $param"
    echo "===================================="

    bash "$GET_FSCORE" \
        -g "$GS_BASE" \
        -i "$INPUTS_BASE" \
        -o "$OUT_BASE" \
        -t "$FILTER_TOOL" \
        -c "$VALIDATE" \
        -n "$N_EDGE" \
        -p "$param" \
        -A "$GLOBAL_AGG"

done

echo
echo "Done: $GLOBAL_AGG"
