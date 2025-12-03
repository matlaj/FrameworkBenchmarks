%% Feel free to use, reuse and abuse the code in this file.

-module(hello_world_handler_db).

-export([init/2]).

-include_lib("hello_world/include/hello_world_http.hrl").
% ------------------------------------------------------------------------------

% https://github.com/TechEmpower/FrameworkBenchmarks/wiki/Project-Information-Framework-Tests-Overview#single-database-query
-spec init(cowboy_req:req(), term()) -> {ok, cowboy_req:req(), term()}.
init(Req0, State) ->
    {ok, World} = hello_world_model_world:get_by_id(rand:uniform(10_000)),
    Body = json:encode(World),
    Headers = #{?HEADER_CONTENT_TYPE => ?MIME_TYPE_APPLICATION_JSON},
    Req1 = cowboy_req:reply(200, Headers, Body, Req0),
    {ok, Req1, State}.
