-module(solution).
-export([main/0]).

% Define the pure call to readLines to proxy the actual call
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

% Break recursion for printNumbersAtEvenIndexes when an empty list is passed
printNumbersAtEvenIndexes([]) -> ok;

% Break recursion for printNumbersAtEvenIndexes when the last item is at an odd index
printNumbersAtEvenIndexes([_|[]]) -> ok;

% Function printNumbersAtEvenIndexes takes the list of numbers
% It throws away the first element (odd index) and print the next (even index)
printNumbersAtEvenIndexes([_|[EvenIndex|RestOfNumbers]]) ->
    % Output the number and a new line
    io:format("~b~n", [EvenIndex]),
    % Call itself for the rest of elements (tail recursion)
    printNumbersAtEvenIndexes(RestOfNumbers).

main() ->
    % Get the list of numbers
    {ok, ListOfNumbers} = readLines(),
    % Call the implementation
    printNumbersAtEvenIndexes(ListOfNumbers).
