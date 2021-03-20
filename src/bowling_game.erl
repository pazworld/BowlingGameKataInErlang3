-module(bowling_game).
-export([new/0, game/1]).

new() ->
    spawn(?MODULE, game, [[]]).

game(Rolls) ->
    receive
        {roll, Pins} -> game([Pins | Rolls]);
        {score, Sender} -> Sender ! score(1, lists:reverse(Rolls))
    end.

% All rolls are processed
score(_FrameIndex, []) ->
    0;

% 10th frame
score(10, Rolls) ->
    lists:sum(Rolls);

% Strike
score(FrameIndex, [Pins1, Pins2, Pins3 | Rest]) when Pins1 =:= 10 ->
    10 + Pins2 + Pins3 + score(FrameIndex + 1, [Pins2, Pins3 | Rest]);

% Spare
score(FrameIndex, [Pins1, Pins2, Pins3 | Rest]) when Pins1 + Pins2 =:= 10 ->
    10 + Pins3 + score(FrameIndex + 1, [Pins3 | Rest]);

% Not strike nor spare
score(FrameIndex, [Pins1, Pins2 | Rest]) ->
    Pins1 + Pins2 + score(FrameIndex + 1, Rest).
