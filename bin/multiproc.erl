-module(multiproc).
-compile(export_all).

sleep(T) ->
	receive
	after T -> ok
	end.

flush() ->
	receive
		_ -> flush()
	after 0 ->
		ok
	end.

important() ->
	receive
		{Priority, Message} when Priority > 10 ->
			[{Priority, Message} | important()]
	after 0 ->
		normal()
	end.

normal() ->
	receive
		{P, Message} ->
			[{P, Message} | normal()]
	after 0 ->
		[]
	end.