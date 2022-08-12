#!/bin/bash
zcat Rattus_norvegicus.mRatBN7.2.107.gtf.gz \
| grep -w transcript \
| cut -d '"' -f2,6 \
| tr '"' '\t' \
| gzip > Rattus_norvegicus.mRatBN7.2.107.gtf.gene2transcript.tsv.gz

zcat Rattus_norvegicus.mRatBN7.2.107.gtf.gz \
| grep -w gene \
| cut -d '"' -f2,6  \
| tr '"' '\t' \
| sed 's/ensembl/none/' \
| gzip > Rattus_norvegicus.mRatBN7.2.107.gtf.genenames.tsv.gz
