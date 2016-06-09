-module(solution).
-export([main/0]).

-ifdef(TEST).
    -define(LOG(Msg, Var), io:format("~s: ~p~n", [Msg, Var])).
-else.
    -define(LOG(Msg, Var), ok).
-endif.

main() ->
    {ok, [NumTests]} = io:fread("", "~d"),
    ReaderPid = spawn(fun() -> test_case_reader(NumTests) end),
    ok = run_test_cases(ReaderPid).

run_test_cases(ReaderPid) ->
    ReaderPid ! {self(), read_test},
    receive
        finish -> ok;
        {test_case, TestCase} ->
            ?LOG("TestCase", TestCase),
            {ok, FoundMatch} = solve_test_case(TestCase),
            ?LOG("FoundMatch", TestCase),
            io:format("~s~n", [FoundMatch]),
            run_test_cases(ReaderPid)
    end.

solve_test_case({
    {grid, {Grid, ColsGrid}},
    {pattern, {Pattern, ColsPattern}}
}) -> solve_test_case(Grid, ColsGrid, Pattern, ColsPattern, 1).

solve_test_case([], _, _, _, _) -> {ok, "NO"};
solve_test_case([_|GridRest], ColsG, Pattern, ColsP, LineSearchOffset)
    when LineSearchOffset > ColsG ->
        ?LOG("LineSearchOffset > ColsG", [LineSearchOffset, ColsG]),
        solve_test_case(GridRest, ColsG, Pattern, ColsP, 1);

solve_test_case(
    Grid = [GridLine|GridRest],
    ColsG,
    Pattern = [PatternLine|PatternRest],
    ColsP,
    LineSearchOffset
) ->
    %?LOG("ColsG, ColsP", [ColsG, ColsP]),
    GridComp = string:substr(GridLine, LineSearchOffset),
    ?LOG("GridComp 1", [GridComp]),
    ?LOG("PatternLine", [PatternLine]),
    ?LOG("string:str", [string:str(GridComp, PatternLine)]),
    case string:str(GridComp, PatternLine) of
        0 -> solve_test_case(GridRest, ColsG, Pattern, ColsP, 1);
        N ->
            %?LOG("LineSearchOffset + N - 1", [LineSearchOffset + N - 1]),
            case check_match(GridRest, PatternRest, ColsP, LineSearchOffset + N - 1) of
                match -> {ok, "YES"};
                no_match ->
                    solve_test_case(
                        Grid, ColsG, Pattern, ColsP,
                        LineSearchOffset + 1
                    )
            end
    end.

check_match(_, [], _, _) -> match;
check_match([], _, _, _) -> no_match;
check_match(
    [GridLine|GridRest],
    [PatternLine|PatternRest],
    ColsPattern,
    ExpectedBegin
) ->
    GridComp = string:substr(GridLine, ExpectedBegin, ColsPattern),
    ?LOG("GridComp 2", [GridComp]),
    ?LOG("PatternLine", [PatternLine]),
    ?LOG("string:equal", [string:equal(GridComp, PatternLine)]),
    case string:equal(GridComp, PatternLine) of
        true ->
            check_match(GridRest, PatternRest, ColsPattern, ExpectedBegin);
        false -> no_match
    end.

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
    {ok, [RowsGrid, ColsGrid]} = io:fread("", "~d~d"),
    {ok, GridLines} = io:fread("", string:copies("~s", RowsGrid)),
    {ok, [RowsPattern, ColsPattern]} = io:fread("", "~d~d"),
    {ok, PatternLines} = io:fread("", string:copies("~s", RowsPattern)),
    {
        {grid, {GridLines, ColsGrid}},
        {pattern, {PatternLines, ColsPattern}}
    }.
