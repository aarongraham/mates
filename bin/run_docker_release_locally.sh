#!/usr/bin/env bash

shift
set -e

sudo docker run \
  --rm=false \
  -p 4000:4000/tcp \
  -p 4001:4001/tcp \
  -e CANONICAL_HOST=localhost \
  -e PORT=4000 \
  -e SECRET_KEY_BASE="nmQypxC1C3azNoMYF4R2OJPuRHJlvaXwDg9Kv7jxIrWyAKO780lPQPhKACVw2R0S" \
  -it aarongraham1/mates:latest \
  $@