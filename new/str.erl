-module(str).
-export([main/0]).

main() -> 
	Str     = "mQmPtphqGrboHhmgaqVhCdwTwignlQvjIopDqVpgaNrwkAzVcnkHyNiPdSmgJmgrPiMjpnjdbuPucHnouwfKuPcybromnmbvfxJqRnnOvWsceZeYzRyqnkaaFsffjenxoIhqHnIzorlOdwZoxYmAuNwNnRppguwidvbtOqdbUngpZdbGqwYjfpLzPjRtwVwEqBbYmCqbKwuziCoEwPsIkJgruTbhdyWpvPztAodufjZxLaZcUeFaklSmeRfolohVbXoDfIqMqgIrQhzedqZlFwaBndQkQexBdLsCfXebrEfiOnSgYquyaqohxoDmLdDhwoOpgtkuRzeYziuvnuvnUuOtqasZueYpKfAkmKcJcWeocQvJguVsZfVovgrztAiryZivHqyMjoLyJdklKifmoWeOjVnogiiaBzDfrsWlOeAzPxltamqQiujZrpZrUcIlyktdJbhmNpDbltOlLnAqVhcxgObghpdcScgIiayqygUgwatiEzgzTsZgApUbbPynLfbzehzWsxcPbdcdfMucsCzjkWvjhMkiWuHfquqrcKwedqghiyHyMkSayRegeJcGw",

	Lowcase = fun(Elem) -> if Elem >= $a, Elem =< $z -> true; true -> false end end,
	LowStr  = lists:filter(Lowcase, Str),
	length(LowStr).
	%Big = fun(Elem) -> if Elem > $A, Elem < $Z -> io:format("~p~n",[Elem]); true -> io:format("",[]) end end,
	%lists:foreach(Big, "bBcCdDS").

	%Big =  fun(X) -> if X < $Z -> true; true -> false end end,
	%lists:filter(Big, [200,500,45,5,3,45,6]).
