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

## Installation of MERLIN-P-TFA

### Requirements

* Linux/Unix environment
* GNU Compiler Collection (GCC) ≥ 6.3.1
* GNU Scientific Library (GSL) ≥ 2.6

### Install dependencies

In MERLIN-SUITE, **[MERLIN-P-TFA](https://github.com/Roy-lab/MERLIN-P-TFA)** integrates two core components:<br> 
1. **[EstimateNCA](https://github.com/Roy-lab/EstimateNCA)**: for transcription factor activity (TFA) estimation.
2. **[MERLIN-P](https://github.com/Roy-lab/merlin-p)**: for probabilistic GRN inference.

#### Install EstimateNCA

```text
git clone https://github.com/Roy-lab/EstimateNCA.git
cd EstimateNCA
make
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:gsl_lib
```

#### Install MERLIN-P

```text
git clone https://github.com/Roy-lab/merlin-p.git
cd merlin-p
make
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:gsl_lib
```

#### Verify Installation

```text
# EstimateNCA
./NCALearner

# MERLIN-P
./merlin
```


## Study Overview

The overview of the study is as follows: <br><br>
<img width="600" height="800" alt="Figure1" src="https://github.com/user-attachments/assets/4b5bb1ba-b15e-44a5-bd58-6f045258ffa5" />


## Key Idea

The **MERLIN-SUITE** pipeline consists of:

1. **Input Preparation**
   * **Expression matrix file (_[expression.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/expression.txt.gz)_)**: Normalized and tab-separated matrix of genename (x-axis) x cellname (y-axis) (no header; without cellname header).  The current study uses a matrix of 2100 genes x 4633 cells.
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
   * **Regulator list file (_[regulators.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/regulators.txt)_):** One-column list of transcription factor (TF) regulator names. In the present study, we used an _in-house_ mouse regulator list of 2683 TF regulators. 
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
   * **Target list file (_[targets.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/targets.txt)_):** One-column list of target gene names. Basically, it is the first column (all gene names) of _expression.txt_ file.
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
   * **Prior network file (_[prior.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/prior.txt.gz)_):** Three-columns tab-separated file. The first column is the regulator name, the second column is the target name, and the third column is the confidence score. The prior regulatory network should be cell-type agnostic and can be derived from bulk or single-cell ATAC-seq, ChIP-seq, perturbation assays, or sequence-specific motif information. We used a previously reported mouse prior regulatory network file ([McCalla _et al_. 2023](https://academic.oup.com/g3journal/article/13/3/jkad004/6982776)) comprising 4,435,063 edges.
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

   <img width="363" height="213" alt="image" src="https://github.com/user-attachments/assets/1b486c56-5d9d-4adb-9836-4a8bb61c4875" /> ©[Siahpirani _et al_. 2025](https://pmc.ncbi.nlm.nih.gov/articles/PMC12259028/)<br>
   
   **Network component Analysis (NCA(unregularized)/NCA-LASSO(regularized)):** We used four different regularization parameter `λ (lambda)` that controls model regularization to infer **_P_** matrix (TFA). When `λ = 0.000`, **unregularized NCA** is applied; for positive `λ values (e.g., 0.005, 0.020, 0.100)`, **regularized NCA (NCA-LASSO)** is used. For, every `λ values`, **EstimateNCA** was run 100 times with different random initializations (rand0–rand99) to ensure robustness of the inferred TFA profiles.

   **Usage:**
   ```text
   #Unregularized NCA run (λ=0.000)
   ./NCALearner -d expression.txt -r regulators.txt -g targets.txt  -p prior.txt -l 0.000 -o results/Nca/Lambda_0000/RandInits/Rand_init_0
   #Regularized NCA run (λ=0.005)
   ./NCALearner -d expression.txt -r regulators.txt -g targets.txt  -p prior.txt -l 0.005 -o results/Nca/Lambda_0005/RandInits/Rand_init_25
   #Regularized NCA run (λ=0.020)
   ./NCALearner -d expression.txt -r regulators.txt -g targets.txt  -p prior.txt -l 0.020 -o results/Nca/Lambda_0020/RandInits/Rand_init_40
   #Regularized NCA run (λ=0.100)
   ./NCALearner -d expression.txt -r regulators.txt -g targets.txt  -p prior.txt -l 0.100 -o results/Nca/Lambda_0100/RandInits/Rand_init_99
   ```
   The description of each argument in the **EstimateNCA** run is as follows:
   <br>-**_d_** expression file (tab-separated) with no header (no cell metadata), rows for each gene.
   <br>-**_r_** list of the regulators to be used for a given target.
   <br>-**_g_** list of the target genes. Same rows (i.e., number of genes) as expression file.
   <br>-**_p_** prior network file (tab-separated).
   <br>-**_l_** the regularization parameter `λ (lambda)` controls model regularization. When `λ = 0.000`, **unregularized NCA** is applied; for positive `λ values (e.g., 0.005, 0.020, 0.100)`, **regularized NCA (NCA-LASSO)** is used.
   <br>-**_o_** specifies the output folder for storing EstimateNCA results for each of the 100 random initializations (Rand_init = 0-99).




   **Output:**

   EstimateNCA minimizes this following objective using expression profile (**_E_** matrix of genes x cells): <img width="169" height="60" alt="image" src="https://github.com/user-attachments/assets/214fcc67-c547-4087-8d27-d368924fb754" /> and outputs two files: [adj.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Nca/Lambda_0100/RandInits/Rand_init_99/adj.txt) (**_A_** matrix of regulators x target genes) and [tfa.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Nca/Lambda_0100/RandInits/Rand_init_99/tfa.txt) (**_P_** matrix of regulators x cells). The `adj.txt` file contains the updated regulatory edges with regularized regression coefficients , while `tfa.txt` contains the inferred latent TFA profiles for a subset of regulators. In this study, 131 TFA profiles were identified and saved in `tfa.txt`. The `tfa.txt` (a matrix dimension of 131 TFA by 4633 cells without cellnames) file is as follows:
   ```text
   Alx1	0.570941	-0.83527 …
   Ar	0.837172	0.159607 …
   Arnt	-0.17097	-1.97831 …
   Arx	-0.13052	0.894101 …
   Atf1	-0.569797	-0.793062 …
   …
   Zfp110	0.126722	0.201939 …
   Zfp143	-0.181769	-0.255976 …
   Zfp161	-0.416264	-0.529983 …
   Zfx	-0.580297	-0.35849 …
   Zic3	0.55224	0.356394 …
   ```
   These TFA profiles of the 131 regulators were averaged across 100 (rand0 to rand99) random initializations: [tfa_avg_0_99.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Nca/Lambda_0100/Tfa_files_avg/tfa_avg_0_99.txt) and appended with the suffix `_nca`: [tfa_avg_0_99_with_suffix.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Nca/Lambda_0100/Tfa_files_avg/tfa_avg_0_99_with_suffix.txt) to distinguish TFA profiles from gene expression profiles of the same regulators. The resulting `tfa_avg_0_99_with_suffix.txt` (a matrix dimension of 131 TFA by 4633 cells) file looks like following:
   ```text
   Alx1_nca	0.673105	-0.38819525 …
   Ar_nca	0.13416709	-0.55654479 …
   Arnt_nca	-0.213648992	-0.98972757 …
   Arx_nca	-0.135140926	0.81517808 …
   Atf1_nca	0.075423257	-0.38159042 …
   …
   Zfp110_nca	0.12169172	0.207829307 …
   Zfp143_nca	-0.298014921	0.12848773261 …
   Zfp161_nca	-0.25193142	-0.11648612 …
   Zfx_nca	-0.3895989	-0.380896417 …
   Zic3_nca	0.50783874	-0.148036293 …
   ```

   Notably, the `_nca` suffix can alternatively be replaced with `_TFA`, if desired.
 
2. **Augmented expression and regulator list construction**
   * **Combine expression + inferred TFA:** The averaged TFA profiles (`tfa_avg_0_99_with_suffix.txt`) were appended to the gene expression matrix to construct an augmented input for subsequent **MERLIN-P-TFA** analysis. For the analysis, the combined expression matrix of 2,231 genes (2,100 + 131) by 4,633 cells, without cell metadata, generated separately for each `λ (lambda)` setting. The combined gene-by-cell matrix (`net1_expression_gene_by_cell.txt`) was used as input to the **MERLIN-P** application for four different `λ` values. An example of the merged `gene-by-cell` expression matrix ([net1_expression_gene_by_cell.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/net1_expression_with_header_gene_by_cell.txt.gz)) for `λ = 0.100` is shown below:
     
      ```text
      Sept11	2.184866	3.061474 …
      Sep15	2.983654	4.238418 …
      Marc2	1.077569	1.325657 …
      Sept7	2.711823	2.964259  …
      Aars	2.094418	2.209428 …
      …
      Zfp110_nca	0.12169172	0.207829307 …
      Zfp143_nca	-0.298014921	0.12848773261 …
      Zfp161_nca	-0.25193142	-0.11648612 …
      Zfx_nca	-0.3895989	-0.380896417 …
      Zic3_nca	0.50783874	-0.148036293 …
      ```
      Since, **MERLIN-P** considers the input to be in the `cell-by-gene` format without cell meta information, therefore, the final version of input expression matrix  ([net1_expression.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/net1_expression.txt.gz)) looks like as follows:
      ```text
      Sept11	Sep15	Marc2 …
      2.184866	2.983654	1.077569 …
      3.061474	4.238418	1.325657 …
      2.237097	3.770023	0.894839 …
      1.874197	3.214221	0.909119 …
      …
      0.000000	0.000000	0.000000 …
      2.087869	0.000000	0.000000 …
      2.965649	0.000000	0.000000 …
      0.000000	2.157659	0.000000 …
      0.000000	2.188965	0.000000 …
      ```
   
   * **Combine regulator list + inferred TFA:** In parallel, the list of candidate regulators (2683 TF regulators) was updated to include transcription factors corresponding to the inferred TFA profiles (131 TFA genes). The updated regulators (2683 + 131 = 2814 entries) list file ([net1_transcription_factors.tsv](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/net1_transcription_factors.tsv)) looks like,
      ```text
      0610010K14Rik
      100041979
      1700024P04Rik
      1700054O13Rik
      1810007M14Rik
      …
      Zfp110_nca
      Zfp143_nca
      Zfp161_nca
      Zfx_nca
      Zic3_nca
      ```

      These augmented datasets (expression matrix and regulator list) were then used to infer gene regulatory networks (GRNs) using **MERLIN-P**.
   
   
3. **Duplication of Prior networks with TFA regulator**
<br><br>Because TFA profiles were incorporated into both the input expression matrix and the regulator list, a corresponding update was also applied to the prior network file. To incorporate TFA regulators, each regulatory interaction was duplicated by appending the suffix `_nca` to the corresponding TF regulator names in the original prior network file ([prior.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/prior.txt.gz); containing 4,435,063 edges), used for the **EstimateNCA** application. This expansion resulted in a final prior network file (`net1_net.txt`) containing 8,870,126 edges, which was used as input for the **MERLIN-P** run.
   ```text
   9430076C15Rik	1110020A21Rik	0.945914
   9430076C15Rik_nca	1110020A21Rik	0.945914
   9430076C15Rik	1110032A03Rik	0.945914
   9430076C15Rik_nca	1110032A03Rik	0.945914
   …
   Zscan4f	Vasp	0.00539084
   Zscan4f_nca	Vasp	0.00539084
   Zscan4f	Cgn	0.00269542
   Zscan4f_nca	Cgn	0.00269542
   ```
4. **Initial cluster assignment file**
<br><br>**MERLIN-P** requires an initial cluster (module) assignment file ([clusterassign.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/clusterassign.txt)) corresponding to the genes in the original expression matrix (`expression.txt`; 2,100 target genes). This file provides the starting point for iterative reassignment and refinement of gene module memberships until convergence.
The file is formatted as a two-column table: the first column contains target gene names, and the second column contains their corresponding initial module IDs. The input cluster assignment file is shown below.
   ```text
   Sept11	1
   Sep15	2
   Marc2	3
   Sept7	4
   Aars	5
   …
   Zic3	2096
   Zscan10	2097
   Zwilch	2098
   Zwint	2099
   Zyx	2100
   ```

5. **MERLIN-P configuration file**
<br><br>**MERLIN-P** requires a configuration file ([net1_config.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/net1_config.txt)) which is a three-column, tab-delimited file in which each row corresponds to a prior network. The first column specifies the network name, the second column provides the file path to the prior network, and the third column indicates the network confidence, where higher values confer greater influence of the prior during model inference.
6. **GRN inference (MERLIN-P)**
   * _**Subsampling**_
   <br><br>To reduce computational burden and enable consensus confidence-based GRN inference, we subsampled the expression matrix ([net1_expression.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/net1_expression.txt.gz)) by randomly partitioning the full dataset (4,633 cells) into half-sized (50%) subsets of 2,317 cells. This subsampling procedure was repeated 50 times using independent random partitions. Each subsample directory ([Subsamples_n2317](https://github.com/Roy-lab/MERLIN-SUITE/tree/main/data/Subsamples_n2317)) contains 50 index files ([dataindices0.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/Subsamples_n2317/dataindices0.txt)–dataindices49.txt) specifying the selected cells, along with the corresponding subsampled expression matrices of 2,231 genes and TFAs ([dataset0.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/Subsamples_n2317/dataset0.txt.gz)–dataset49.txt). A summary of all subsampled datasets is provided in [subsample_n2317_list.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/subsample_n2317_list.txt).

   * _**MERLIN-P run**_
   <br><br>Based on the generated subsamples, MERLIN-P was executed independently for each subsample. In this study, a total of 20 subsamples were analyzed. An example command for one such run (for dataset0 subsample setting) is shown below:
      ```text
      ./merlin -d Subsamples_n2317/dataset0.txt -l net1_transcription_factors.tsv -q net1_config.txt -c clusterassign.txt -o results/out.0/
      ```
      The description of each argument in the **MERLIN-P** run is as follows:
   <br>-**_d_** expression file, subsampled or original.
   <br>-**_l_** list of regulators including TFA regulators.
   <br>-**_q_** configuration file containing prior network information.
   <br>-**_c_** initial cluster (module) assignment file.
   <br>-**_o_** output folder location.

      **MERLIN-P** can also be run on the original dataset without subsampling; however, this approach is computationally more expensive and time-intensive. An example command for running **MERLIN-P** on the full dataset is provided below:
      ```text
      ./merlin -d net1_expression.txt -l net1_transcription_factors.tsv -q net1_config.txt -c clusterassign.txt -o out_dir/
      ```

   * _**Output Inferred GRN**_
   <br><br>**MERLIN-P** outputs regulatory edges between regulators and target genes, which are available in the [result folder](https://github.com/Roy-lab/MERLIN-SUITE/tree/main/results/Merlinp/Lambda_0100/out.0). The output result folder includes a subfolder named [fold0](https://github.com/Roy-lab/MERLIN-SUITE/tree/main/results/Merlinp/Lambda_0100/out.0/fold0) subfolder, there are five files: [iter.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/out.0/fold0/iter.txt) (number of iteration performed), [last.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/out.0/fold0/last.txt), **[modules.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/out.0/fold0/modules.txt)** (final module assignment of genes), [pll.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/out.0/fold0/pll.txt), and the most important file is **[prediction_k300.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/out.0/fold0/prediction_k300.txt)**, which contains the inferred regulatory network. The format of the regulatory network file is similar to the input prior network, with the first column specifying the regulator, the second column the target gene, and the third column represents the regression coefficient.

      Example lines from the inferred regulatory network file `prediction_k300.txt` are as follows:
      ```text
      Atf2_nca	1110038B12Rik	0.123109
      Id3	1110038B12Rik	0.0377104
      ```  
  
      Example lines from the inferred module file `modules.txt` are as follows:
      ```text
      1500015O10Rik	0
      1810058I24Rik	1
      2310022B05Rik	2
      2410015M20Rik	3
      2810004N23Rik	4
      9530068E07Rik	5
      Aatf	6
      …
      Tk1	1132
      Top2a	1132
      Tpx2	1132
      Ube2c	1132
      Klf6	1133
      Vasp	1133
      ```

7. **Consensus network generation**
    * _**Filtering consensus network with confidence score threshold ≥0.8**_
      <br><br>Since **MERLIN-P** was run on 20 subsamples, we generated consensus networks across all subsamples and filtered edges using an **80% confidence threshold**, retaining only those edges that appeared in at least 16 out of 20 subsamples.
      For this [estimateedgeconf package from merlin-auxillary tool](https://github.com/Roy-lab/merlin-auxillary) was used, which is as follows:
      ```text
      ## Syntax: estimateEdgeConf <filenamelist> <confidence> <outputfile> <filterededges|alledges>
      e.g., for λ = 0.100,
      estimateEdgeConf results/Merlinp/Lambda_0100/network_files.txt 0 n20_subsamples_lambda_0100_ alledges
      ```
      **Output (λ = 0.100):** [n20_subsamples_lambda_0100_alledge.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/n20_subsamples_lambda_0100_alledge.txt) <br><br>

      Now, selecting the edges with confidence >= 0.8 from the consensus network
      ```text
      awk -F "\t" '{if ($3 >= 0.8) { print $0; }}' OFS="\t" n20_subsamples_lambda_0100_alledge.txt > n20_subsamples_lambda_0100_0_8.txt
      ## Sort the aforementioned edges in descending order of their confidence values:
      ## -k3 = sort by column 3 as key.
      ## -g = compare acc. to general numeric value.
      ## -r = reverse order i.e. desc (by default, asc).
      sort -gr -k3 n20_subsamples_lambda_0100_0_8.txt > n20_subsamples_lambda_0100_0_8_sorted.txt
      ```
      **Output (λ = 0.100, confidence score threshold ≥0.8):** [n20_subsamples_lambda_0100_0_8_sorted.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/n20_subsamples_lambda_0100_0_8_sorted.txt) <br><br>
      

    * _**Co-clustering matrix generation to detect biologically meaningful modules**_
    <br><br>We used module assignment files from 20 subsamples to generate a co-clustering matrix for each `λ` setting. This matrix has dimensions (#target genes × #target genes), where the (_i_, _j_)-th entry represents the frequency with which genes _i_ and _j_ were assigned to the same module across subsamples. For example, a value of 0.5 indicates that the two genes were co-clustered in 10 out of 20 subsamples. The matrix is symmetric, with diagonal entries equal to 1. We used the [assessClusterStab package (merlin-auxillary)](https://github.com/Roy-lab/merlin-auxillary):
      ```text
      ## Syntax: assessClusterStab <module_filename_list> <output_file>
      ## e.g., for λ = 0.100,
      assessClusterStab results/Merlinp/Lambda_0100/module_files.txt coclustering_matrix.txt
      ```
      **Output (λ = 0.100):** [coclustering_matrix.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/coclustering_matrix.txt) <br><br>
      

    * _**Deriving consensus modules from the co-clustering matrix**_
    <br><br>Consensus modules were obtained by applying co-clustering score thresholds ranging from `0.1` to `0.4` for each `λ`. We used the [optimalleaforder package (merlin-auxillary)](https://github.com/Roy-lab/merlin-auxillary):
      ```text
      ## Syntax: reorder <co_clustering_matrix> <list|pair|matrix> <out_file_prefix> <threshold>
      ## e.g., for λ = 0.100 and co-clustering score cut-off: 0.1,
      reorder results/Merlinp/Lambda_0100/coclustering_matrix.txt matrix consensus_module_0_1 0.1
      ```
      **Outputs (λ = 0.100, threshold = 0.1):**
      [consensus_module_0_1_assign.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/consensus_module_0_1_assign.txt); [consensus_module_0_1_geneset.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/consensus_module_0_1_geneset.txt) <br><br>


    * _**GO functional enrichment and regulator enrichment analysis**_
    <br><br>For both Gene Ontology (GO) and regulator enrichment analyses, we considered modules containing at least five genes. A Python script ([makeGroup.py](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/scripts/makeGroup.py)) was used to extract and format such modules for downstream enrichment analysis.
      ```text
      ## Syntax: python makeGroup.py <consensus_module_file> <output_file_name> <min_gene_threshold>
      ## Example (λ = 0.100, threshold = 0.1):
      python scripts/makeGroup.py consensus_module_0_1_geneset.txt consensus_module_0_1_geneset_enrichAnalyzer.txt 5
      ```
      **Output (λ = 0.100, threshold = 0.1):**
      [consensus_module_0_1_geneset_enrichAnalyzer.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/consensus_module_0_1_geneset_enrichAnalyzer.txt)<br><br>
      
      For enrichment analysis, GO term annotations per gene were obtained from an _in-house_ [GO annotation file](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/mousegotermap_regnet.txt.gz). Regulator–target relationships were formatted to match the enrichment tool's input requirements, i.e., filenames containing the keyword `_regnet` and edge format: `<target>\t<regulator>`. The network file was reformatted using:
      ```text
      cat n20_subsamples_lambda_0100_0_8_sorted.txt | awk '{printf("%s\t%s\n", $2, $1)}' > n20_subsamples_lambda_0100_0_8_sorted_regnet.txt
      ```
      **Output regulator file**
      [n20_subsamples_lambda_0100_0_8_sorted_regnet.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/n20_subsamples_lambda_0100_0_8_sorted.txt)<br><br>
      
      GO functional and regulator enrichment analyses were performed using the [enrichAnalyzer program](https://github.com/Roy-lab/enrichAnalyzer_Nongraph/) via the script: [run_enrichAnalyzer.sh](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/scripts/run_enrichAnalyzer.sh):
      ```text
      chmod 775 run_enrichAnalyzer.sh
      bash run_enrichAnalyzer.sh
      ```
      **Outputs (λ = 0.100, threshold = 0.1):**
      1. GO enrichment: [go_enrichAnalysis_0_1_details.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/go_enrichAnalysis_0_1_details.txt)
      2. Regulator enrichment: [regulator_enrichAnalysis_0_1_details.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/regulator_enrichAnalysis_0_1_details.txt)<br>
      
      For each co-clustering threshold, we computed the proportion of enriched modules as:
      ```text
      (Number of enriched modules with ≥5 genes) / (Total number of modules with ≥5 genes)
      ```
      The threshold that maximized the proportion of GO-enriched modules was selected as optimal for each `λ`.   


    * _**AUPR and F-score comparison with Gold standard networks**_
      <br><br>To evaluate the accuracy of inferred gene regulatory networks, we compared predicted edges against experimentally derived mouse embryonic stem cell (mESC) gold standard networks using **Area Under the Precision–Recall Curve (AUPR)** and **F-score** metrics.
      For AUPR, predicted edges were ranked by confidence, and precision and recall were computed incrementally as edges were added. The area under the resulting precision–recall curve was then calculated. AUPR provides a global assessment of network quality by considering the full ranked list of predicted interactions and is particularly well-suited for sparse biological networks. We used [six mESC gold standard networks](https://github.com/Roy-lab/MERLIN-SUITE/tree/main/data/mesc_gold)—three each derived from RNA-seq and microarray data—for knockdown (KD), ChIP-seq (ChIP), and combined (KD+ChIP) conditions. AUPR was computed using the script [calcAupr.sh](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/scripts/calcAupr.sh), which requires the wrapper script, [aupr_wrapper.sh](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/scripts/aupr_wrapper.sh)and associated executable and JAR files from the [Roylab AUPR GitHub repository](https://github.com/Roy-lab/scRNAseq_NetInference/tree/master/scripts/wrapper_metrics/AUPR).
      ```text
      chmod 775 calcAupr.sh
      bash calcAupr.sh
      ```      
      **Main Output**
      [agg_aupr.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/aupr_results/agg_aupr.txt) — summarizes AUPR scores across all gold standard networks. <br><br>

      In contrast, the **F-score** was computed using the network edges, reflecting the balance between precision and recall. As the harmonic mean of precision and recall, this metric emphasizes the accuracy of MERLIN predictions relative to the gold standard and complements AUPR. F-score was computed using the script: [Fscore.sh](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/scripts/Fscore.sh), which requires the [validate](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/scripts/validate) tool.
      ```text
      chmod 775 Fscore.sh
      bash Fscore.sh
      ```
      **Main Outputs**<br>  
      [edge_validation.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/fscore/edge_validation.txt) — F-score, Precision, Recall of network edges.<br>
      [regulator_validation.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/fscore/regulator_validation.txt) — F-score, Precision, Recall of regulators.<br>
      [target_validation.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/fscore/target_validation.txt) — F-score, Precision, Recall of targets. <br><br>
      Both AUPR and F-score values were visualized using the [Heatmap.awk](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/scripts/Heatmap.awk) tool with a combined input file [plot_input.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/aupr_results/plot_input.txt), executed via the script [AUPR_Fscore_plotting.sh](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/scripts/AUPR_Fscore_plotting.sh)
      ```text
      chmod 775 AUPR_Fscore_plotting.sh
      bash AUPR_Fscore_plotting.sh
      ```
      **Main Output** [AUPR_Fscore.svg](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/aupr_results/AUPR_Fscore.svg) — AUPR and F-score sumamry figure file.
      
10. **Downstream visualization analysis for regulator prioritization**
    * _**Zeromean expression-based module visualization and regulator inference**_
      <br><br>**Zero-mean expression–based module visualization** is a primary technique for interpreting MERLIN-inferred module networks. This approach uses a normalized expression matrix [expression_with_reordered_cellmetadata.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/expression_with_reordered_cellmetadata.txt.gz) (2,231 rows: 2,100 genes + 131 transcription factor activities (TFAs); 4,633 cells as columns), along with cell metadata (sorted as per the cell cluster order) provided in the header. Visualization is performed using the MATLAB script [visualizeAllMERLINCluster_withreg.m](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Zeromean_expression_profile/visualizeAllMERLINCluster_withreg.m), which internally calls the wrapper scripts [showClusterWithReg_All.m](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Zeromean_expression_profile/showClusterWithReg_All.m) and [getGeneIDs.m](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Zeromean_expression_profile/getGeneIDs.m). In addition to the expression file, [visualizeAllMERLINCluster_withreg.m](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Zeromean_expression_profile/visualizeAllMERLINCluster_withreg.m) requires two additional inputs: a consensus module file (e.g., [consensus_module_0_2_geneset.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/consensus_module_0_2_geneset.txt)) and a list file containing both GO functional and regulator enrichment summaries (e.g., [list.0_8.0_2.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/list.0_8.0_2.txt)). We prepared the list file, using the following bash commands:
      ```text
      Extract the list of GO and regulator/TF terms from the enrichAnalyzer output files.
      ## pwd=results/Merlinp/Lambda_0100/
      ## Create the output dir
      ## Print enriched term (GO or TF) first, cluster ID second, index third (1 for GO, 2 for expression regulators). Also, replace space with "_" for the GO terms.
      cut -f1,2 go_enrichAnalysis_0_1_details.txt | sed 's/\ /_/g' | awk '{ printf("%s\t%s\t%s\n", $2, $1, 1) }' > list.0_8.0_1.txt
      cut -f1,2 regulator_enrichAnalysis_0_1_details.txt | sed 's/\ /_/g' | awk '{ printf("%s\t%s\t%s\n", $2, $1, 2)}' >> list.0_8.0_1.txt
      cut -f1,2 go_enrichAnalysis_0_2_details.txt | sed 's/\ /_/g' | awk '{ printf("%s\t%s\t%s\n", $2, $1, 1) }' > list.0_8.0_2.txt
      cut -f1,2 regulator_enrichAnalysis_0_2_details.txt | sed 's/\ /_/g' | awk '{ printf("%s\t%s\t%s\n", $2, $1, 2)}' >> list.0_8.0_2.txt
      cut -f1,2 go_enrichAnalysis_0_3_details.txt | sed 's/\ /_/g' | awk '{ printf("%s\t%s\t%s\n", $2, $1, 1) }' > list.0_8.0_3.txt
      cut -f1,2 regulator_enrichAnalysis_0_3_details.txt | sed 's/\ /_/g' | awk '{ printf("%s\t%s\t%s\n", $2, $1, 2)}' >> list.0_8.0_3.txt
      cut -f1,2 go_enrichAnalysis_0_4_details.txt | sed 's/\ /_/g' | awk '{ printf("%s\t%s\t%s\n", $2, $1, 1) }' > list.0_8.0_4.txt
      cut -f1,2 regulator_enrichAnalysis_0_4_details.txt | sed 's/\ /_/g' | awk '{ printf("%s\t%s\t%s\n", $2, $1, 2)}' >> list.0_8.0_4.txt
      ```
      
      This workflow generates:
      (1) A global heatmap showing zero-mean expression of module genes across all cells
      (2) Module-specific heatmaps, where: target genes are shown in the top rows, regulators are shown in the bottom rows, the two are separated by a red boundary line. The execution is as follows:
      ```text
      module load matlab-2022b
      matlab -nodisplay -r visualizeAllMERLINCluster_withreg
      ```
      **Main Outputs**
      <br>[allcids_min5.svg](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Zeromean_expression_profile/allcids_min5.svg) — global zero-mean expression heatmap of module genes across all cells <br>
      [C856.svg](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Zeromean_expression_profile/C856.svg) to [C1088.svg](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Zeromean_expression_profile/C1088.svg) — module-specific heatmaps showing: target genes (top rows), regulators (bottom rows), separated by a red boundary line.<br><br>
      
    * _**MERLIN-VIZ-based cell-cluster-specific module network visualiztion and regulator inference**_
      <br><br>**MERLIN-VIZ** is an [R Shiny-based application](https://github.com/Roy-lab/MERLIN-VIZ) for visualizing MERLIN-inferred gene regulatory networks (GRNs). The tool supports analyses using: all cells jointly, or individual cell clusters and is applicable to both bulk and single-cell-derived GRNs. The application can be downloaded from the [merlin_viz_singlecell branch](https://github.com/Roy-lab/MERLIN-VIZ/tree/merlin_viz_singlecell) of the [MERLIN-VIZ GitHub repository](https://github.com/Roy-lab/MERLIN-VIZ). To initialize the application, the script [net_data_setup.R](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/MERLIN-VIZ_cellcluster_specific_module_network_visualization/net_data_setup.R) (Input file requirements are described in detail within `net_data_setup.R`) must be run once together with [aux_functions.R](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/MERLIN-VIZ_cellcluster_specific_module_network_visualization/aux_functions.R). This step generates the file [net_data.Rdata](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/MERLIN-VIZ_cellcluster_specific_module_network_visualization/net_data.Rdata), which serves as the primary input for the MERLIN-VIZ Shiny application [app.R](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/MERLIN-VIZ_cellcluster_specific_module_network_visualization/app.R). The following steps are required to launch the MERLIN-VIZ application:
      ```text
      Rscript net_data_setup.R
      R
      > load('net_data.Rdata')
      > q()
      Rscript app.R // or Alternatively, app.R can be launched directly from an interactive R session.
      ```
      Using the application, users can interactively visualize and download high-quality global and cell-cluster-specific module regulatory networks. Example output networks for [Module921](https://github.com/Roy-lab/MERLIN-SUITE/tree/main/visualization/MERLIN-VIZ_cellcluster_specific_module_network_visualization/Module921) are provided.
      
    * _**Cytoscape-based condition-specific module network visualization and regulator inference**_
      This visualization provides the condition-specific module network information and network rewiring in a per-module-based way. This requires Cytoscape software for the visualization. The steps are as following:<br>
      **Step-1: Creating module gene file**
      <br>In parity with the previous heading, looking at the network rewiring for the module of interest: Module921. For that, first the module gene file is created using the script file [get_module_genes.sh](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Cytoscape_based_condition_specific_visualization/get_module_genes.sh) based on the input of a text file that declares the modules of interest (i.e., [modules.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Cytoscape_based_condition_specific_visualization/modules.txt)), and second is the consensus module assignment file (i.e. [consensus_module_0_2_geneset.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/consensus_module_0_2_geneset.txt)).
      ```text
      chmod 775 get_module_genes.sh
      bash get_module_genes.sh
      ```
      **Main Output**
      <br>[module_921/genes_in_mod921.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Cytoscape_based_condition_specific_visualization/module_921/genes_in_mod921.txt)<br>

      **Step-2: Creating module subnetwork file**
      Next, from the MERLIN-inferred modules, the module-specific subnetwork is trimmed based on the constituent genes present in the module using the script [get_module_subnet.sh](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Cytoscape_based_condition_specific_visualization/get_module_subnet.sh) that uses an input MERLIN-inferred network file (e.g., [n20_subsamples_lambda_0100_0_8.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Cytoscape_based_condition_specific_visualization/get_module_subnet.sh)).
      ```text
      chmod 775 get_module_subnet.sh
      bash get_module_subnet.sh
      ```
      **Main Output**
      <br>[module_921/subnet_glut_mod_921.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Cytoscape_based_condition_specific_visualization/module_921/subnet_glut_mod_921.txt)<br>

      **Step-3: Creating transpose of the expression matrix**
      Now, the script [transpose_expression.sh](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Cytoscape_based_condition_specific_visualization/transpose_expression.sh) uses [expression_with_reordered_cellmetadata.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/expression_with_reordered_cellmetadata.txt.gz) (gene x cell) as input to generate [expression_with_reordered_cellmetadata_transpose.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/expression_with_reordered_cellmetadata_transpose.txt.gz) (Cell x gene) matrix for further usage.
      ```text
      chmod 775 transpose_expression.sh
      bash transpose_expression.sh
      ```
      **Main Output**
      <br>[expression_with_reordered_cellmetadata_transpose.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/expression_with_reordered_cellmetadata_transpose.txt.gz)<br>

      **Step-3: Creating an individual condition-specific expression matrix for a module**
      
      
    * _**Pseudobulk-based cell-cluster-specific module network visualization and functional and regulator inference**_
      In addition to zero-mean expression, MERLIN-inferred modules can be visualized using cell-cluster-specific pseudobulk expression profiles. This approach aggregates gene expression across cells within each cluster to provide a more robust, cluster-level view of module activity. Pseudobulk profiles are generated using the Python script [psb_ClusterID.py](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Pseudobulk_expression_profile/psb_ClusterID.py), which requires the following inputs: **Expression matrix** ([**net1_expression_with_header_gene_by_cell.txt**](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/net1_expression_with_header_gene_by_cell.txt.gz)) and **Cell cluster assignments** ([**cell_clusters.txt**](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/cell_clusters.txt)). The script aggregates expression values for all cells within each cluster and generates cell-cluster-specific pseudobulk expression profiles.
      ```text
      python psb_ClusterID.py
      ```
      **Main Output** [pseudobulk_expr.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Pseudobulk_expression_profile/pseudobulk_expr.txt) — Aggregated pseudobulk expression across 15 cell clusters for 2,100 genes and 131 TFAs. Gene expression values are expected to be non-negative. However, since transcription factor activities (TFAs) are inferred quantities, their aggregated pseudobulk values may be negative. These values should be interpreted as relative activity levels rather than absolute expression.

      Next, the module assignment file is reordered according to the gene order in the pseudobulk expression matrix using the Python script [reorderModuleGenes.py](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Pseudobulk_expression_profile/reorderModuleGenes.py).
      ```text
      tail -n +2  pseudobulk_expr.txt > pseudobulk_expr_noheader.txt
      python reorderModuleGenes.py pseudobulk_expr_noheader.txt results/Merlinp/Lambda_0100/consensus_module_0_2_geneset.txt reordered_consensus_module_0_2_geneset.txt
      ```
      **Main Output**
      <br>[pseudobulk_expr_noheader.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Pseudobulk_expression_profile/pseudobulk_expr_noheader.txt)
      <br>[reordered_consensus_module_0_2_geneset.txt](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Pseudobulk_expression_profile/reordered_consensus_module_0_2_geneset.txt) — Reordered module assignment file.

      <br>The pseudobulk expression heatmap input files for both global and module-specific visualizations are then generated using the [genClusterAttrib](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/scripts/genClusterAttrib) tool. This program requires:
      <br>[list file](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/list.0_8.0_2.txt)
      <br>[regulator enrichment file](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/regulator_enrichAnalysis_0_2_details.txt)
      <br>[reordered module assignment file](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Pseudobulk_expression_profile/reordered_consensus_module_0_2_geneset.txt)
      <br>[GO functional enrichment file](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/results/Merlinp/Lambda_0100/go_enrichAnalysis_0_2_details.txt)
      <br>[ordered cell cluster information file](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/data/Cluster_ID.txt)
      <br>[pseudobulk expression file without header](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Pseudobulk_expression_profile/pseudobulk_expr_noheader.txt)
      <br>[output directory](https://github.com/Roy-lab/MERLIN-SUITE/tree/main/visualization/Pseudobulk_expression_profile/heatmap_in)
      <br>minimum module size threshold
   
      ```text
      visualization/Pseudobulk_expression_profile/genClusterAttrib \
      -l results/Merlinp/Lambda_0100/list.0_8.0_2.txt \
      -r results/Merlinp/Lambda_0100/regulator_enrichAnalysis_0_2_details.txt \
      -m reordered_consensus_module_0_2_geneset.txt \
      -g results/Merlinp/Lambda_0100/go_enrichAnalysis_0_2_details.txt \
      -h data/Cluster_ID.txt
      -e visualization/Pseudobulk_expression_profile/pseudobulk_expr_noheader.txt
      -o visualization/Pseudobulk_expression_profile/heatmap_in/
      -t 5 # includes modules containing >=5 genes
      ```
      **Main Output folder** [heatmap_in](https://github.com/Roy-lab/MERLIN-SUITE/tree/main/visualization/Pseudobulk_expression_profile/heatmap_in)

      Finally, heatmaps for both global module-average expression and individual module-specific expression profiles, along with GO functional and regulator enrichment annotations, are generated from the attribute and regulator information files in [heatmap_in](https://github.com/Roy-lab/MERLIN-SUITE/tree/main/visualization/Pseudobulk_expression_profile/heatmap_in). Visualization is performed using the bash script [makeHeatmap.sh](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Pseudobulk_expression_profile/makeHeatmap.sh), which internally uses the [Heatmap.awk](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/scripts/Heatmap.awk) tool.
      
      ```text
      chmod 775 makeHeatmap.sh
      bash makeHeatmap.sh
      ```
      **Main Output folder** [heatmap_out](https://github.com/Roy-lab/MERLIN-SUITE/tree/main/visualization/Pseudobulk_expression_profile/heatmap_out)<br>
      **Main Output files**
      <br>[ModuleAvg.svg](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Pseudobulk_expression_profile/heatmap_out/ModuleAvg.svg) — average pseudobulk expression heatmap of all modules across all cell clusters. <br>
      [Cluster856.svg](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Pseudobulk_expression_profile/heatmap_out/Cluster856.svg) to [Cluster1088.svg](https://github.com/Roy-lab/MERLIN-SUITE/blob/main/visualization/Pseudobulk_expression_profile/heatmap_out/Cluster1088.svg) — module-specific regulator–target pseudobulk expression heatmaps across cell clusters, including GO functional and regulator enrichment annotations.<br><br>
      

      
  


