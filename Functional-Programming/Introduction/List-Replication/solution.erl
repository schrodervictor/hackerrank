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

% Break recursion for printEachNTimes when an empty list is passed
printEachNTimes([], _) -> ok;

% Function printEachNTimes takes the list to repeat and the number of repetitions
printEachNTimes([H|RestOfNumbers], N) ->
    % Take the first element and print it N times
    printNTimes(H, N),
    % Call itself for the rest of elements (tail recursion)
    printEachNTimes(RestOfNumbers, N).

% Break recursion of printNTimes when N = 0
printNTimes(_, 0) -> ok;

% Function printNTimes takes a number and print it N times in separate lines
printNTimes(Number, N) ->
    % Output the number and a new line
    io:format("~b~n", [Number]),
    % And call itself with N-1 (tail recursion)
    printNTimes(Number, N-1).

main() ->
    % Get the first line of input (the number of repetitions)
    {ok, [NumberOfRepetitions]} = io:fread("", "~d"),
    % Get the list of numbers
    {ok, ListOfNumbers} = readLines(),
    % Call the implementation
    printEachNTimes(ListOfNumbers, NumberOfRepetitions).
