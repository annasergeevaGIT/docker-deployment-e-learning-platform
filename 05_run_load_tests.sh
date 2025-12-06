#!/bin/bash
export MSYS2_ARG_CONV_EXCL="*"   # ← REQUIRED for Git Bash (prevents path rewriting)

TS=$(date +"%Y%m%d-%H%M%S")

run_test() {
  NAME=$1
  FILE=$2

  echo "Running $NAME..."

  docker exec k6 k6 run \
    --out json=/results/${NAME}-${TS}.json \
    /scripts/${FILE}.js \
    | tee load-tests/results/${NAME}-${TS}.log
}
# via gateway
run_test "enrollment"           "create-enrollment"
#run_test "stress"               "high-throughput-stress"
#run_test "spike"                "spike-test"
#run_test "mixed"                "mixed-workload"
#run_test "soak"                 "soak-test"

#docker exec -it k6 k6 run /scripts/create-enrollment.js
#docker exec -it k6 k6 run /scripts/high-throughput-stress.js
#docker exec -it k6 k6 run /scripts/spike-test.js
#docker exec -it k6 k6 run /scripts/mixed-workload.js
#docker exec -it k6 k6 run /scripts/soak-test.js