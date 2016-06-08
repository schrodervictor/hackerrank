-module(solution).
-export([main/0]).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    {ok, Sticks} = io:fread("", string:copies("~d", N)),
    solve_test_case(Sticks).

solve_test_case([]) -> ok;
solve_test_case(Sticks) ->
    io:format("~B~n", [length(Sticks)]),
    Min = lists:min(Sticks),
    solve_test_case([X - Min || X <- Sticks, X > Min]).
