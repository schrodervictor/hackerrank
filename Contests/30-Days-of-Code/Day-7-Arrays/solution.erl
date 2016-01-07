-module(solution).
-export([main/0]).

-spec getNumberList() -> [string()].
getNumberList() ->
    getNumberList([]).

-spec getNumberList([string()]) -> [string()].
getNumberList(Accumulator) ->
    case io:fread("", "~s") of
        {ok, [N]} -> getNumberList([N|Accumulator]);
        _ -> Accumulator
    end.

-spec outputNumberList([string()]) -> ok.
outputNumberList([N|[]]) ->
    io:format("~s~n", [N]);
outputNumberList([N|NumberList]) ->
    io:format("~s ", [N]),
    outputNumberList(NumberList).

main() ->
    {ok, _} = io:fread("", "~d"),
    ReverseNumberList = getNumberList(),
    outputNumberList(ReverseNumberList).
