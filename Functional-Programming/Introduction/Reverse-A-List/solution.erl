-module(solution).
-export([main/0]).

% Proxy the call to readLinesReverse
readLinesReverse() ->
    % Read the "next" line of the input (will be the first), with an empty list
    readLinesReverse(next, []).

% Define readLinesReverse function that will read everything from STDIN
% and return as a reversed list of integers
readLinesReverse(next, InputList) ->
    case io:fread("", "~d") of
        {ok, [N]} ->
            % Prepend the new element and call the next (tail recursion)
            readLinesReverse(next, [N|InputList]);
        eof ->
            % Return the list (it's already reversed)
            {ok, InputList}
    end.


% Break recursion for printListOfNumbers when an empty list is passed
printListOfNumbers([]) -> ok;

% Function printList takes the list of numbers to print
printListOfNumbers([H|RestOfNumbers]) ->
    % Output the number and a new line
    io:format("~b~n", [H]),
    % Call itself for the rest of elements (tail recursion)
    printListOfNumbers(RestOfNumbers).

main() ->
    % Get the list of numbers
    {ok, ReverseListOfNumbers} = readLinesReverse(),
    % Output the result
    printListOfNumbers(ReverseListOfNumbers).
