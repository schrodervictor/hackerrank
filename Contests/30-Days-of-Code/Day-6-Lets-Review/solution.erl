-module(solution).
-export([main/0]).

-spec printStairway(integer()) -> ok.
printStairway(N) ->
    printStairway(N, 1).

-spec printStairway(integer(), integer()) -> ok.
printStairway(N, Step) when Step == N + 1 ->
    ok;
printStairway(N, Step) ->
    io:format("~s~s~n", [string:chars($\s, N - Step), string:chars($#, Step)]),
    printStairway(N, Step + 1).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    printStairway(N).
