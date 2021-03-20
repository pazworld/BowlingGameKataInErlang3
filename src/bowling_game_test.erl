-module(bowling_game_test).
-include_lib("eunit/include/eunit.hrl").

test_sequence(RollFunc) ->
    G = bowling_game:new(),
    Expected = RollFunc(G),
    G ! {score, self()},
    receive
        Score -> ?assertEqual(Expected, Score)
    end.

gutter_game_test() ->
    test_sequence(
        fun(G) ->
            [G ! {roll, 0} || _ <- lists:seq(1, 20)],
            0
        end
    ).

all_ones_test() ->
    test_sequence(
        fun(G) ->
            [G ! {roll, 1} || _ <- lists:seq(1, 20)],
            20
        end
    ).

one_spare_test() ->
    test_sequence(
        fun(G) ->
            G ! {roll, 5},
            G ! {roll, 5},
            G ! {roll, 3},
            [G ! {roll, 0} || _ <- lists:seq(1, 17)],
            16
        end
    ).
