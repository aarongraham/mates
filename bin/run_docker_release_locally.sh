#!/usr/bin/env bash

# bin/dev/run_docker_release_locally.sh [port] [script to run]
#
# When run without args, will start an IEX session, with phoenix bound on port 4000.
# Alternatively, it can be started with an arbitrary command:
#
#  bin/dev/run_docker_release_locally.sh 4000 /opt/sparta/glacier_point/bin/migrations
#  bin/dev/run_docker_release_locally.sh 4000 /bin/bash

PROXY_PORT=${1:-4000}
shift
set -e

docker run \
  --rm=false \
  -p ${PROXY_PORT}:4000/tcp \
  -e CANONICAL_HOST=localhost \
  -e PORT=4000 \
  -e SECRET_KEY_BASE="nmQypxC1C3azNoMYF4R2OJPuRHJlvaXwDg9Kv7jxIrWyAKO780lPQPhKACVw2R0S" \
  -it exfiddle/mates:latest \
  $@