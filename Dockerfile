# syntax = docker/dockerfile:experimental

FROM elixir:1.10.3-alpine as builder

# install build dependencies
RUN apk add --no-cache --update git build-base npm openssh-client

# setup ssh client to be able to access github
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# prepare build dir
WORKDIR /build

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN --mount=type=ssh mix deps.clean --all && mix deps.get
RUN mix deps.compile

# build assets
COPY assets assets
RUN cd assets && npm install

# build project
COPY priv priv
COPY lib lib
RUN mix compile
RUN cd assets && npm run deploy
RUN mix phx.digest

# build release
COPY rel rel
RUN mix release

# prepare release image
FROM alpine:3.11 AS app
RUN apk add --update openssl

WORKDIR /app
ENV HOME=/app
COPY --from=builder /build/_build/prod/rel/outline/ .
CMD ["/app/bin/outline", "start"]
