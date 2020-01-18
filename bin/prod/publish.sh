#!/usr/bin/env bash

set -e

test -d priv/static && rm -rf priv/static/* || true
mix clean && mix compile --force --warnings-as-errors || (mix clean && false)
mix test

sudo docker build \
  -t aarongraham1/mates:latest \
  .

sudo docker push aarongraham1/mates:latest
