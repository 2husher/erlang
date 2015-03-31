-module(read_file).
-export([main/0]).

ungzip(Binary) ->
	{ok, Binary} = file:read_file("doll.bin"), 
	Ungzbin = zlib:gunzip(Binary),
	file:write_file("doll.bin", Ungzbin),
	io:format(".", []),
	ungzip(Ungzbin).

main() ->
	{ok, Binary} = file:read_file("doll.bin"), 
	ungzip(Binary).
