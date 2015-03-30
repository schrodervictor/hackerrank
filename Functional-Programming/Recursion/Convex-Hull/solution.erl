-module(solution).
-export([main/0]).

readListOfPoints() ->
    readListOfPoints([]).
readListOfPoints(Accumulator) ->
    case io:fread("","~d ~d") of
        {ok, [X, Y]} -> readListOfPoints([[X,Y]|Accumulator]);
        eof -> {ok, Accumulator}
    end.

calculateConvexHull(ListOfPoints) ->
    MapOfPoints = [ {Point, Point} || Point <- ListOfPoints ],
    {[XB, YB], _} = BasePoint = lists:foldl(
        fun(Point, []) -> Point;
           ({[_,Y], _} = Point, {[_,Y1], _} = Carry) ->
            case Y < Y1 of
                true -> Point;
                false -> Carry
            end
        end, [], MapOfPoints),
    io:format("BasePoint:~n~p~n", [BasePoint]),
    RebasedPoints = [ {Original, [(X-XB), (Y-YB)]} || {Original, [X, Y]} <- MapOfPoints ],
    calculateConvexHull(RebasedPoints, [BasePoint]).

calculateConvexHull(Points, Accumulator) ->
    {CoordFound, _} = Point = findNextPoint(Points),
    io:format("FindNextPoint(calc):~n~p~n", [Point]),
    case lists:any(fun({Coord, _}) -> Coord =:= CoordFound end, Accumulator) of
        true ->
            Accumulator;
        false ->
            RebasedPoints = changeCoordinateSystem(Point, Points),
            calculateConvexHull(RebasedPoints, [Point|Accumulator])
    end.

changeCoordinateSystem({_, [OX, OY]}, Points) ->
    Hip = math:sqrt(OX*OX+OY*OY), Sin = OY / Hip, Cos = OX / Hip,
    [ {Original, [(X-OX)*Cos + (Y-OY)*Sin, -(X-OX)*Sin + (Y-OY)*Cos]} || {Original, [X, Y]} <- Points ].

findNextPoint(Points) ->
    F = fun(Point, []) -> io:format("~n1-point"), Point;
           ({_, [0,0]}, Carry) -> io:format("~n1-carry"), Carry;
           (Point = {_,[X, Y]}, Carry = {_,[CX, CY]}) ->
            io:format("~nPoint:~p~n~nCarry:~p~n~n", [Point, Carry]),
            TanSmallerOrEqual = math:atan2(Y, X) =< math:atan2(CY, CX),
            MoreDistant = (X*X+Y*Y) > (CX*CX+CY*CY),
            case TanSmallerOrEqual andalso MoreDistant of
                true -> io:format("~npoint"), Point;
                false -> io:format("~ncarry"), Carry
            end
        end,
    Point = lists:foldl(F, [], Points),
    io:format("FindNextPoint:~n~p~n", [Point]),
    Point.

main() ->
    {ok, [_]} = io:fread("", "~d"),
    {ok, ListOfPoints} = readListOfPoints(),
    ConvexHullListOfPoints = calculateConvexHull(ListOfPoints),
    io:format("~p", [ConvexHullListOfPoints]).
    %ConvexHullPerimeter = calculatePerimeter(ConvexHullListOfPoints),
    %io:format("~f", [ConvexHullPerimeter]).

