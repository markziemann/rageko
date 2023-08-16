#!/bin/bash
set -x

IDX=hairpin_mmu_2022-08-19.fa.idx

echo ">NEBNext Multiplex Small RNA
AGATCGGAAGAGCACACGTCT
>BGI small RNA
TCGTATGCCGTCTTCTGCTTG" > adapters.fa

for FQZ1 in *.fq.gz ; do
  echo $FQZ1
  skewer -l 16 -x adapters.fa -q 20 $FQZ1
  FQT1=$(echo $FQZ1 | sed 's/fq.gz/fq-trimmed.fastq/')
  BASE=$(echo $FQZ1 | sed 's/.fq.gz//')
  kallisto quant -o $BASE -i $IDX -t 16 $FQT1 --single -l 20 -s 2
done

for TSV in */*abundance.tsv ; do
  NAME=$(echo $TSV | cut -d '/' -f1)
  cut -f1,4 $TSV | sed 1d | sed "s/^/${NAME}\t/"
done | pigz > 3col.tsv.gz
