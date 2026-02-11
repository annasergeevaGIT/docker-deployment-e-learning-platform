#!/bin/bash
export MSYS2_ARG_CONV_EXCL="*"   # ← REQUIRED for Git Bash (prevents path rewriting)

TS=$(date +"%Y%m%d-%H%M%S")

run_test() {
  NAME=$1
  FILE=$2

  echo "Running $NAME..."

docker exec k6 k6 run \
  -e BASE_URL=http://gateway-service:9099 \
  -e TOKEN_URL=http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token \
  --out json=/results/${NAME}-${TS}.json \
  /scripts/${FILE}.js
}
# via gateway
#run_test "baseline"            "baseline-test"
run_test "stress"               "stress-test"
#run_test "spike"               "spike-test"

#docker exec -it k6 k6 run /scripts/baseline-test.js
#docker exec -it k6 k6 run /scripts/stress-test.js
#docker exec -it k6 k6 run /scripts/spike-test.js