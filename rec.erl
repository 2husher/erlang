-module(rec).
-export([fac/1, len/1, tail_fac/1, tail_len/1, duplicate/2, tail_duplicate/2, reverse/1, tail_reverse/1, sublist/2, tail_sublist/2, zip/2, tail_zip/2, lenient_zip/2, lenient_tail_zip/2]).

fac(N) when N>0 -> fac(N-1) * N;
fac(0) -> 1.

len([]) -> 0;
len([_|T]) -> 1 + len(T).

tail_fac(N) -> tail_fac(N, 1).
tail_fac(N, Acc) when N>0 -> tail_fac(N-1, N*Acc);
tail_fac(0, Acc) -> Acc.

tail_len(N) -> tail_len(N, 0).
tail_len([], Acc) -> Acc;
tail_len([_|T], Acc) -> tail_len(T, Acc+1).

duplicate(0, _) -> [];
duplicate(N, Term) when N>0 -> [Term | duplicate(N-1, Term)].

tail_duplicate(N, Term) -> tail_duplicate(N, Term, []).
tail_duplicate(N, Term, L) when N>0 -> tail_duplicate(N-1, Term, [Term | L]);
tail_duplicate(0, _, L) -> L.

reverse([]) -> [];
reverse([H|T]) -> reverse(T) ++ [H].

tail_reverse(L) -> tail_reverse(L, []).
tail_reverse([], L) -> L;
tail_reverse([H|T], L) -> tail_reverse(T, [H] ++ L).

sublist(_, 0)  -> [];
sublist([], _) -> [];
sublist([H|T], N) when N>0 -> [H|sublist(T, N-1)].

tail_sublist(L, N) -> tail_sublist(L, N, []).
tail_sublist([], _, L) -> L;
tail_sublist(_, 0, L)  -> L;
tail_sublist([H|T], N, Acc) when N>0 -> tail_sublist(T, N-1, Acc++[H]).

zip([],[])            -> [];
zip([H1|T1], [H2|T2]) -> [{H1, H2}|zip(T1, T2)].

lenient_zip([], _)            -> [];
lenient_zip(_, [])            -> [];
lenient_zip([H1|T1], [H2|T2]) -> [{H1, H2}|lenient_zip(T1, T2)].

tail_zip(L1, L2) -> tail_zip(L1, L2, []).
tail_zip([], [], Acc) -> Acc;
tail_zip([H1|T1], [H2|T2], Acc) -> tail_zip(T1, T2, Acc++[{H1, H2}]).

lenient_tail_zip(L1, L2) -> lenient_tail_zip(L1, L2, []).
lenient_tail_zip([], _, Acc) -> Acc;
lenient_tail_zip(_, [], Acc) -> Acc;
lenient_tail_zip([H1|T1], [H2|T2], Acc) -> lenient_tail_zip(T1, T2, Acc++[{H1, H2}]).
