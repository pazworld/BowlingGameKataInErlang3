-module(bowling_game).
-export([new/0, game/1]).

new() ->
    spawn(?MODULE, game, [[]]).

game(Rolls) ->
    receive
        {roll, Pins} -> game([Pins | Rolls]);
        {score, Sender} -> Sender ! score(lists:reverse(Rolls))
    end.

score([]) ->
    0;

score([Pins1, Pins2, Pins3 | Rest]) when Pins1 =:= 10 ->
    10 + Pins2 + Pins3 + score([Pins2, Pins3 | Rest]);

score([Pins1, Pins2, Pins3 | Rest]) when Pins1 + Pins2 =:= 10 ->
    10 + Pins3 + score([Pins3 | Rest]);

score([Pins1, Pins2 | Rest]) ->
    Pins1 + Pins2 + score(Rest).
