-module(solution).
-export([main/0]).

drawSierpinskiTriangle(Rows, 0) ->
    drawTriangle(Rows);
drawSierpinskiTriangle(Rows, N) ->
    divide5Fields(Rows, N).

divide5Fields(Rows, N) ->
    SemiBlank = lists:duplicate(Rows div 2, lists:flatten(lists:duplicate(Rows div 2, "_"))),
    Triangle = drawSierpinskiTriangle(Rows div 2, N-1),
    lists:zipwith(fun(X, Y) -> lists:flatten([Y, X, Y]) end,
            Triangle, SemiBlank)
    ++
    lists:map(fun(X) -> lists:flatten([X, "_", X]) end,
            Triangle).

drawTriangle(Rows) ->
    drawTriangle(Rows, 0, []).

drawTriangle(Rows, Rows, Accumulator) -> Accumulator;
drawTriangle(Rows, Step, Accumulator) ->
    Zeros = lists:duplicate(Step, "_"),
    Ones = lists:duplicate((Rows-Step)*2-1, "1"),
    drawTriangle(Rows, Step+1, [lists:flatten([Zeros, Ones, Zeros])|Accumulator]).

main() ->
    Rows = 32,
    {ok, [N]} = io:fread("", "~d"),
    [io:format("~s~n", [X]) || X <- drawSierpinskiTriangle(Rows, N)].

