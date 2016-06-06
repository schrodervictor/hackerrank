-module(solution).
-export([main/0]).

main() ->
    % Throw away the first line, we don't need it for recursive a solution
    {ok, _} = io:fread("", "~d"),
    run_test_cases().

run_test_cases() ->
    case io:fread("", "~d") of
        {ok, [N]} ->
            {ok, H} = grow_utopian_tree(spring, 1, N),
            io:format("~B~n", [H]),
            run_test_cases();
        _ -> ok
    end.

grow_utopian_tree(_, H, 0) -> {ok, H};
grow_utopian_tree(spring, H, N) -> grow_utopian_tree(summer, H * 2, N - 1);
grow_utopian_tree(summer, H, N) -> grow_utopian_tree(spring, H + 1, N - 1).
