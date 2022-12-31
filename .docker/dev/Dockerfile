FROM elixir:latest

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY . .

RUN apt-get update && \
    apt-get install -y inotify-tools && \
    mix local.hex --force && \
    mix archive.install hex phx_new 1.6.15 --force && \
    mix local.rebar --force

RUN mix deps.get && mix deps.compile

CMD ["/app/entrypoint.sh"]