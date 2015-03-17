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

% Break recursion for printResult when an empty list is passed
printResult([]) -> ok;

% Function printResult takes the list to print
printResult([H|RestOfNumbers]) ->
    % Take the first element and print it, plus a new line
    io:format("~b~n", [H]),
    % Call itself for the rest of elements (tail recursion)
    printResult(RestOfNumbers).

main() ->
    % Get the first line of input (the limit value for the list)
    {ok, [Limit]} = io:fread("", "~d"),
    % Get the list of numbers
    {ok, ListOfNumbers} = readLines(),
    % Use a list comprehension to clean the list and print the result
    printResult([X || X <- ListOfNumbers, X < Limit]).
