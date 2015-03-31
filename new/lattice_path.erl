-module(lattice_path).
-export([main/1]).

get_array(Xmax) ->
	_List = [{a, {X,Y}} || X <- lists:seq(1,Xmax+1), Y <- lists:seq(1,Xmax+1)].

f({X,Y}, List) ->
	case {lists:member({a, {X+1,Y}}, List), lists:member({a, {X,Y+1}}, List), X==Y} of
		{true, true, true}  -> 2*f({X+1,Y}, List);
		{true, true, false}	-> f({X+1,Y}, List) + f({X,Y+1}, List);
		{true, false,  _}	-> f({X+1,Y}, List);
		{false, true, _}	-> f({X,Y+1}, List);
		{false, false, _}	-> 1
	end.


main(Dim) ->
	io:format("~p~n", [time()]),
	List = get_array(Dim),
    io:format("~p routes in a ~px~p grid~n", [f({1,1}, List), Dim, Dim]),
    io:format("~p~n", [time()]).