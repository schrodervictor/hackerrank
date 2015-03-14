-module(solution).
-export([main/0]).

% The implementation of simple sum
solveMeFirst(A, B) ->
    A + B.

% exported function
main() ->
    % The expected input is two integers in separate lines
    {ok, [A, B]} = io:fread("", "~d~d"),
    % Apply the sum
    Res = solveMeFirst(A,B),
    % And output the result and a line break
    io:format("~p~n",[Res]).
