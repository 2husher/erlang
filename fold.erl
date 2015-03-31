-module(fold).
-compile(export_all).

max([H|T]) -> max2(T,H).
max2([], Max) -> Max;
max2([H|T], Max) when H>Max -> max2(T,H);
max2([_|T], Max) -> max2(T,Max).

min([H|T]) -> min2(T,H).
min2([], Min) -> Min;
min2([H|T], Min) when H<Min -> min2(T, H);
min2([_|T], Min) -> min2(T, Min).

sum(L) -> sum(L,0).
sum([], Sum) -> Sum;
sum([H|T], Sum) -> sum(T, H+Sum).

fold(_, Start, []) -> Start;
fold(F, Start, [H|T]) -> fold(F, F(H,Start), T).