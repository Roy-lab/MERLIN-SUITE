#!/bin/bash
set -euo pipefail

module load conda3-py311_23.11.0-2

GET_AUPR=get_aupr_one_dataset.sh

FILTER_TOOL=filter_net_corrected.py

AUPR_WRAPPER=aupr_wrapper.sh

GS_BASE=data/mesc_gold

INPUTS_BASE=input_datasets

OUT_BASE=results/aupr_entries

mkdir -p "$OUT_BASE"

N_EDGE="all_edges"

PARAMS=(tfa0.000 tfa0.005 tfa0.020 tfa0.100)

GLOBAL_AGG="${OUT_BASE}/agg_aupr_all.txt"

> "$GLOBAL_AGG"

for param in "${PARAMS[@]}"; do

    echo "===================================="
    echo "Running PARAM: $param"
    echo "===================================="

    bash "$GET_AUPR" \
        -g "$GS_BASE" \
        -i "$INPUTS_BASE" \
        -o "$OUT_BASE" \
        -t "$FILTER_TOOL" \
        -w "$AUPR_WRAPPER" \
        -x "$N_EDGE" \
        -p "$param" \
        -A "$GLOBAL_AGG"

done

echo "Done: $GLOBAL_AGG"