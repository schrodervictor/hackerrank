-module(solution).
-export([main/0]).

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

main() ->
    {ok, [X, Y]} = io:fread("", "~d~d"),
    {ok, GCD} = calculateGCD(X, Y),
    io:format("~p", [GCD]).
