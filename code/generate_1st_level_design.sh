#!/bin/bash

set -e
set -u

cat << EOT > code/compute_1stlvl_glm.submit
# auto-generate file (generate_1st_level_design.sh) -- do not modify!
universe = vanilla
output = condor_logs/\$(CLUSTER).\$(PROCESS).out
error = condor_logs/\$(CLUSTER).\$(PROCESS).err
log = condor_logs/\$(CLUSTER).\$(PROCESS).log
getenv = True
request_cpus = 1
request_memory = 4000
should_transfer_files = NO
transfer_executable = False
initialdir = /home/data/psyinf/forrest_gump/collection/visloc
executable = \$ENV(FSLDIR)/bin/feat

EOT

for sub in sub-*; do
  subid=$(echo "$sub" | cut -d '-' -f2-)
  for run in $sub/onsets/run*; do
    runid=$(echo "$(basename $run)" | cut -d '-' -f2-)
    sed -e "s/###SUB###/sub-${subid}/g" -e "s/###RUN###/run-${runid}/g" code/1stlevel_design.fsf > "$sub/run-${runid}_1st.fsf"
    printf "arguments = $sub/run-${runid}_1st.fsf\nqueue\n" >> code/compute_1stlvl_glm.submit
  done
done
