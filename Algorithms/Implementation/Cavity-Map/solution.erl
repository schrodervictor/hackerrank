-module(solution).
-export([main/0]).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    {ok, DepthsLines} = io:fread("", string:copies("~s", N)),
    Depths = to_int_list(DepthsLines),
    {ok, Answer} = find_cavities(N, Depths),
    ok = output_answer(N, Answer).

to_int_list(StringList) ->
    lists:map(
        fun(X) -> {Int, _Rest} = string:to_integer([X]), Int end,
        lists:flatten(StringList)
    ).

find_cavities(N, Depths) ->
    find_cavities(N, N*N, 1, Depths, []).

find_cavities(N, MaxElement, Element, _, Output)
  when Element > MaxElement -> {ok, lists:reverse(Output)};

find_cavities(N, MaxElement, Element, Depths, Output)
    when
        %% First row
        Element < N orelse
        %% First element of each row
        Element rem N =:= 1 orelse
        %% Last element of each row
        Element rem N =:= 0 orelse
        %% Last row
        Element > MaxElement - N
    ->
        find_cavities(
            N, MaxElement, Element + 1, Depths,
            [integer_to_list(lists:nth(Element, Depths))|Output]
        );

find_cavities(N, MaxElement, Element, Depths, Output) ->
    Depth = lists:nth(Element, Depths),
    case
        %% Top
        Depth > lists:nth(Element - N, Depths) andalso
        %% Left
        Depth > lists:nth(Element - 1, Depths) andalso
        %% Rigth
        Depth > lists:nth(Element + 1, Depths) andalso
        %% Bottom
        Depth > lists:nth(Element + N, Depths)
    of
        true ->
            find_cavities(
                N, MaxElement, Element + 1, Depths,
                ["X"|Output]
            );
        false ->
            find_cavities(
                N, MaxElement, Element + 1, Depths,
                [integer_to_list(Depth)|Output]
            )
    end.

output_answer(_, []) -> ok;
output_answer(N, Answer) ->
    {Line, Rest} = lists:split(N, Answer),
    io:format("~s~n", [Line]),
    output_answer(N, Rest).
