-module(solution).
-export([main/0]).

readListOfPoints() ->
    readListOfPoints([]).
readListOfPoints(Collector) ->
    case io:fread("","~d ~d") of
        {ok, [X, Y]} -> readListOfPoints([[X,Y]|Collector]);
        eof -> {ok, Collector}
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
        RebasedPoints = changeCoordinateSystemAndRemovePoint(BasePoint, MapOfPoints),
    calculateConvexHull(RebasedPoints, BasePoint, [BasePoint]).

calculateConvexHull(Points, BasePoint, Accumulator) ->
    {CoordFound, _} = Point = findNextPoint(Points),
    case lists:any(fun({Coord, _}) -> Coord == CoordFound end, Accumulator) of
        true ->
            Accumulator;
        false ->
            RebasedPoints = changeCoordinateSystemAndRemovePoint(Point, Points),
            calculateConvexHull(RebasedPoints, [Point|Accumulator])
    end.

changeCoordinateSystemAndRemovePoint({_, [OX, OY]}, Points) ->
    Hip = math:sqrt(OX*OX+OY*OY), Sin = OY / Hip, Cos = OX / Hip,
    [ {Original, [(X-OX)*Cos + (Y-OY)*Sin, -(X-OX)*Sin + (Y-OY)*Cos]} || {Original, [X, Y]} <- Points, [X, Y] /= [OX, OY] ].

findNextPoint(Points) ->
    F = fun(Point, []) -> Point;
           ({_, [0,0]}, Carry) -> Carry;
           (Point = {_,[X, Y]}, Carry = {_,[CX, CY]}) ->
            TanSmallerOrEqual = math:atan2(Y, X) =< math:atan2(CY, CX),
            MoreDistant = (X*X+Y*Y) > (CX*CX+CY*CY),
            case TanSmallerOrEqual andalso MoreDistant of
                true -> Point;
                false -> Carry
            end
        end,
    lists:foldl(F, [], Points).

calculatePerimeter([FirstPoint|_] = MapOfPoints) ->
    calculatePerimeter(MapOfPoints, FirstPoint, 0).

calculatePerimeter([{[X1, Y1],_}], {[X2, Y2],_}, Accumulator) ->
    Accumulator + math:sqrt(math:pow(X2-X1,2)+math:pow(Y2-Y1,2));
calculatePerimeter([{[X1, Y1],_}, {[X2, Y2],_} = P2|RestOfPoints], FirstPoint, Accumulator) ->
    calculatePerimeter([P2|RestOfPoints], FirstPoint, Accumulator + math:sqrt(math:pow(X2-X1,2)+math:pow(Y2-Y1,2))).

main() ->
    {ok, [_]} = io:fread("", "~d"),
    {ok, ListOfPoints} = readListOfPoints(),
    ConvexHullListOfPoints = calculateConvexHull(ListOfPoints),
    ConvexHullPerimeter = calculatePerimeter(ConvexHullListOfPoints),
    io:format("~.1f", [ConvexHullPerimeter]).

