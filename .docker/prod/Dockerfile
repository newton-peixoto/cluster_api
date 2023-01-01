FROM elixir:latest
# Set exposed ports
WORKDIR /app
ADD . /app

EXPOSE 4000
ENV PORT 4000 
ENV MIX_ENV prod

RUN mix local.hex --force && \
	mix local.rebar --force && \
    mix do deps.get, deps.compile 

RUN mix deps.get && mix deps.compile

CMD ["mix", "phx.server"]