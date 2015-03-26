-module(solution).
-export([main/0, printPascalTriangle/1]).

% printPascalTriangle/1
%
% Exposed basic call to print the Pascal Triangle
% Prints the first row and initializes a recursive
% call to printPascalTriangle/3 with a Step variable
% and a the first PreviousRow
printPascalTriangle(N) ->
    io:format("1~n"),
    printPascalTriangle(N, 1, [1]).


% printPascalTriangle/3
%
% Iterates and print all lines until the requested Nth level
%
% Break condition for the recursion: N == Step
printPascalTriangle(N, N, _) -> ok;

% Recursive. Takes the PreviousRow and requests
% the next row from getNextPascalTriangleRow/1 and print it.
printPascalTriangle(N, Step, PreviousRow) ->
    % Get the next row
    Row = getNextPascalTriangleRow(PreviousRow),
    % Print the whole line
    [ io:format("~b ", [X]) || X <- Row ],
    % Print a new line for the next iteration
    io:format("~n"),
    % Tail call itself, incrementing the Step
    printPascalTriangle(N, Step+1, Row).


% getNextPascalTriangleRow/1
%
% Builds a list with all Pascal Coefficients from the
% last calculated list. This way we don't need to calculate
% the factorials for each term (actually, we don't explicitly
% calculate any factorial at all!!)
getNextPascalTriangleRow(PreviousRow) ->
    % For this algorithm to work, we need to prepend a zero at
    % the beginning of the previous row
    getNextPascalTriangleRow([0|PreviousRow], []).


% getNextPascalTriangleRow/2
%
% Break condition for the recursion: the list has only the number one.
% We append it to the Accumulator and return it. The list was constructed
% in reverse order... but wait! The lines are always symmetrical, hehehe!
%
% The number one will always be the last. If we were more strict,
% it'd be needed to append a zero also at the end of the list, when we
% started the recursion, in order to have something to sum with this
% last one at the end of the recursion, but it would imply an additional
% list reversion at the beginning of the algorithm.
getNextPascalTriangleRow([1], Accumulator) -> [1|Accumulator];
getNextPascalTriangleRow([H1, H2|RestOfRow], Accumulator) ->
    % You can go check yourself, but each term in a row of the Pascal
    % Triangle is equal to the respective term of the previous line,
    % plus the previous term on that line. That's why we need to add
    % that zero at the beginning of the list.
    getNextPascalTriangleRow([H2|RestOfRow], [H1+H2|Accumulator]).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    printPascalTriangle(N).
