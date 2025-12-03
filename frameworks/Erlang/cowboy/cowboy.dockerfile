FROM erlang:28.2

WORKDIR /app

# Building dependencies first lets Docker cache and reuse this layer.
COPY rebar.config rebar.lock ./
RUN rebar3 compile

COPY . .

RUN rebar3 as prod release

EXPOSE 8080

CMD ["/app/_build/prod/rel/hello_world/bin/hello_world", "foreground"]
