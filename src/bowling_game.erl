-module(bowling_game).
-export([new/0, game/1]).

new() ->
    spawn(?MODULE, game, [[]]).

game(Rolls) ->
    receive
        {roll, Pins} -> game([Pins | Rolls]);
        {score, Sender} -> Sender ! lists:sum(Rolls)
    end.
