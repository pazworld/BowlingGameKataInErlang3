-module(bowling_game_test).
-include_lib("eunit/include/eunit.hrl").

gutter_game_test() ->
    G = bowling_game:new(),
    [G ! {roll, 0} || _ <- lists:seq(1, 20)],
    G ! {score, self()},
    receive
        Score -> ?assertEqual(0, Score)
    end.

all_ones_test() ->
    G = bowling_game:new(),
    [G ! {roll, 1} || _ <- lists:seq(1, 20)],
    G ! {score, self()},
    receive
        Score -> ?assertEqual(20, Score)
    end.
