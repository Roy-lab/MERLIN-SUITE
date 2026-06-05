regs.txt - Regulator file (_nca regulators are stripped)
tgts.txt - target file (_nca are stripped, if any)

### obtained from:

## tfa0.000
cut -f1 results/Merlinp/Lambda_0000/n20_subsamples_lambda_0000_0_8_sorted.txt | sed 's/_nca//g' | sort -u > tfa0.000/regs.txt
cut -f2 results/Merlinp/Lambda_0000/n20_subsamples_lambda_0000_0_8_sorted.txt | sed 's/_nca//g' | sort -u > tfa0.000/tgts.txt

## tfa0.005
cut -f1 results/Merlinp/Lambda_0005/n20_subsamples_lambda_0005_0_8_sorted.txt | sed 's/_nca//g' | sort -u > tfa0.005/regs.txt
cut -f2 results/Merlinp/Lambda_0005/n20_subsamples_lambda_0005_0_8_sorted.txt | sed 's/_nca//g' | sort -u > tfa0.005/tgts.txt

## tfa0.020
cut -f1 results/Merlinp/Lambda_0020/n20_subsamples_lambda_0020_0_8_sorted.txt | sed 's/_nca//g' | sort -u > tfa0.020/regs.txt
cut -f2 results/Merlinp/Lambda_0020/n20_subsamples_lambda_0020_0_8_sorted.txt | sed 's/_nca//g' | sort -u > tfa0.020/tgts.txt

## tfa0.100
cut -f1 results/Merlinp/Lambda_0100//n20_subsamples_lambda_0100_0_8_sorted.txt | sed 's/_nca//g' | sort -u > tfa0.100/regs.txt
cut -f2 results/Merlinp/Lambda_0100//n20_subsamples_lambda_0100_0_8_sorted.txt | sed 's/_nca//g' | sort -u > tfa0.100/tgts.txt
