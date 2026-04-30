# MERLIN-SUITE
This repository consolidates **MERLIN-SUITE** of algorithms and downstream visualization scripts.

## Overview
**MERLIN-SUITE** is a unified framework for reconstructing gene regulatory networks (GRNs) by integrating:

* Gene expression data (bulk or single-cell)
* Regulatory prior knowledge (motif, ChIP-seq, perturbation)
* Latent transcription factor activity (TFA)

It extends the original MERLIN framework into a full pipeline:

**[MERLIN](https://github.com/Roy-lab/merlin)**: Expression-based modular GRN inference ([Roy _et al_. 2013](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003252)) <br>
**[MERLIN-P](https://github.com/Roy-lab/merlin-p)**: MERLIN + Incorporates regulatory priors ([Siahpirani & Roy, 2017](https://academic.oup.com/nar/article/45/4/e21/2333925)) <br>
**[MERLIN-P-TFA](https://github.com/Roy-lab/MERLIN-P-TFA)**: MERLIN-P + Integrates inferred transcription factor activity ([Siahpirani _et al_. 2025](https://pmc.ncbi.nlm.nih.gov/articles/PMC12259028/)) <br>

This repository consolidates the full workflow along with downstream analysis and visualization (**[MERLIN-VIZ](https://github.com/Roy-lab/MERLIN-VIZ)** and others) scripts.

## Key Idea

Traditional GRN inference relies on mRNA levels, which often poorly reflect TF activity. MERLIN-SUITE addresses this to infer more biologically meaningful and robust GRNs by combining:

* Probabilistic graphical modeling
* Modular gene co-regulation
* Prior biological knowledge
* Activity-based regulation (TFA)

This page is associated with a bookchapter that describes the whole MERLIN-SUITE thorugh the analysis of a publicly available [single-cell multi-omics dataset (Tran _et al_. 2019)](https://www.sciencedirect.com/science/article/pii/S2211124719305297?via%3Dihub) of mouse cellular reprogramming.

The overview of the study is as follows: <br><br>
<img width="600" height="800" alt="Figure1" src="https://github.com/user-attachments/assets/4b5bb1ba-b15e-44a5-bd58-6f045258ffa5" />

