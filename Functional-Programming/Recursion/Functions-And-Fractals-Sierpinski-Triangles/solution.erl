-module(solution).
-export([main/0, getSierpinskiTriangle/2]).

% getSierpinskiTriangle/2
%
% This is the exposed function to draw the Sierpinski triangle.
% It takes the number of rows and the how many iterations will
% be performed.
%
% The number of rows must be a power of 2 and the number of
% iterations must be that power or less
%
% This function is called recursivelly, decreasing the number of iterations.
% When we hit iterations = 0, then we must return a full triangle.
getSierpinskiTriangle(Rows, 0) ->
    getFullTriangle(Rows);

% If there are more iterations to be done, the rectangular area must be
% divided into five fields, being three subtriangles and two semi-blanks:
%
% |---|-------|---|
% |   |       |   |
% | B |   T   | B |
% |   |       |   |
% |---|---|---|---|
% |       |       |
% |   T   |   T   |
% |       |       |
% |-------|-------|
%
% The subtriangles are Sierpinski triangles, with half height and N-1
% iterations. The semiblanks are fields composed only by blanks ("_")
% having half height and 1/4 width.
getSierpinskiTriangle(Rows, N) ->
    % Basic blank line for this level of iteration
    Blank = string:chars($_, Rows div 2),
    % Subtriangle (recursive call)
    Triangle = getSierpinskiTriangle(Rows div 2, N-1),
    % Glue everything together in a list and return it
    lists:append(
        % First "row" = Semiblank + Subtriangle + Semiblank
        [ [Blank, X, Blank] || X <- Triangle ],
        % Second "row" = Subtriangle + Subtriangle, but with
        % a single column of "_"s between tehm, because 1 is
        % the minimum resolution for the final picture here
        [ [X, "_", X] || X <- Triangle ]
    ).

% getFullTriangle/1
%
% Basic call to drawTriangle only need the height in rows.
getFullTriangle(Rows) ->
    % Initialize Steps = 0 and an Accumulator
    getFullTriangle(Rows, 0, []).

% drawFullTriangle/3
%
% Recursive function to return a full triangle of ones
% Example for Rows = 3:
%
% [
%  ["__","1","__"],
%  ["_","111","_"],
%  [[],"11111",[]]
% ]
%
% Break condition for the recursion, Step = Rows
getFullTriangle(Rows, Rows, Accumulator) -> Accumulator;

% Recursive function to draw the triangle. It's built
% from bottom to top. This way the list is already in the
% correct order when finished 
% (no need to reverse the result = better performance)
getFullTriangle(Rows, Step, Accumulator) ->
    Zeros = string:chars($_, Step),
    Ones = string:chars($1, (Rows-Step)*2-1),
    Line = [Zeros, Ones, Zeros],
    getFullTriangle(Rows, Step+1, [Line|Accumulator]).

main() ->
    Rows = 32,
    {ok, [N]} = io:fread("", "~d"),
    [io:format("~s~n", [X]) || X <- getSierpinskiTriangle(Rows, N)].
