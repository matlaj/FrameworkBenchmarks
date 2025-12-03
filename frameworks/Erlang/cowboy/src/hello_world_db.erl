%% Feel free to use, reuse and abuse the code in this file.

-module(hello_world_db).

-export([
    start_pool/0,
    start_member/0,
    prepared_query/2
]).

-include_lib("hello_world/include/hello_world.hrl").
-include_lib("hello_world/include/hello_world_db.hrl").
% ------------------------------------------------------------------------------

-spec start_pool() -> ok.
start_pool() ->
    {ok, InitCount} = application:get_env(?APP_NAME, db_pool_init_count),
    {ok, MaxCount} = application:get_env(?APP_NAME, db_pool_max_count),
    PoolConfig = #{
        name => ?postgres_pool,
        init_count => InitCount,
        max_count => MaxCount,
        start_mfa => {hello_world_db, start_member, []}
    },
    {ok, _} = pooler:new_pool(PoolConfig),
    ok.

-spec start_member() -> {ok, pid()}.
start_member() ->
    {ok, Opts} = application:get_env(?APP_NAME, db_conn_opts),
    {ok, C} = epgsql:connect(Opts),
    ok = store_prepared_statements(C),
    {ok, C}.

-spec prepared_query(string(), [term()]) -> {ok, [tuple()]}.
prepared_query(Query, Params) ->
    C = take_member(),
    {ok, _, Rows} = epgsql:prepared_query(C, Query, Params),
    ok = return_member(C),
    {ok, Rows}.

-spec store_prepared_statements(epgsql:connection()) -> ok.
store_prepared_statements(C) ->
    Statements = [
        {?world_stmt, "SELECT * FROM World WHERE id = $1", []}
    ],
    lists:foreach(
        fun({Name, Sql, Types}) ->
            {ok, _} = epgsql:parse(C, Name, Sql, Types)
        end,
        Statements
    ).

-spec take_member() -> pid().
take_member() ->
    case pooler:take_member(?postgres_pool) of
        error_no_members ->
            timer:sleep(5),
            take_member();
        P ->
            P
    end.

-spec return_member(pid()) -> ok.
return_member(P) ->
    pooler:return_member(?postgres_pool, P).
