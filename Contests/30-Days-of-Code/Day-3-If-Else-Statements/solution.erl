-module(solution).
-export([main/0]).

-spec getWeirdness(integer()) -> string().
getWeirdness(N) when N rem 2 == 1 -> "Weird";
getWeirdness(N) when N >= 6 andalso N =< 20 -> "Weird";
getWeirdness(_) -> "Not Weird".

main() ->
    {ok, [N]} = io:fread("", "~d"),
    Weirdness = getWeirdness(N),
    io:format("~s~n", [Weirdness]).
