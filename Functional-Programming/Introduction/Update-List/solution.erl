-module(solution).
-export([main/0]).

% Proxy the function actual call to initialize an empty list for the return value
readLines() ->
    % Read the "next" line of the input (will be the first), with an empty list
    readLines(next, []).

% Define readLines function that will read everything from STDIN
% and return as a list of integers
readLines(next, InputList) ->
    case io:fread("", "~d") of
        {ok, [N]} ->
            % Prepend the new element and call the next (tail recursion)
            % The list will be reverted at the end.
            readLines(next, [N|InputList]);
        eof ->
            % Reverse the list and return it
            {ok, lists:reverse(InputList)}
    end.

main() ->
    % Get the list of numbers
    {ok, ListOfNumbers} = readLines(),
    % Output the result
    [io:format("~b~n", [abs(X)]) || X <- ListOfNumbers].
