-module(hhfuns).
-compile(export_all).

add(X, Y) -> X() + Y().

one() -> 1.
two() -> 2.

map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F,T)].

incr(X) -> X + 1.
decr(X) -> X - 1.

base(A) ->
    B = A + 1,
    F = fun() -> A*B end,
    F().

a() ->
    Secret = "pony",
    fun() -> Secret end.

b(F) ->
    "a/0's password is "++F().

base1() ->
    A = 1,
    (fun() -> A = 2 end)().

base2() ->
    A = 1,
    (fun(A) -> A = 2 end)(2).


filter(Pred, L) -> lists:reverse(filter(Pred, L,[])).

filter(_, [], Acc) -> Acc;
filter(Pred, [H|T], Acc) ->
    case Pred(H) of
        true  -> filter(Pred, T, [H|Acc]);
        false -> filter(Pred, T, Acc)
    end.

fold(_, Start, []) -> Start;
fold(F, Start, [H|T]) -> fold(F, F(H,Start), T).

