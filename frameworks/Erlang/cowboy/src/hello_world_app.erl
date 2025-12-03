%% Feel free to use, reuse and abuse the code in this file.

-module(hello_world_app).
-behaviour(application).

%% application behaviour callbacks
-export([
    start/2,
    stop/1
]).
% ------------------------------------------------------------------------------

-spec start(application:start_type(), term()) -> {ok, pid()}.
start(_StartType, _StartArgs) ->
    ok = hello_world_db:start_pool(),
    ok = hello_world_http:start_listener(),
    {ok, Pid} = hello_world_sup:start_link(),
    logger:notice("Hello World server started"),
    {ok, Pid}.

-spec stop(term()) -> ok.
stop(_State) ->
    ok.
