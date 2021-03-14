-module(bowling_game).
-export([new/0, game/0]).

new() ->
    spawn(?MODULE, game, []).

game() ->
    receive
        {roll, _Pin} -> game();
        {score, Sender} -> Sender ! 0
    end.
