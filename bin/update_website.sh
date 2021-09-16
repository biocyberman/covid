#!/usr/bin/env bash
## Symlink estimates into this repository
ln -snf ../covid-rt-estimates covid-rt-estimates
OUTDIR="../covid-rt-estimates"

## Manual update 
COUNTRY=${1:Vietnam}
DATA_SOURCE="https://epinowcovidrstorage.blob.core.windows.net/results/"
azcopy sync $DATA_SOURCE/national/cases/summary ${OUTDIR}/national/cases/summary
azcopy sync $DATA_SOURCE/national/deaths/summary ${OUTDIR}/national/deaths/summary
azcopy sync $DATA_SOURCE/national/deaths/national/$COUNTRY ${OUTDIR}/national/deaths/national/$COUNTRY/
azcopy sync $DATA_SOURCE/national/cases/national/$COUNTRY ${OUTDIR}/national/cases/national/$COUNTRY/

## Get latest estimates
# Rscript utils/update_estimates.R

## Update subnational estimate for Vietnam
cd ./covid-rt-estimates && bash bin/update-estimates.sh

## Update national reports
Rscript utils/update_report_templates.R

## Manually force a UK page update
# Rscript -e 'rmarkdown::render("_posts/national/united-kingdom/united-kingdom.Rmd")'

## Update all Rscript
Rscript utils/update_posts.R

## Clean up after page update
Rscript utils/clean_page_update.R

## Copy paper figures into root directory
cp -r _paper/figures figures/

## Update the website
mv README.md _README.md
Rscript -e "rmarkdown::render_site()"
mv _README.md README.md
## Clean up nowcast folders
Rscript utils/clean_built_site.R

## Remove paper figures from root
rm -r -f figures
