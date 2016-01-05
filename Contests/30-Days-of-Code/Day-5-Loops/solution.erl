-module(solution).
-export([main/0]).

-spec readAndCalculate() -> ok.
readAndCalculate() ->
    case io:fread("", "~d ~d ~d") of
        {ok, [A, B, N]} ->
            calculateAndOutput(A, B, N),
            readAndCalculate();
        _ -> ok
    end.

-spec calculateAndOutput(integer(), integer(), integer()) -> ok.
calculateAndOutput(A, B, N) ->
    calculateAndOutput(0, 0, A, B, N).

-spec calculateAndOutput(integer(), integer(), integer(), integer(), integer()) -> ok.
calculateAndOutput(_, N, _, _, N) ->
    io:format("~n");
calculateAndOutput(0, 0, A, B, N) ->
    Term = A + B,
    io:format("~B", [Term]),
    calculateAndOutput(Term, 1, A, B, N);
calculateAndOutput(Acc, Step, A, B, N) ->
    Term = Acc + B * trunc(math:pow(2, Step)),
    io:format(" ~B", [Term]),
    calculateAndOutput(Term, Step + 1, A, B, N).

main() ->
    {ok, _} = io:fread("", "~d"),
    readAndCalculate().
