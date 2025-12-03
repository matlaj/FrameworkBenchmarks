%% Feel free to use, reuse and abuse the code in this file.
-module(hello_world_http).

-export([start_listener/0]).

-include_lib("hello_world/include/hello_world.hrl").
% ------------------------------------------------------------------------------

-spec start_listener() -> ok.
start_listener() ->
    Routes = [
        {'_', [
            {"/plaintext", hello_world_handler_plaintext, []},
            {"/json", hello_world_handler_json, []},
            {"/db", hello_world_handler_db, []},
            {"/query", hello_world_handler_query, []}
        ]}
    ],
    Env = #{env => #{dispatch => cowboy_router:compile(Routes)}},
    {ok, ListenPort} = application:get_env(?APP_NAME, listen_port),
    {ok, _} = cowboy:start_clear(hello_world_listener, [{port, ListenPort}], Env),
    ok.
