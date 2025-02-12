module Backend exposing (app)

import BackendUtil
import Dict exposing (Dict)
import Lamdera
import Maybe.Extra
import Tuple2
import Types


type alias Model =
    Types.BackendModel


startPositionPlayer1 : List Types.FigureState
startPositionPlayer1 =
    [ ( Types.Opponent, { figure = Types.Rook, moves = [ { x = 1, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.Rook, moves = [ { x = 8, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 1, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 2, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 3, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 4, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 5, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 6, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 7, y = 7 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 8, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Knight, moves = [ { x = 2, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.Knight, moves = [ { x = 7, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.Bishop, moves = [ { x = 3, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.Bishop, moves = [ { x = 6, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.King, moves = [ { x = 5, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.Queen, moves = [ { x = 4, y = 1 } ] } )
    ]


startPositionPlayer2 : List Types.FigureState
startPositionPlayer2 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )

    -- , { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] }
    -- , { figure = Types.Pawn, moves = [ { x = 1, y = 3 } ] }
    -- , { figure = Types.Pawn, moves = [ { x = 5, y = 7 } ] }
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


init : ( Model, Cmd Types.BackendMsg )
init =
    ( { -- game = Nothing
        players = Dict.empty
      , games = Dict.empty
      }
    , Cmd.none
    )


update : Types.BackendMsg -> Model -> ( Model, Cmd Types.BackendMsg )
update msg model =
    case msg of
        Types.UserDisconnected sessionId clientId ->
            let
                disconnectedGame : List Lamdera.SessionId
                disconnectedGame =
                    -- Maybe one (or both players) from game have disconnected - notify both
                    model.games
                        |> Dict.filter
                            (\_ { owner, invitee } ->
                                Maybe.map2
                                    (\o i ->
                                        Tuple.first o == sessionId || Tuple.first i == sessionId
                                    )
                                    (Just owner)
                                    invitee
                                    |> Maybe.withDefault False
                            )
                        |> Dict.values
                        |> List.map
                            (\{ owner, invitee } ->
                                case invitee of
                                    Just invitee_ ->
                                        [ Tuple.first owner, Tuple.first invitee_ ]

                                    Nothing ->
                                        [ Tuple.first owner ]
                            )
                        |> List.head
                        |> Maybe.withDefault []

                _ =
                    Debug.log "User Disconnected" ( sessionId, clientId )
            in
            ( model
            , disconnectedGame
                |> List.map
                    (\sessionId_ ->
                        Lamdera.sendToFrontend sessionId_
                            (Types.BeToChess <| Types.ResponseError "Your opponent has left the game")
                    )
                |> Cmd.batch
            )

        Types.UserConnected sessionId clientId ->
            let
                _ =
                    Debug.log "User Connected" ( sessionId, clientId )
            in
            -- Game have owner of the game and invitee - First add owner of a game and starting figures
            -- ( { model
            --     | players = Dict.insert sessionId startPositionPlayer2 model.players
            --   }
            -- , Cmd.none
            -- )
            ( model, Cmd.none )

        Types.NoOpBackendMsg ->
            ( model, Cmd.none )


updateFromFrontend : Lamdera.SessionId -> Lamdera.ClientId -> Types.ToBackend -> Model -> ( Model, Cmd Types.BackendMsg )
updateFromFrontend sessionId clientId msg model =
    case msg of
        Types.NoOpToBackend ->
            ( model, Cmd.none )

        Types.InitiateGame roomId ->
            ( { model
                | games =
                    Dict.insert roomId
                        { owner = ( sessionId, startPositionPlayer2 )
                        , invitee = Nothing
                        }
                        model.games
              }
            , Cmd.none
            )

        Types.JoinGame roomId ->
            let
                haveTwoPlayers : Bool
                haveTwoPlayers =
                    Dict.get roomId model.games
                        |> Maybe.map (\{ invitee } -> invitee == Nothing)
                        |> Maybe.withDefault False

                updated : ( Model, Cmd Types.BackendMsg )
                updated =
                    let
                        updateGames :
                            Dict
                                String
                                { owner : ( Lamdera.SessionId, List Types.FigureState )
                                , invitee : Maybe ( Lamdera.SessionId, List Types.FigureState )
                                }
                        updateGames =
                            Dict.update roomId
                                (Maybe.map (\rec -> { rec | invitee = Just ( sessionId, startPositionPlayer1 ) }))
                                model.games
                    in
                    ( { model
                        | -- players = updatePlayers
                          games = updateGames
                      }
                    , updateGames
                        |> Dict.foldl
                            (\_ { owner, invitee } _ ->
                                case invitee of
                                    Just invitee_ ->
                                        [ { owner = owner, invitee = invitee_ } ]

                                    Nothing ->
                                        []
                            )
                            []
                        |> List.map
                            (\{ owner, invitee } ->
                                let
                                    positionsForOwner =
                                        ( Tuple.second invitee, Tuple.second owner )

                                    convertOpponentToMe =
                                        -- Opponent is looking in game from the first person
                                        BackendUtil.convertRoles False (Tuple.second invitee)

                                    convertMeToOpponent =
                                        -- From Opponent's perspective - I am Opponent
                                        BackendUtil.convertRoles True (Tuple.second owner)

                                    positionsForInvitee =
                                        ( convertMeToOpponent, convertOpponentToMe )
                                in
                                [ Lamdera.sendToFrontend (Tuple.first owner)
                                    (Types.BeToChess <| Types.GameCurrentState positionsForOwner)
                                , Lamdera.sendToFrontend (Tuple.first invitee)
                                    (Types.BeToChess <| Types.GameCurrentState positionsForInvitee)
                                ]
                            )
                        |> List.concat
                        |> Cmd.batch
                    )
            in
            if haveTwoPlayers then
                updated

            else
                ( model, Lamdera.sendToFrontend sessionId (Types.BeToChess <| Types.ResponseError "JoinGame: Game has already started") )

        Types.ChessOutMsg_toBackend_SendPositionsUpdate roomId isFromInviteePerspective ( pl1, pl2 ) ->
            let
                haveTwoPlayers : Bool
                haveTwoPlayers =
                    Dict.get roomId model.games
                        |> Maybe.map (\{ invitee } -> invitee /= Nothing)
                        |> Maybe.withDefault False

                updated : ( Model, Cmd Types.BackendMsg )
                updated =
                    let
                        updateGames :
                            Dict
                                String
                                { owner : ( Lamdera.SessionId, List Types.FigureState )
                                , invitee : Maybe ( Lamdera.SessionId, List Types.FigureState )
                                }
                        updateGames =
                            if isFromInviteePerspective then
                                Dict.update roomId
                                    (Maybe.andThen
                                        (\rec ->
                                            Maybe.map
                                                (\invitee_ ->
                                                    { invitee = Just ( Tuple.first invitee_, BackendUtil.convertRoles True pl2 )
                                                    , owner = ( Tuple.first rec.owner, BackendUtil.convertRoles False pl1 )
                                                    }
                                                )
                                                rec.invitee
                                        )
                                    )
                                    model.games

                            else
                                Dict.update roomId
                                    (Maybe.andThen
                                        (\rec ->
                                            Maybe.map
                                                (\invitee_ ->
                                                    { invitee = Just ( Tuple.first invitee_, pl1 )
                                                    , owner = ( Tuple.first rec.owner, pl2 )
                                                    }
                                                )
                                                rec.invitee
                                        )
                                    )
                                    model.games
                    in
                    ( { model
                        | games = updateGames
                      }
                    , updateGames
                        |> Dict.foldl
                            (\_ { owner, invitee } _ ->
                                case invitee of
                                    Just invitee_ ->
                                        [ { owner = owner, invitee = invitee_ } ]

                                    Nothing ->
                                        []
                            )
                            []
                        |> List.map
                            (\{ owner, invitee } ->
                                let
                                    positionsForOwner =
                                        ( Tuple.second invitee, Tuple.second owner )

                                    convertOpponentToMe =
                                        -- Opponent is looking in game from the first person
                                        BackendUtil.convertRoles False (Tuple.second invitee)

                                    convertMeToOpponent =
                                        -- From Opponent's perspective - I am Opponent
                                        BackendUtil.convertRoles True (Tuple.second owner)

                                    positionsForInvitee =
                                        ( convertMeToOpponent, convertOpponentToMe )
                                in
                                [ Lamdera.sendToFrontend (Tuple.first owner)
                                    (Types.BeToChess <| Types.GameCurrentState positionsForOwner)
                                , Lamdera.sendToFrontend (Tuple.first invitee)
                                    (Types.BeToChess <| Types.GameCurrentState positionsForInvitee)
                                ]
                            )
                        |> List.concat
                        |> Cmd.batch
                    )
            in
            if haveTwoPlayers then
                updated

            else
                ( model
                , Lamdera.sendToFrontend
                    sessionId
                    (Types.BeToChess <| Types.ResponseError "UpdateGame: Game has already started")
                )


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }


subscriptions : Types.BackendModel -> Sub Types.BackendMsg
subscriptions _ =
    Sub.batch
        [ Lamdera.onConnect Types.UserConnected
        , Lamdera.onDisconnect Types.UserDisconnected
        ]
