#!/bin/bash
set -x

IDX=gencode.vM30.transcripts.fa.idx

for FQZ1 in *.fq.gz ; do
  echo $FQZ1
  skewer -q 20 -t 16 $FQZ1
mRNA_rageko_ctrl_1.fq-trimmed.fastq
  FQT1=$(echo $FQZ1 | sed 's/fq.gz/fq-trimmed.fastq/')
  BASE=$(echo $FQZ1 | sed 's/.fq.gz//')
  kallisto quant -o $BASE -i $IDX -t 16 $FQT1 --single -l 120 -s 20
done

for TSV in */*abundance.tsv ; do
  NAME=$(echo $TSV | cut -d '/' -f1)
  cut -f1,4 $TSV | sed 1d | sed "s/^/${NAME}\t/"
done | pigz > 3col.tsv.gz
