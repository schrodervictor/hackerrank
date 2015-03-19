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


% Proxy the call to countElements/2 with an initial Accumulator = 0
countElements(List) -> countElements(List, 0).

% Break recursion for countElements when an empty list is passed and return the result
countElements([], Accumulator) -> {ok, Accumulator};

% Recursivelly call countElements adding 1 to the Accumulator
countElements([_|Tail], Accumulator) -> countElements(Tail, Accumulator + 1).

main() ->
    % Get the list of numbers
    {ok, ListOfNumbers} = readLines(),
    % Call the implementation
    {ok, Counter} = countElements(ListOfNumbers),
    % Output the result
    io:format("~b~n", [Counter]).
