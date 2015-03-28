-module(solution).
-export([main/0]).

% Take a line of strings space separated and transform it
% into a List of strings (removing the line break)
lineAsListOfStrings(Line) ->
    re:split(string:strip(Line -- "\n"), " ", [{return,list}]).

% Read the input as a string (line of numbers, space separated)
% and return {ok, ListOfIntegers}
readLineAsList() ->
    case io:get_line("") of
        eof ->
            ok;
        N ->
            {ok, [ list_to_integer(X) || X <- lineAsListOfStrings(N) ]}
    end.

% When the numbers are equal, there's no need to calculate
% anything, the GCD is the number itself
calculateGCD(X, X) -> {ok, X};

% If Y is greater than X, swap them
calculateGCD(X, Y)
    when X < Y -> calculateGCD(Y, X);

% Having Y smaller than X, call the
% Euclidian Algorithm implementation
calculateGCD(X, Y)
    when X > Y -> euclidianAlgorithm(X, Y).


% Break condition for the recursion: we've found
% a reminder equals to zero
euclidianAlgorithm(PreviousReminder, 0) -> {ok, PreviousReminder};

% The Euclidian Algorithm is based on sucessive reminders
% until find one that is equal to zero. In this case, the
% GCD is the previous calculated reminder
euclidianAlgorithm(PreviousReminder, Reminder) ->
    euclidianAlgorithm(Reminder, PreviousReminder rem Reminder).

% This function is here to transform the list of factors
% into an integer.
% This is not the best approach, but I want to check how
% good the Euclidian Algorithm can run in this case
multiplyThemAll(Factors) ->
    multiplyThemAll(Factors, 1).

% Recursive function only to multiply everything in a list
multiplyThemAll([], Accumulator) -> {ok, Accumulator};
multiplyThemAll([Factor|RestOfFactors], Accumulator) ->
    multiplyThemAll(RestOfFactors, Accumulator*Factor).

main() ->
    % Throw away the first number (we don't need it)
    {ok, _} = io:fread("", "~d"),
    % Read the first list of factors
    {ok, Factors1} = readLineAsList(),
    % Throw away the second number (we don't need this too)
    {ok, _} = io:fread("", "~d"),
    % Read the second list of factors
    {ok, Factors2} = readLineAsList(),
    % Transform both lists into integers
    % (this is needed for the Euclidian Algorithm)
    {ok, N1} = multiplyThemAll(Factors1),
    {ok, N2} = multiplyThemAll(Factors2),
    % Calculate the GCD
    {ok, GCD} = calculateGCD(N1, N2),
    % Output the GCD, modulo 10^9+7
    io:format("~p", [GCD rem 1000000007]).
