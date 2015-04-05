-module(coroner).
-export([loop/0]).

loop() ->
    % 1. this linked process isn't killed after dying Process
    % 2. exit of Process is in beautiful format {'EXIT'...}
    process_flag(trap_exit, true),

    receive
        {monitor, Process} ->
            link(Process),
            io:format("Monitoring process.~n" ),
            loop();

        {'EXIT', From, Reason} ->
            io:format("The shooter ~p died with reason ~p." , [From, Reason]),
            io:format("Start another one.~n" ),
            loop()
    end.