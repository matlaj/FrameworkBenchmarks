%% Feel free to use, reuse and abuse the code in this file.
-module(hello_world_model_world).

-export([
    get_by_id/1
]).

-type t() :: #{id := integer(), randomNumber := integer()}.
-export_type([t/0]).

-include_lib("hello_world/include/hello_world_db.hrl").
% ------------------------------------------------------------------------------

-spec get_by_id(integer()) -> {ok, t()}.
get_by_id(Id) ->
    {ok, [{Id, RandomNumber}]} = hello_world_db:prepared_query(?world_stmt, [Id]),
    World = #{id => Id, randomNumber => RandomNumber},
    {ok, World}.
