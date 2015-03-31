-module(qsort).
-export([cutter/1]).

cutter(List) -> cutter(List, [], []).
cutter([P|[H|T]], L, R) when P>=H -> cutter([P|T], L ++ [H], R);
cutter([P|[H|T]], L, R) when P<H  -> cutter([P|T], L, R ++ [H]);
cutter([X], L, R) -> glue(X, L, R);
cutter([], _, _) -> [].

glue(P, L, R) -> cutter(L) ++ [P] ++ cutter(R).



