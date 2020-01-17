FROM elixir:1.9.4-alpine as build

# install build dependencies
RUN set -xe \
    && apk add --no-cache --update \
        build-base \
        git \
        nodejs \
        npm \
        python

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only prod
RUN mix deps.compile

# build assets
COPY assets assets
RUN cd assets && npm ci && npm run deploy
RUN mix phx.digest

# build project
COPY priv priv
COPY lib lib
RUN mix compile

# build release
COPY rel rel
RUN mix release

# prepare release image
FROM alpine:latest AS app
RUN apk add --update bash openssl

RUN mkdir /app
WORKDIR /app

COPY --from=build /app/_build/prod/rel/mates ./
RUN chown -R nobody: /app
USER nobody

ENV HOME=/app
CMD ["bin/mates", "start"]