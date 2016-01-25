#!/bin/bash

set -e
set -u

cat << EOT > code/compute_2ndlvl_glm.submit
# auto-generate file (generate_2nd_level_design.sh) -- do not modify!
universe = vanilla
output = condor_logs/\$(CLUSTER).\$(PROCESS).out
error = condor_logs/\$(CLUSTER).\$(PROCESS).err
log = condor_logs/\$(CLUSTER).\$(PROCESS).log
getenv = True
request_cpus = 1
request_memory = 2000
should_transfer_files = NO
transfer_executable = False
initialdir = /home/data/psyinf/forrest_gump/collection/visloc
executable = \$ENV(FSLDIR)/bin/feat

EOT

label="2nd_z164"

for sub in sub-*; do
  subid=$(echo "$sub" | cut -d '-' -f2-)
  sed -e "s/###SUB###/sub-${subid}/g" code/2ndlevel_design.fsf > "$sub/${label}.fsf"
  printf "arguments = $sub/${label}.fsf\nqueue\n" >> code/compute_2ndlvl_glm.submit
done
