#!/usr/bin/env bash

PROXY_PORT=${1:-4000}
shift
set -e

sudo docker run \
  --rm=true \
  -p ${PROXY_PORT}:4000/tcp \
  -e CANONICAL_HOST="localhost" \
  -e SECRET_KEY_BASE="secret_key" \
  -e LIVE_VIEW_SIGNING_SALT="live_view_salt" \
  -it aarongraham1/mates:latest \
  $@