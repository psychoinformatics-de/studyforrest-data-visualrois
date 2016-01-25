#!/bin/bash
# Take all localizer 1st-level GLM analysis results, computes and average zstat map
# for both contrasts of interest, masks them with the given mask image, and thresholds to
# identify the voxels matching the desired percentile of largest values
#
# Usage:
#   code/localizerstats2mask.sh sub-4 VT_roi 90

set -e
set -u

sub=$1
mask=$2
percentile=$3
dsdir="$(readlink -f .)"

wdir=$(mktemp -d --suffix=localizer2mask)
trap "rm -rf $wdir" SIGINT SIGTERM
cd "$wdir"

# define contrast names
contrasts=(dummy all ffa ppa eba loc vis ffa_alt ppa_alt eba_alt loc_alt)

##combine MNI2T1 and T12BOLD
#$FSLDIR/bin/convert_xfm \
#  -omat mni2bold.mat \
#  -concat ${dsdir}/src/tnt/${sub}/t1w/in_bold/xfm_6dof.mat \
#  ${dsdir}/src/tnt/${sub}/t1w/in_mni152/tmpl2subj.mat

## re-slice mask
#$FSLDIR/bin/flirt \
#  -in "${dsdir}/${mask}" \
#  -ref ${dsdir}/src/tnt/${sub}/bold/brain \
#  -applyxfm -init mni2bold.mat \
#  -out mask \
#  -interp nearestneighbour

## apply transformation to subject template for all runs
#for f in ${dsdir}/${sub}/run-*.feat; do
#  $FSLDIR/bin/featregapply "$f"
#  # make zstats
#  $FSLDIR/bin/fslmaths $f/reg_standard/stats/varcope1 -sqrt $f/reg_standard/stats/stdcope1
#  $FSLDIR/bin/fslmaths $f/reg_standard/stats/varcope2 -sqrt $f/reg_standard/stats/stdcope2
#  $FSLDIR/bin/fslmaths $f/reg_standard/stats/cope1 -div $f/reg_standard/stats/stdcope1 $f/reg_standard/stats/zstat1
#  $FSLDIR/bin/fslmaths $f/reg_standard/stats/cope2 -div $f/reg_standard/stats/stdcope2 $f/reg_standard/stats/zstat2
#done

# make average zstat across all runs -- mask
for i in $(seq 10); do
  $FSLDIR/bin/fslmerge -t zstat${i}_merged ${dsdir}/${sub}/run-*.feat/stats/zstat${i}.nii*
  #$FSLDIR/bin/fslmaths zstat${i}_merged -Tmean -mas mask zstat${i}
  $FSLDIR/bin/fslmaths zstat${i}_merged -Tmean zstat${i}
  # take desired upper percentile and threshold for mask
  fslmaths zstat${i} \
    -thr $($FSLDIR/bin/fslstats zstat${i} -P "$percentile") \
    ${dsdir}/${sub}/${contrasts[$i]}_thr${percentile}
done

cd -
rm -rf "$wdir"

