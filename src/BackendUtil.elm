module BackendUtil exposing (..)

import Dict exposing (Dict)
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


transformGameToSendToFE : Dict String Types.Game -> Types.WhoseMove -> Cmd msg
transformGameToSendToFE games whoseMove =
    {- Assuming you are supplying already updated games,
       idea is to transform game and roles inside of each player so that we can supply
       each pleayer on FE with correct "Opponent" and "Owner" data
    -}
    games
        |> Dict.foldl
            (\_ { owner, invitee } _ ->
                case invitee of
                    Just invitee_ ->
                        [ { owner = owner, invitee = invitee_ } ]

                    Nothing ->
                        []
            )
            []
        |> List.map (toPlayersPerspective whoseMove)
        |> List.concat
        |> Cmd.batch


toPlayersPerspective :
    Types.WhoseMove
    -> { owner : Types.Player, invitee : Types.Player }
    -> List (Cmd backendMsg)
toPlayersPerspective whoseMove { owner, invitee } =
    let
        gameFromOwnersPerspective : { player1 : Types.PlayerFe, player2 : Types.PlayerFe }
        gameFromOwnersPerspective =
            { player1 = { figures = invitee.figures, captures = invitee.captures }
            , player2 = { figures = owner.figures, captures = owner.captures }
            }

        convertOpponentToMe : List Types.FigureState
        convertOpponentToMe =
            -- Opponent is looking in game from the first person
            convertRoles invitee.figures

        convertMeToOpponent : List Types.FigureState
        convertMeToOpponent =
            -- From Opponent's perspective - I am Opponent
            convertRoles owner.figures

        gameFromInviteePerspective : { player1 : Types.PlayerFe, player2 : Types.PlayerFe }
        gameFromInviteePerspective =
            { player1 = { figures = convertMeToOpponent, captures = owner.captures }
            , player2 = { figures = convertOpponentToMe, captures = invitee.captures }
            }
    in
    [ Lamdera.sendToFrontend owner.playersSessionId
        (Types.BeToChess <| Types.GameCurrentState gameFromOwnersPerspective whoseMove)
    , Lamdera.sendToFrontend invitee.playersSessionId
        (Types.BeToChess <| Types.GameCurrentState gameFromInviteePerspective whoseMove)
    ]


updateGames : String -> Dict String Types.Game -> (Types.Game -> Types.Player -> Types.Game) -> Dict String Types.Game
updateGames roomId games callback =
    Dict.update roomId
        (Maybe.andThen
            (\game ->
                Maybe.map
                    (callback game)
                    game.invitee
            )
        )
        games


checkForProblems : String -> Lamdera.SessionId -> Types.BackendModel -> ( Types.BackendModel, Cmd backendMsg ) -> Result String ( Types.BackendModel, Cmd backendMsg )
checkForProblems roomId sessionId model_ updted =
    -- Check for any misbehaviour and if all good just send wahtever passed
    Dict.get roomId model_.games
        |> Maybe.map
            (\{ invitee, owner } ->
                case invitee of
                    Just _ ->
                        -- Err "JoinGame: Game has already started"
                        Ok updted

                    Nothing ->
                        if sessionId == owner.playersSessionId then
                            Err "JoinGame: You are trying to play game with yourself, that is not posible"

                        else
                            Ok updted
            )
        |> Maybe.withDefault (Err "Something went terribly wrong")
