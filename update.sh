#!/bin/bash

YYYY=$(date -u +%Y)
YY=$(date -u +%y)
YYYP=$(date -u --date="1 day ago" +%Y)
YP=$(date -u --date="1 day ago" +%y)
DOY=$(date -u +%j)
DOYP=$(date -u --date="1 day ago" +%j)

RDOY="[0-9][0-9][0-9]"
RYY="[0-9][0-9]"


lftp -u anonymous,admin@comma.ai -e "set ftp:ssl-force true" -e "mirror --no-empty-dirs --no-perms --no-umask --parallel=4 --directory=/gnss/data/hourly/${YYYY}/${DOY}/ --directory=/gnss/data/hourly/${YYYP}/${DOYP}/ --include-glob=hour${RDOY}0.${RYY}[ng].gz --target-directory=./;exit" gdc.cddis.eosdis.nasa.gov


# check year folders exist
if [ ! -d ${YYYY} ]; then
  mkdir ${YYYY}
fi

if [ ! -d ${YYYP} ]; then
  mkdir ${YYYP}
fi

# move into correct folders
if [ ${YYYP} -ne ${YYYY} ]; then
  cp -r ${DOYP} ${YYYP}/
  cp -r ${DOY} ${YYYY}/
else
  cp -r ${DOYP} ${YYYY}/
  cp -r ${DOY} ${YYYY}/
fi

rm -rf ${DOYP}
rm -rf ${DOY}
