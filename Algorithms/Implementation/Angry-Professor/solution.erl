-module(solution).
-export([main/0]).

test_case_reader(NumTests) ->
    receive
        {Sender, read_test} ->
            case NumTests of
                0 -> Sender ! finish;
                _ ->
                    Sender ! {test_case, read_test_case()},
                    test_case_reader(NumTests - 1)
            end
    end.

read_test_case() ->
    {ok, [N, K]} = io:fread("", "~d~d"),
    {ok, TimeList} = io:fread("", string:copies("~d", N)),
    {N, K, TimeList}.

run_test_cases(ReaderPid) ->
    ReaderPid ! {self(), read_test},
    receive
        finish -> ok;
        {test_case, TestCase} ->
            solve_test_case(TestCase),
            run_test_cases(ReaderPid)
    end.

solve_test_case({_N, K, TimeList}) ->
    case length([X || X <- TimeList, X =< 0]) of
        OnTime when OnTime >= K -> io:format("NO~n");
        _ -> io:format("YES~n")
    end.

main() ->
    {ok, [NumTests]} = io:fread("", "~d"),
    ReaderPid = spawn(fun() -> test_case_reader(NumTests) end),
    ok = run_test_cases(ReaderPid).
