-module(solution).
-export([main/0]).

-record(test_case, {grid, colsG, pattern, colsP}).

main() ->
    {ok, [NumTests]} = io:fread("", "~d"),

    %% Spawns the test_case_reader that holds the logic about
    %% reading each individual test case with it's several
    %% pieces of data.
    ReaderPid = spawn(fun() -> test_case_reader(NumTests) end),

    %% Triggers the recursive solution.
    ok = run_test_cases(ReaderPid).

%% Main loop
run_test_cases(ReaderPid) ->
    ReaderPid ! {self(), read_test},
    receive
        %% No more test cases, finish the recursion.
        finish -> ok;
        %% Got a new test case, solve it.
        {test_case, Test} ->
            {ok, FoundMatch} = solve_test_case(Test),
            io:format("~s~n", [FoundMatch]),
            run_test_cases(ReaderPid)
    end.

%% Individual test case solution entry point.
solve_test_case(Test = #test_case{}) -> solve_test_case(Test, 1).

%% If the grid runs out empty, it means that we couldn't find anything.
solve_test_case(#test_case{grid = []}, _) -> {ok, "NO"};

%% If we try a line offset that's bigger than the width of the main grid
%% it means that we had no success searching in the current line, let's
%% recurse to the next.
solve_test_case(Test = #test_case{grid = [_|GridRest]}, LineSearchOffset)
    when LineSearchOffset > Test#test_case.colsG ->
        solve_test_case(Test#test_case{grid = GridRest}, 1);

%% Main search logic. Takes the head of both grid and pattern and tries
%% to find a match, starting from the line offset (because a single line
%% can have multiple matches).
solve_test_case(
    Test = #test_case{
        grid = [GridLine|GridRest],
        pattern = [PatternLine|PatternRest]
    },
    LineSearchOffset
) ->
    %% Extracts the substring from line offset until the end.
    GridComp = string:substr(GridLine, LineSearchOffset),

    %% Does it contain the pattern?
    case string:str(GridComp, PatternLine) of

        %% Nothing found, advance one line in the grid.
        0 -> solve_test_case(Test#test_case{grid = GridRest}, 1);

        %% Something matches for the first line!
        %% Let's check the rest of the pattern.
        N ->
            case check_match(
                Test#test_case{grid = GridRest, pattern = PatternRest},
                LineSearchOffset + N - 1
            ) of
                %% That's a perfect match, return to the main loop.
                match -> {ok, "YES"};
                %% It was a false positive. Advance in the same line, it might
                %% have more matches.
                no_match -> solve_test_case(Test, LineSearchOffset + 1)
            end
    end.

%% If we finished comparing the pattern, it's a perfect match!
check_match(#test_case{pattern = []}, _) -> match;

%% If we run out of grid lines, it's not a match.
check_match(#test_case{grid = []}, _) -> no_match;

%% Main comparison logic for the rest of the pattern.
%% All lines must match at the same position in sequential
%% lines of the main grid.
check_match(
    Test = #test_case{
        grid = [GridLine|GridRest],
        pattern = [PatternLine|PatternRest]
    },
    ExpectedBegin
) ->
    %% Extracts the substring from the line grid and compare
    GridComp = string:substr(GridLine, ExpectedBegin, Test#test_case.colsP),
    case string:equal(GridComp, PatternLine) of
        true ->
            %% So far so good, continue with the other lines.
            check_match(
                Test#test_case{grid = GridRest, pattern = PatternRest},
                ExpectedBegin
            );
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
    #test_case{
        grid = GridLines, colsG = ColsGrid,
        pattern = PatternLines, colsP = ColsPattern
    }.
