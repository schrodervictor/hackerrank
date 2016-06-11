-module(solution).
-export([main/0]).

main() ->
    %% Throw away the first number. We don't need it
    %% for a recursive solution.
    {ok, _} = io:fread("", "~d"),
    run_test_cases().

run_test_cases() ->
    case io:fread("", "~d~d~d") of
        {ok, [N, C, M]} ->
            io:format("~B~n", [count_chocolats(N, C, M)]),
            run_test_cases();
        _ -> ok
    end.

count_chocolats(Money, Cost, NumWrapPromo) ->
    Wrappers = Chocolats = trunc(Money / Cost),
    change_wrappers(Chocolats, Wrappers, NumWrapPromo).

change_wrappers(Chocolats, Wrappers, NumWrapPromo)
  when Wrappers < NumWrapPromo -> Chocolats;

change_wrappers(Chocolats, Wrappers, NumWrapPromo) ->
    MoreChocolats = trunc(Wrappers / NumWrapPromo),
    RemainingWrappers = Wrappers rem NumWrapPromo,
    change_wrappers(
        Chocolats + MoreChocolats,
        RemainingWrappers + MoreChocolats,
        NumWrapPromo
    ).
