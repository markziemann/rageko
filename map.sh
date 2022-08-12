#!/bin/bash
set -x

IDX=../ref/Rattus_norvegicus.mRatBN7.2.cdna_ncrna.all.fa.idx

for FQZ1 in *_1.fq.gz ; do
  FQZ2=$(echo $FQZ1 | sed 's/_1.fq/_2.fq/')
  echo $FQZ1 $FQZ2
  skewer -q 20 -t 16 $FQZ1 $FQZ2
  FQT1=$(echo $FQZ1 | sed 's/fq.gz/fq-trimmed-pair1.fastq/')
  FQT2=$(echo $FQZ1 | sed 's/fq.gz/fq-trimmed-pair2.fastq/')
  BASE=$(echo $FQZ1 | sed 's/_1.fq.gz//')
  kallisto quant -o $BASE -i $IDX -t 16 $FQT1 $FQT2
done

for TSV in */*abundance.tsv ; do
  NAME=$(echo $TSV | cut -d '/' -f1)
  cut -f1,4 $TSV | sed 1d | sed "s/^/${NAME}\t/"
done | pigz > 3col.tsv
