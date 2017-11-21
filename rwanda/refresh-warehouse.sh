#!/usr/bin/env bash

echo "Re-creating OMRS Schema"
/home/petl/bin/execute-job.sh jobs/create-omrs-schema.kjb BASIC

echo "Re-creating RW Schema"
/home/petl/bin/execute-job.sh rwanda/jobs/create-rw-schema.kjb BASIC

echo "Refreshing Warehouse"
/home/petl/bin/execute-job.sh rwanda/jobs/refresh-warehouse.kjb BASIC

echo "Moving Log"
NOW=$(date +"%Y%m%d_%H%M%S")
mv /home/petl/logs/petl.log /home/petl/logs/petl_$NOW.log