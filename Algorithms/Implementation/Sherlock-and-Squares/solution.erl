-module(solution).
-export([main/0]).

main() ->
    % Throw away the first line, we don't need it for a recursive solution
    {ok, _} = io:fread("", "~d"),
    run_test_cases().

run_test_cases() ->
    case io:fread("", "~d~d") of
        {ok, [A, B]} ->
            {ok, NumSquares} = find_squares_between(A, B),
            io:format("~B~n", [NumSquares]),
            run_test_cases();
        _ -> ok
    end.

find_squares_between(A, B) ->
    SqrtA = math:sqrt(A),
    SqrtB = math:sqrt(B),
    SquaresBetween = trunc(SqrtB) - trunc(SqrtA),
    case trunc(SqrtA) == SqrtA of
        true -> {ok, SquaresBetween + 1};
        false -> {ok, SquaresBetween}
    end.
