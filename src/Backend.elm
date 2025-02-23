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
                                    (\ownerAsPlayer inviteeAsPlayer ->
                                        ownerAsPlayer.playersSessionId == sessionId || inviteeAsPlayer.playersSessionId == sessionId
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
                                        [ owner.playersSessionId, invitee_.playersSessionId ]

                                    Nothing ->
                                        [ owner.playersSessionId ]
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
                        { owner =
                            { playersSessionId = sessionId
                            , figures = startPositionPlayer2
                            , captures = []
                            }
                        , invitee = Nothing
                        }
                        model.games
              }
            , Cmd.none
            )

        Types.JoinGame roomId ->
            let
                checkForProblems : a -> Result String a
                checkForProblems a =
                    -- Check for any misbehaviour and if all good just send wahtever passed
                    Dict.get roomId model.games
                        |> Maybe.map
                            (\{ invitee, owner } ->
                                case invitee of
                                    Just _ ->
                                        Err "JoinGame: Game has already started"

                                    Nothing ->
                                        if sessionId == owner.playersSessionId then
                                            Err "JoinGame: You are trying to play game with yourself, that is not posible"

                                        else
                                            Ok a
                            )
                        |> Maybe.withDefault (Err "Something went terribly wrong")

                updated : ( Model, Cmd Types.BackendMsg )
                updated =
                    let
                        updateGames : Dict String Types.Game
                        updateGames =
                            Dict.update roomId
                                (Maybe.map
                                    (\rec ->
                                        { rec
                                            | invitee =
                                                Just
                                                    { playersSessionId = sessionId
                                                    , figures = startPositionPlayer1
                                                    , captures = []
                                                    }
                                        }
                                    )
                                )
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
                                    gameFromOwnersPerspective =
                                        { player1 = { figures = invitee.figures, captures = invitee.captures }
                                        , player2 = { figures = owner.figures, captures = owner.captures }
                                        }

                                    convertOpponentToMe =
                                        -- Opponent is looking in game from the first person
                                        BackendUtil.convertRoles invitee.figures

                                    convertMeToOpponent =
                                        -- From Opponent's perspective - I am Opponent
                                        BackendUtil.convertRoles owner.figures

                                    gameFromInviteePerspective =
                                        { player1 = { figures = convertMeToOpponent, captures = owner.captures }
                                        , player2 = { figures = convertOpponentToMe, captures = invitee.captures }
                                        }
                                in
                                [ Lamdera.sendToFrontend owner.playersSessionId
                                    (Types.BeToChess <| Types.GameCurrentState gameFromOwnersPerspective)
                                , Lamdera.sendToFrontend invitee.playersSessionId
                                    (Types.BeToChess <| Types.GameCurrentState gameFromInviteePerspective)
                                ]
                            )
                        |> List.concat
                        |> Cmd.batch
                    )
            in
            case checkForProblems updated of
                Err err ->
                    ( model
                    , Lamdera.sendToFrontend sessionId
                        (Types.BeToChess <| Types.ResponseError err)
                    )

                Ok updated_ ->
                    updated_

        Types.ChessOutMsg_toBackend_SendPositionsUpdate roomId isFromInviteePerspective ( pl1, pl2 ) ->
            let
                updateGames : Dict String Types.Game
                updateGames =
                    if isFromInviteePerspective then
                        Dict.update roomId
                            (Maybe.andThen
                                (\{ owner, invitee } ->
                                    Maybe.map
                                        (\invitee_ ->
                                            let
                                                updateOwner =
                                                    { owner | figures = BackendUtil.convertRoles pl1 }

                                                updateInvitee =
                                                    { invitee_
                                                        | figures = BackendUtil.convertRoles pl2
                                                    }
                                            in
                                            { invitee = Just updateInvitee
                                            , owner = updateOwner
                                            }
                                        )
                                        invitee
                                )
                            )
                            model.games

                    else
                        Dict.update roomId
                            (Maybe.andThen
                                (\{ owner, invitee } ->
                                    Maybe.map
                                        (\invitee_ ->
                                            let
                                                updateOwner =
                                                    { owner | figures = pl2 }

                                                updateInvitee =
                                                    { invitee_
                                                        | figures = pl1
                                                    }
                                            in
                                            { invitee = Just updateInvitee
                                            , owner = updateOwner
                                            }
                                        )
                                        invitee
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
                            gameFromOwnersPerspective =
                                { player1 = { figures = invitee.figures, captures = invitee.captures }
                                , player2 = { figures = owner.figures, captures = owner.captures }
                                }

                            convertOpponentToMe =
                                -- Opponent is looking in game from the first person
                                BackendUtil.convertRoles invitee.figures

                            convertMeToOpponent =
                                -- From Opponent's perspective - I am Opponent
                                BackendUtil.convertRoles owner.figures

                            gameFromInviteePerspective =
                                { player1 = { figures = convertMeToOpponent, captures = owner.captures }
                                , player2 = { figures = convertOpponentToMe, captures = invitee.captures }
                                }
                        in
                        [ Lamdera.sendToFrontend owner.playersSessionId
                            (Types.BeToChess <| Types.GameCurrentState gameFromOwnersPerspective)
                        , Lamdera.sendToFrontend invitee.playersSessionId
                            (Types.BeToChess <| Types.GameCurrentState gameFromInviteePerspective)
                        ]
                    )
                |> List.concat
                |> Cmd.batch
            )

        Types.ChessOutMsg_toBackend_SendCaptureUpdate roomId isFromInviteePerspective capture ->
            let
                updateGames : Dict String Types.Game
                updateGames =
                    Dict.update roomId
                        (Maybe.andThen
                            (\rec ->
                                Maybe.map
                                    (\invitee_ ->
                                        if isFromInviteePerspective then
                                            let
                                                updateInvitee =
                                                    { invitee_
                                                        | captures = capture :: invitee_.captures
                                                    }
                                            in
                                            { rec
                                                | invitee = Just updateInvitee
                                            }

                                        else
                                            let
                                                owner_ =
                                                    rec.owner

                                                updateOwner =
                                                    { owner_ | captures = capture :: owner_.captures }
                                            in
                                            { rec
                                                | owner = updateOwner
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
                            gameFromOwnersPerspective =
                                { player1 = { figures = invitee.figures, captures = invitee.captures }
                                , player2 = { figures = owner.figures, captures = owner.captures }
                                }

                            convertOpponentToMe =
                                -- Opponent is looking in game from the first person
                                BackendUtil.convertRoles invitee.figures

                            convertMeToOpponent =
                                -- From Opponent's perspective - I am Opponent
                                BackendUtil.convertRoles owner.figures

                            gameFromInviteePerspective =
                                { player2 = { figures = convertOpponentToMe, captures = invitee.captures }
                                , player1 = { figures = convertMeToOpponent, captures = owner.captures }
                                }
                        in
                        [ Lamdera.sendToFrontend owner.playersSessionId
                            (Types.BeToChess <|
                                Types.GameCurrentState gameFromOwnersPerspective
                            )
                        , Lamdera.sendToFrontend invitee.playersSessionId
                            (Types.BeToChess <|
                                Types.GameCurrentState gameFromInviteePerspective
                            )
                        ]
                    )
                |> List.concat
                |> Cmd.batch
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
