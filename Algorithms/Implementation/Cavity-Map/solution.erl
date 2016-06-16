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
    find_cavities(N, 1, Depths, []).

find_cavities(N, Element, _, Output)
  when Element > N*N -> {ok, lists:reverse(Output)};

find_cavities(N, Element, Depths, Output)
    when Element < N orelse
        Element rem N =:= 1 orelse
        Element rem N =:= 0 orelse
        Element > N*N - N ->
        find_cavities(
            N, Element + 1, Depths,
            [integer_to_list(lists:nth(Element, Depths))|Output]
        );

find_cavities(N, Element, Depths, Output) ->
    Depth = lists:nth(Element, Depths),
    Up = lists:nth(Element - N, Depths),
    Left = lists:nth(Element - 1, Depths),
    Right = lists:nth(Element + 1, Depths),
    Down = lists:nth(Element + N, Depths),
    case Depth > Up andalso
        Depth > Left andalso
        Depth > Right andalso
        Depth > Down of
        true -> find_cavities(N, Element + 1, Depths, ["X"|Output]);
        false -> find_cavities(
            N, Element + 1, Depths,
            [integer_to_list(Depth)|Output]
        )
    end.

output_answer(_, []) -> ok;
output_answer(N, Answer) ->
    {Line, Rest} = lists:split(N, Answer),
    io:format("~s~n", [Line]),
    output_answer(N, Rest).
