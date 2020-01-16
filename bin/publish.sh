#!/usr/bin/env bash

set -e

test -d priv/static && rm -rf priv/static/* || true
mix clean && mix compile --force --warnings-as-errors || (mix clean && false)
mix test

sudo docker build \
  -t exfiddle/mates:latest \
  --output type=local,dest=docker-releases \
  .

# Need to publish to docker hub
