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


## Key Idea

The **MERLIN-SUITE** pipeline consists of:

1. **Input Preparation**
   * **Expression matrix file (_expression.txt_)**: Normalized and tab-separated matrix of genename (x-axis) x cellname (y-axis) (no header; without cellname header).  The current study uses a matrix of 2100 genes x 4633 cells.
     ```text    
     Sept11	2.184866	3.061474	2.237097	1.874197 …
     Sep15	2.983654	4.238418	3.770023	3.214221 …
     Marc2	1.077569	1.325657	0.894839	0.909119 …
     Sept7	2.711823	2.964259	2.324860	2.874887 …
     Aars	2.094418	2.209428	1.095949	1.113439 …
     …
     Zic3	0.000000	0.000000	0.000000	0.000000 …
     Zscan10	0.000000	0.000000	0.000000	0.000000 …
     Zwilch	0.718379	1.325657	1.000460	0.000000 …
     Zwint	1.015942	2.072627	1.095949	1.437443 …
     Zyx	2.983654	4.592210	2.899609	4.430498 …
     ```
   * **Regulator list file (_regulators.txt_):** One-column list of transcription factor (TF) regulator names. In the present study, we used an _in-house_ mouse regulator list of 2683 TF regulators. 
     ```text
     0610010K14Rik
     100041979
     1700024P04Rik
     1700054O13Rik
     1810007M14Rik
     …
     Zscan21
     Zscan22
     Zscan4c
     Zswim4
     Zzz3
     ```
   * **Target list file (_targets.txt_):** One-column list of target gene names. Basically, it is the first column (all gene names) of _expression.txt_ file.
     ```text
     Sept11
     Sep15
     Marc2
     Sept7
     Aars
     …
     Zic3
     Zscan10
     Zwilch
     Zwint
     Zyx
     ```
   * **Prior network (_prior.txt_):** Three-columns tab-separated file. The first column is the regulator name, the second column is the target name, and the third column is the confidence score. The prior regulatory network should be cell-type agnostic and can be derived from bulk or single-cell ATAC-seq, ChIP-seq, perturbation assays, or sequence-specific motif information. We used a previously reported mouse prior regulatory network file ([McCalla _et al_. 2023](https://academic.oup.com/g3journal/article/13/3/jkad004/6982776)) comprising 4,435,063 edges.
     ```text
     9430076C15Rik	1110020A21Rik	0.945914
     9430076C15Rik	1110032A03Rik	0.945914
     9430076C15Rik	1200011I18Rik	0.945914
     9430076C15Rik	1300002E11Rik	0.945914
     9430076C15Rik	1500002F19Rik	0.945914
     …
     Zscan4f	Mcm6	0.0134771
     Zscan4f	2610002I17Rik	0.0107817
     Zscan4f	1700058P15Rik	0.00539084
     Zscan4f	Vasp	0.00539084
     Zscan4f	Cgn	0.00269542
     ```
2. **TFA estimation ([EstimateNCA](https://github.com/Roy-lab/EstimateNCA))**
   * Network component Analysis (NCA(unregularized)/NCA-LASSO(regularized))
3. **Augmented expression construction**
   * Combine expression + inferred TFA
4. **Duplication of Prior networks with TFA regulator**
   * Combine Prior network with regulators + prior network with TFA regulators
5. **GRN inference (MERLIN-P)**
    * Subsampling + aggregation
6. **Consensus network generation**
    * Subsampling + aggregation
    * Filtering consensus network with confidence score threshold ≥0.8
    * AUPR and F-score comparison with Gold standard networks
    * Co-clustering matrix generation to detect biologically meaningful modules
7. **Downstream visualization analysis for regulator prioritization**
    * Zeromean expression based module visualization and regulator inference
    * MERLIN-VIZ-based cell-cluster-specific module network visualiztion and regulator inference
    * Cytoscape-based condition-specific module network visualization and regulator inference
    * Pseudobulk-based cell-cluster-specific module network visualization and functional and regulator inference
  


