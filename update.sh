#!/bin/bash

YYYY=$(date -u +%Y)
YY=$(date -u +%y)
YYYP=$(date -u --date="1 day ago" +%Y)
YP=$(date -u --date="1 day ago" +%y)
DOY=$(date -u +%j)
DOYP=$(date -u --date="1 day ago" +%j)

lftp -d -u anonymous,admin@comma.ai -e 'set ftp:ssl-force true' -e "mirror --no-perms --no-umask --parallel=4 --file=/gnss/data/hourly/${YYYY}/${DOY}/hour${DOY}0.${YY}[gn].gz --target=./${YYYY}/${DOY}/; mirror --no-perms --no-umask --parallel=4 --file=/gnss/data/hourly/${YYYP}/${DOYP}/hour${DOYP}0.${YP}[gn].gz --target=./${YYYP}/${DOYP}/;exit" gdc.cddis.eosdis.nasa.gov

