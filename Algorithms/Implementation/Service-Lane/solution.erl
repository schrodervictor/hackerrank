-module(solution).
-export([main/0]).

main() ->
    {ok, [N, _T]} = io:fread("", "~d~d"),
    {ok, Widths} = io:fread("", string:copies("~d", N)),
    solve_test_case(Widths).

solve_test_case(Widths) ->
    case io:fread("", "~d~d") of
        {ok, [I, J]} ->
            % Erlang lists start at 1, but the problem is zero based.
            % Adjustment of +1 needed.
            Answer = lists:min(lists:sublist(Widths, I + 1, J - I + 1)),
            io:format("~B~n", [Answer]),
            solve_test_case(Widths);
        _ -> ok
    end.
