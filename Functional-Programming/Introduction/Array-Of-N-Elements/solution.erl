-module(solution).
-export([main/0]).

% Proxy the function call
createArray(N) ->
    createArray([], N).

% Break condition for the recursion and return the result
createArray(List, 0) ->
    {ok, List};
% Function to create an arbitrary array with N elements
createArray(List, N) ->
    % Recursive call (tail recursion)
    createArray([1|List], N-1).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    {ok, Arr} = createArray(N),

    % The following line was requested by
    % the challenge to check the answer
    io:format("~B~n", [length(Arr)]).
