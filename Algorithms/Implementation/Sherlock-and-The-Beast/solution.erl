-module(solution).
-export([main/0]).

main() ->
    % Throw away the first line, we don't need it
    {ok, _} = io:fread("", "~d"),
    recursive_solution().

recursive_solution() ->
    case io:fread("", "~d") of
        {ok, [N]} ->
            solve_case(N),
            recursive_solution();
        _ -> ok
    end.

solve_case(N) ->
    case find_decent_number(N) of
        not_found -> io:format("-1~n");
        DecentNum -> io:format("~s~n", [DecentNum])
    end.

%% If it has less then 3 digits, there's nothing we can do
find_decent_number(N) when N < 3 -> not_found;

%% If N % 3 == 2, it means that we have to complete it with 3's.
%% The minimum we can use is five 3's. So N - 5 should be divisible by 3.
find_decent_number(N)
    when N rem 3 == 2, N - 5 < 0 orelse (N - 5) rem 3 /= 0 -> not_found;

%% If N % 3 == 1, it means that we have to complete it with 3's.
%% The minimum we can use is ten 3's. So N - 10 should be divisible by 3.
find_decent_number(N)
    when N rem 3 == 1, N - 10 < 0 orelse (N - 10) rem 3 /= 0 -> not_found;

%% If it passed all previous tests, we can safely build the Decent Number.
find_decent_number(N) ->
    case N rem 3 of
        0 -> string:chars($5, N);
        1 -> string:chars($5, N - 10) ++ string:chars($3, 10);
        2 -> string:chars($5, N - 5) ++ string:chars($3, 5)
    end.
