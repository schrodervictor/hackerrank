-module(solution).
-export([main/0]).

main() ->
    {ok, [N, K]} = io:fread("", "~d~d"),
    {ok, Numbers} = io:fread("", string:copies("~d", N)),
    Pairs = [
        {X, Y}
        ||
        Index <- lists:seq(1, N - 1),
        X <- [lists:nth(Index, Numbers)],
        Y <- lists:nthtail(Index, Numbers),
        (X + Y) rem K =:= 0
    ],
    io:format("~B~n", [length(Pairs)]).
