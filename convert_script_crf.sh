#! /bin/bash

#convert_script_crf.sh - webm bash FFMPEG converter. 2-pass CRF

#USEAGE - convert_script_crf.sh input_file [ crf [ format [ scale ] ] ]

FILENAME=${1%.*}
EXTENSION=${1##*.}
if [[ ! -f $1 ]]; then printf "File '$1' does not exist. QUITTING.\n"; exit -1; fi
if [[ $# -gt 1 ]]; then CRF=$2; else CRF='40'; fi
if [[ $# -gt 2 ]]; then FMT=$3; else FMT='webm'; fi
if [[ $# -gt 3 ]]; then SCALE=$4; else SCALE='896:504'; fi
OUTPUT=${FILENAME}_crf$CRF.$FMT
if [[ -f $OUTPUT  ]]; then echo "file exists"; exit -1; rm ${FILENAME}.${FMT}; fi
echo 'CRF:' $CRF; echo 'SCALE:' $SCALE; echo 'FILENAME:' $FILENAME.$EXTENSION; echo 'FMT:' $FMT
echo 'OUTPUT:' $OUTPUT; sleep 5; echo
ffmpeg -i ${FILENAME}.$EXTENSION -c:v libvpx-vp9 -b:v 0 -crf $CRF -pass 1 -an -f null /dev/null && \
ffmpeg -i ${FILENAME}.$EXTENSION -c:v libvpx-vp9 -b:v 0 -crf $CRF -pass 2 -an -vf scale=$SCALE ${FILENAME}_crf$CRF.${FMT}

