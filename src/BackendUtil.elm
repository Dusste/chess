module BackendUtil exposing (..)

import Lamdera
import Types


coordinateInMirror : Int -> Int
coordinateInMirror x =
    -- TODO figure out smarter way
    case x of
        1 ->
            8

        2 ->
            7

        3 ->
            6

        4 ->
            5

        8 ->
            1

        7 ->
            2

        6 ->
            3

        5 ->
            4

        _ ->
            x


convertRoles : List Types.FigureState -> List Types.FigureState
convertRoles player =
    List.map
        (\t ->
            let
                mirroredFigureMoves =
                    t
                        |> Tuple.second
                        |> (\{ figure, moves } ->
                                { figure = figure
                                , moves =
                                    moves
                                        |> List.map
                                            (\{ x, y } ->
                                                { x = coordinateInMirror x
                                                , y = coordinateInMirror y
                                                }
                                            )
                                }
                           )
            in
            ( case Tuple.first t of
                Types.Opponent ->
                    Types.Me

                Types.Me ->
                    Types.Opponent
            , mirroredFigureMoves
            )
        )
        player
