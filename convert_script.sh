#! /bin/bash

FILENAME=$1

ffmpeg -i $FILENAME.mp4 -c:v libvpx-vp9 -b:v 1.5M -pass 1 -an -f null /dev/null && \
ffmpeg -i $FILENAME.mp4 -c:v libvpx-vp9 -b:v 1.5M -pass 2 -an -vf scale=896:504 $FILENAME.webm