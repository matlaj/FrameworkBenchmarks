%% Feel free to use, reuse and abuse the code in this file.

-module(hello_world_handler_query).

-export([init/2]).

-include_lib("hello_world/include/hello_world_http.hrl").
% ------------------------------------------------------------------------------

% https://github.com/TechEmpower/FrameworkBenchmarks/wiki/Project-Information-Framework-Tests-Overview#multiple-database-queries
-spec init(cowboy_req:req(), term()) -> {ok, cowboy_req:req(), term()}.
init(Req0, State) ->
    NumWorlds = parse_query(Req0),
    Worlds = get_worlds(NumWorlds),
    Headers = #{?HEADER_CONTENT_TYPE => ?MIME_TYPE_APPLICATION_JSON},
    Req1 = cowboy_req:reply(200, Headers, json:encode(Worlds), Req0),
    {ok, Req1, State}.

-spec parse_query(cowboy_req:req()) -> integer().
parse_query(Req) ->
    #{queries := BinNumWorlds} = cowboy_req:match_qs([{queries, [], <<"1">>}], Req),
    try binary_to_integer(BinNumWorlds) of
        NumWorlds when NumWorlds > 500 -> 500;
        NumWorlds when NumWorlds < 1 -> 1;
        NumWorlds -> NumWorlds
    catch
        error:badarg ->
            1
    end.

-spec get_worlds(integer()) -> [hello_world_model_world:t()].
get_worlds(NumWorlds) ->
    lists:map(
        fun(_) ->
            {ok, World} = hello_world_model_world:get_by_id(rand:uniform(10_000)),
            World
        end,
        lists:seq(1, NumWorlds)
    ).
