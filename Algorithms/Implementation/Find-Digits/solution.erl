-module(solution).
-export([main/0]).

main() ->
    % Throw away the first line, we don't need it for a recursive solution
    {ok, _} = io:fread("", "~d"),
    run_test_cases().

run_test_cases() ->
    case io:fread("", "~s") of
        {ok, [NumStr]} ->
            {ok, NumModZero} = find_digits_mod_zero(NumStr),
            io:format("~B~n", [NumModZero]),
            run_test_cases();
        _ -> ok
    end.

find_digits_mod_zero(NumStr) ->
    Num = list_to_integer(NumStr),
    Digits = [list_to_integer([X]) || X <- NumStr],
    find_digits_mod_zero(Num, Digits, 0).

find_digits_mod_zero(_, [], Acc) -> {ok, Acc};

%% The maximum number is 10e9, which means no huge integer and
%% pretty fast modulo operations. Let's use the simplest implementation,
%% it doesn't worth to optimize.
find_digits_mod_zero(N, [D|Digits], Acc) when N rem D =:= 0 ->
    find_digits_mod_zero(N, Digits, Acc + 1);

find_digits_mod_zero(N, [_|Digits], Acc) ->
    find_digits_mod_zero(N, Digits, Acc).
