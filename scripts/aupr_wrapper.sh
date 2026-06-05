#!/bin/sh

#The first input is gold standard
#First column is TFs, Second column is Targets, it is not weigthed
#The second input is inferred network
#First column is TFs, Second column is Targets, Third column is ranking (higher is better)
#The third input is prefix of outputs
#So if we run:
#bash aupr_wrapper.sh gold.txt inferred.txt out
#the script will create: 
#out.txt which is the precisions and recalls
#out.txt.roc  which is ROC values
#out.txt.pr   which is the PR values
#out.txt.sprt which is the smoothed PR values (there will be only 100 values)
#out.out.txt  which has the area under PR and ROC curves


e=`cat $1 | sort -u | wc -l`
x=`cut -f1 $1 | sort -u | wc -l`
y=`cut -f2 $1 | sort -u | wc -l`
let a=x*y
let c=a-e

/mnt/dv/wid/projects2/Roy-common/programs/thirdparty/aupr/getPR_cpp/getPR $1 $2 0 1 $3.txt
java -jar /mnt/dv/wid/projects2/Roy-common/programs/thirdparty/aupr/auc.jar $3.txt PR $e $c > $3.out.txt

