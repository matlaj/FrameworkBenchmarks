%% Feel free to use, reuse and abuse the code in this file.

-module(hello_world_handler_json).

-export([init/2]).

-include_lib("hello_world/include/hello_world_http.hrl").
% ------------------------------------------------------------------------------

% https://github.com/TechEmpower/FrameworkBenchmarks/wiki/Project-Information-Framework-Tests-Overview#json-serialization
-spec init(cowboy_req:req(), term()) -> {ok, cowboy_req:req(), term()}.
init(Req0, State) ->
    Body = json:encode(#{<<"message">> => <<"Hello, World!">>}),
    Headers = #{?HEADER_CONTENT_TYPE => ?MIME_TYPE_APPLICATION_JSON},
    Req1 = cowboy_req:reply(200, Headers, Body, Req0),
    {ok, Req1, State}.
