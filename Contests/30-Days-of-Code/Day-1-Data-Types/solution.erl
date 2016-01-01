-module(solution).
-export([main/0]).

get_answer() ->
    Prim = "Primitive",
    Ref = "Referenced",
    [{Prim, "double"},
     {Prim, "char"},
     {Prim, "boolean"},
     {Prim, "int"},
     {Ref, "String"},
     {Prim, "boolean"},
     {Prim, "double"},
     {Prim, "char"},
     {Ref, "String"}].

main() ->
    [ io:format("~s : ~s~n", [MainType, DataType]) || {MainType, DataType} <- get_answer() ].
