#!/usr/bin/env bash

mix clean
mix deps.get --only prod
MIX_ENV=prod mix compile

npm run deploy --prefix ./assets
mix phx.digest

MIX_ENV=prod mix release --overwrite