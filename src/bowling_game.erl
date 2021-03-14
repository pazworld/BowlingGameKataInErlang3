-module(bowling_game).
-export([new/0, game/1]).

new() ->
    spawn(?MODULE, game, [0]).

game(Score) ->
    receive
        {roll, Pins} -> game(Score + Pins);
        {score, Sender} -> Sender ! Score
    end.
