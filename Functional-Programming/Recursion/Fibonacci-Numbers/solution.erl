-module(solution).
-export([main/0]).

% As required, this Fibonacci sequence has indices
% starting from one (instead of zero)
fibonacci(1) -> 0;
fibonacci(2) -> 1;

% Proxy the function call to abstract the logic from
% the user and initialize an Accumulator
%
% The first step to be executed will be always 3
% because 1 and 2 are returned directly by the
% previous pattern matches
fibonacci(N) ->
    fibonacci(N, 3, 0, 1).


% Break condition for the recursion is when
% Step == Goal. In this case, do the last sum
% and return the result
fibonacci(N3, N3, N1, N2) ->
    N1+N2;

% The function keeps the track of the previous
% two numbers of the serie to avoid repetitive
% calculations
fibonacci(N3, Step, N1, N2) ->
    fibonacci(N3, Step+1, N2, N1+N2).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    io:format("~p", [fibonacci(N)]).
