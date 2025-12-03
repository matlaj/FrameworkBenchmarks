%% Feel free to use, reuse and abuse the code in this file.

-module(hello_world_sup).
-behaviour(supervisor).

%% API.
-export([start_link/0]).

%% supervisor behaviour callbacks.
-export([init/1]).
% ------------------------------------------------------------------------------

-spec start_link() -> supervisor:startlink_ret().
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

-spec init([]) -> {ok, {supervisor:sup_flags(), [supervisor:child_spec()]}}.
init([]) ->
    SupFlags = #{},
    ChildSpecs = [],
    {ok, {SupFlags, ChildSpecs}}.
