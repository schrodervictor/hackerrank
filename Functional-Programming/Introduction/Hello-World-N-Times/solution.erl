-module(solution).
-export([main/0]).

% Define the repeatHelloWorld function with two cases
% When N is zero, break the recursive execution
repeatHelloWorld(0) -> ok;

% When N is positive, print Hello World
repeatHelloWorld(N)
    when N > 0 ->
        io:format("~s~n", ["Hello World"]),
        % And call itself with N-1 (recursion)
        repeatHelloWorld(N-1).

% When N is negative the call will fail

main() ->
    % The expected input is one integer
    {ok, [N]} = io:fread("", "~d"),
    % Call repeatHelloWorld implementation
    repeatHelloWorld(N).
