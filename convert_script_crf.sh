#! /bin/bash
#convert_script_crf.sh - webm bash FFMPEG converter. 2-pass CRF.

[[ $# -lt 1 ]] || [[ $1 = "-h" ]] && printf 'USAGE: convert_script_crf.sh input_file [ crf [ format [ scale [ brightness [ saturation ] ] ] ] ]\n' && exit 1

[[ -d OUTPUT ]] || mkdir OUTPUT
[[ -f $1 ]] || { printf "File '$1' does not exist. QUITTING.\n"; exit -1; }
[[ $# -gt 1 ]] && CRF=$2 || CRF='40'
[[ $# -gt 2 ]] && FMT=$3 || FMT='webm'
[[ $# -gt 3 ]] && SCL=$4 || SCL='896:504'
[[ $# -gt 4 ]] && BRT=$5 || BRT='0.07'
[[ $# -gt 5 ]] && SAT=$4 || SAT='1'
[[ -f $OUTPUT  ]] && echo "file exists" && sleep 5 && rm $OUTPUT
FILENAME=$(basename ${1%.*}) OUT=${FILENAME}_crf$CRF.$FMT
echo -e CRF: $CRF \\nSCALE: $SCL \\nFILENAME: $FILENAME.${1##*.} \\nFMT: $FMT \\nBRT: $BRT \\nSAT: $SAT \\nOUTFILE: OUTPUT/$OUT
sleep 5
ffmpeg -i $1 -c:v libvpx-vp9 -b:v 0 -crf $CRF -pass 1 -an -f null /dev/null && \
ffmpeg -i $1 -c:v libvpx-vp9 -b:v 0 -crf $CRF -pass 2 -an -vf scale=$SCL,eq=brightness=$BRT:saturation=$SAT OUTPUT/$OUT
echo "DONE(OUTPUT/$OUT)"

