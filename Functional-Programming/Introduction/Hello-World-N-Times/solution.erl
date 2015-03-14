-module(solution).
-export([main/0]).

% Define the repeatHelloWorld function with two cases
repeatHelloWorld(N)
    % When N is zero, break the recursive execution
    when N == 0 -> ok;

repeatHelloWorld(N)
    % When N is positive, print Hello World
    when N > 0 ->
        io:format("~s~n", ["Hello World"]),
        % And call itself with N-1 (recursion)
        repeatHelloWorld(N-1).

main() ->
    % The expected input is one integer
    {ok, [N]} = io:fread("", "~d"),
    % Call repeatHelloWorld implementation
    repeatHelloWorld(N).
