-module(solution).
-export([main/0]).

main() ->
    {ok, [N, K]} = io:fread("", "~d~d"),
    {ok, Ts} = io:fread("", string:copies("~d", N)),
    {ok, NumSpecial} = find_special_problems(K, Ts),
    io:format("~B~n", [NumSpecial]).

find_special_problems(MaxPerPage, ProblemsPerChapter) ->
    find_special_problems(0, 1, MaxPerPage, ProblemsPerChapter).

find_special_problems(Special, _, _, []) -> {ok, Special};
find_special_problems(Special, Page, MaxPerPage, [ChapterNumProblems|RestChapters]) ->

    %% Number of pages for the current chapter.
    ChapterNumPages = trunc(ChapterNumProblems / MaxPerPage + 0.999),

    %% The list of page numbers for this chapter.
    %% For example, if Page = 2 and ChapterNumPages = 5:
    %%     ChapterPages = [2, 3, 4, 5, 6]
    ChapterPages = lists:seq(Page, Page + ChapterNumPages - 1),

    %% Map containing information about each page. Each item has the following
    %% structure:
    %%     {PageNumber, FirstProblem, LastProblem}
    %%
    %% Important: this list doesn't take into account the chapter limitation
    %% for the last page.
    ChapterProblems = lists:map(
        fun(ChapterPage) ->
            FirstProblem = (ChapterPage - Page) * MaxPerPage + 1,
            LastProblem = FirstProblem + MaxPerPage - 1,
            {ChapterPage, FirstProblem, LastProblem}
        end, ChapterPages
    ),

    %% Count the chapter specials.
    ChapterSpecials = lists:foldl(
        fun({ChapterPage, FirstProblem, LastProblem}, Acc)
            when ChapterPage >= FirstProblem andalso
                ChapterPage =< LastProblem andalso
                ChapterPage =< ChapterNumProblems -> Acc + 1;
           (_, Acc) -> Acc
        end, 0, ChapterProblems),

    %% Recurse with the other chapters.
    find_special_problems(
        Special + ChapterSpecials,
        Page + ChapterNumPages,
        MaxPerPage,
        RestChapters
    ).
