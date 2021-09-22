#!/bin/bash
set -x
OUTDIR="../covid-rt-estimates"

## Manual update 
COUNTRY=${1:-Vietnam}
DATA_SOURCE="https://epinowcovidrstorage.blob.core.windows.net/results"
azcopy sync $DATA_SOURCE/national/cases/summary ${OUTDIR}/national/cases/summary
azcopy sync $DATA_SOURCE/national/deaths/summary ${OUTDIR}/national/deaths/summary
azcopy sync $DATA_SOURCE/national/deaths/national/$COUNTRY ${OUTDIR}/national/deaths/national/$COUNTRY/
azcopy sync $DATA_SOURCE/national/cases/national/$COUNTRY ${OUTDIR}/national/cases/national/$COUNTRY/

