-module(solution).
-export([main/0]).

-spec readInput() -> {float(), integer(), integer()}.
readInput() ->
    {ok, [MealPrice]} = io:fread("", "~f"),
    {ok, [TipPercentage]} = io:fread("", "~d"),
    {ok, [TaxPercentage]} = io:fread("", "~d"),
    {MealPrice, TipPercentage, TaxPercentage}.

-spec calculateTotal({float(), integer(), integer()}) -> integer().
calculateTotal({MealPrice, TipPercentage, TaxPercentage}) ->
    round(MealPrice + (MealPrice*TipPercentage)/100 + (MealPrice*TaxPercentage)/100).

main() ->
    Input = readInput(),
    Total = calculateTotal(Input),
    io:format("The final price of the meal is $~B.~n", [Total]).
