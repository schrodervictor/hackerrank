-module(solution_recursive).
-export([main/0]).

main() ->
    {ok, [N, K]} = io:fread("", "~d~d"),
    {ok, Numbers} = io:fread("", string:copies("~d", N)),
    io:format("~B~n", [count_divisible_pairs(K, Numbers)]).

count_divisible_pairs(_, []) -> 0;
count_divisible_pairs(K, [Head|Tail]) ->
    count_divisible_pairs(K, 0, Head, Tail) + count_divisible_pairs(K, Tail).

count_divisible_pairs(_, Total, _, []) -> Total;
count_divisible_pairs(K, Total, N1, [N2|Numbers])
    when (N1+N2) rem K =:= 0 ->
        count_divisible_pairs(K, Total+1, N2, Numbers);
count_divisible_pairs(K, Total, _, [N2|Numbers]) ->
    count_divisible_pairs(K, Total, N2, Numbers).
