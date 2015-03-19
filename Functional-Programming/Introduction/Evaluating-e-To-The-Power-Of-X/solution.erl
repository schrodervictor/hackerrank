-module(solution).
-export([main/0]).

% Define the pure call to readLines to proxy the actual call
readLines() ->
    % Read the "next" line of the input (will be the first), with an empty list
    readLines(next, []).

% Define readLines function that will read everything from STDIN
% and return as a list of integers
readLines(next, InputList) ->
    case io:fread("", "~f") of
        {ok, [N]} ->
            % Prepend the new element and call the next (tail recursion)
            % The list will be reverted at the end.
            readLines(next, [N|InputList]);
        eof ->
            % Reverse the list and return it
            {ok, lists:reverse(InputList)}
    end.

% Build a list of factorials from 0 to 9
factorialList(N) ->
    % Initialize the function call with the two first
    % factorials and the next step (2)
    factorialList([1, 1], 2, N).

% Break condition for the recursion and return List
factorialList(List, Step, N) 
    when Step =:= N -> {ok, lists:reverse(List)};

% Recursion to build the next factorial element
% The list is generated in reverse order, for performance
factorialList([Last|RestOfList], Step, N) ->
    factorialList([Last*Step, Last|RestOfList], Step+1, N).

% Proxy the function call to initialize Step and Accumulator variables
evaluateNaturalExponential(X, Factorials) ->
    evaluateNaturalExponential(X, Factorials, 0, 0).

% Break condition for the recursion (we ran out of factorials)
evaluateNaturalExponential(_, [], _, Accumulator) -> Accumulator;

% Function for the iterations in the series expansion
evaluateNaturalExponential(X, [Factorial|NextFactorials], Step, Accumulator) ->
    % Calculate the next step of the expansion
    ExpansionStep = math:pow(X, Step)/Factorial,
    % Tail call the function itself, updating Step and Accumulator
    evaluateNaturalExponential(X, NextFactorials, Step+1, Accumulator+ExpansionStep).

main() ->
    % The first line is a integer with the number of test cases, but we don't need that
    {ok, _} = io:fread('', "~d"),
    % Get the list of numbers
    {ok, ListOfNumbers} = readLines(),
    % Set the number of iterations that will be used
    Iterations = 10,
    % Calculate all the factorials we'll need, according with the number of iterations
    % (we don't want to calculate factorials multiple times)
    {ok, Factorials} = factorialList(Iterations),
    % Call the implementation and output the result for each number in the list
    [ io:format("~.4f~n", [evaluateNaturalExponential(X, Factorials)]) || X <- ListOfNumbers ].

