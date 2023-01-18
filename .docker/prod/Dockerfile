FROM elixir:latest
# Set exposed ports
WORKDIR /app
ADD . /app

EXPOSE 4000
ENV PORT 4000 
ENV MIX_ENV prod
ENV REPLACE_OS_VARS true
ENV PHX_SERVER true
ENV SECRET_KEY_BASE REALLY_LONG_SECRET

RUN mix local.hex --force && \
	mix local.rebar --force && \
    mix do deps.get, deps.compile 

RUN mix deps.get && mix deps.compile

RUN mix release

CMD ["_build/prod/rel/cluster_api/bin/cluster_api", "start"]