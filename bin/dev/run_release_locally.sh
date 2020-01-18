#!/usr/bin/env bash

CANONICAL_HOST="localhost" \
SECRET_KEY_BASE="secret_key" \
LIVE_VIEW_SIGNING_SALT="live_view_salt" \
_build/prod/rel/mates/bin/mates start