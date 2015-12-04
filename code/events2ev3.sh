#!/bin/bash
#
# Convert BIDS events.tsv to FSL's EV3 files

set -e
set -u

# little helper
printf "1.0\n1.0\n" > ones.txt

for s in src/phase2/sub-*; do
  subj=$(basename $s)
  echo $subj
  for r in $(seq 4); do
    echo $r
    mkdir -p $subj/onsets/run-$r
    for c in face scene body house object scramble; do
      grep $c \
        src/phase2/$subj/ses-localizer/func/$subj*object*_run-${r}_events.tsv \
        | cut -f 1,2 \
        | paste - ones.txt \
        > $subj/onsets/run-$r/$c.txt
    done
  done
done
