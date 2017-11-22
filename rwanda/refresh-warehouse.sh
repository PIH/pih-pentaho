#!/usr/bin/env bash

echo "Re-creating OMRS Schema"
/home/petl/bin/execute-job.sh jobs/create-omrs-schema.kjb MINIMAL

echo "Re-creating RW Schema"
/home/petl/bin/execute-job.sh rwanda/jobs/create-rw-schema.kjb MINIMAL "Rwink"

echo "Refreshing Warehouse from Butaro"
/home/petl/bin/execute-job.sh rwanda/jobs/refresh-warehouse.kjb MINIMAL "Butaro"

echo "Refreshing Warehouse from Rwink"
/home/petl/bin/execute-job.sh rwanda/jobs/refresh-warehouse.kjb MINIMAL "Rwink"

NOW=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="petl_$NOW.log"
echo "Moving Log TO $LOG_FILE"
mv /home/petl/logs/petl.log /home/petl/logs/$LOG_FILE
