%% Feel free to use, reuse and abuse the code in this file.

-module(hello_world_handler_plaintext).

-export([init/2]).

-include_lib("hello_world/include/hello_world_http.hrl").
% ------------------------------------------------------------------------------

% https://github.com/TechEmpower/FrameworkBenchmarks/wiki/Project-Information-Framework-Tests-Overview#plaintext
-spec init(cowboy_req:req(), term()) -> {ok, cowboy_req:req(), term()}.
init(Req0, State) ->
    Body = <<"Hello, World!">>,
    Headers = #{?HEADER_CONTENT_TYPE => ?MIME_TYPE_TEXT_PLAIN},
    Req1 = cowboy_req:reply(200, Headers, Body, Req0),
    {ok, Req1, State}.
