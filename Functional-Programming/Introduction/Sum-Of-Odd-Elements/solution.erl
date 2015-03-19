-module(solution).
-export([main/0]).

% Proxy the call to readLines to initialize an empty list for the return value
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

% Proxy the function call to initialize an Accumulator = 0
sumOddElements(List) ->
    sumOddElements(List, 0).

% Break recursion for sumOddElements when an empty list is passed
sumOddElements([], Accumulator) -> {ok, Accumulator};

% Function sumOddElements takes the list of numbers
% and only only sums the Head element if it isn't divisible by two
sumOddElements([Number|RestOfNumbers], Accumulator) ->
    case Number rem 2 of
        0 ->
            sumOddElements(RestOfNumbers, Accumulator);
        _ ->
            sumOddElements(RestOfNumbers, Accumulator + Number)
    end.

main() ->
    % Get the list of numbers
    {ok, ListOfNumbers} = readLines(),
    % Call the implementation
    {ok, SumOdds} = sumOddElements(ListOfNumbers),
    % Output the sum and a new line
    io:format("~b~n", [SumOdds]).
