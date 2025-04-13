module Backend exposing (app)

import BackendUtil
import Dict exposing (Dict)
import Dict.Extra
import Lamdera
import List.Extra
import Maybe.Extra
import Tuple2
import Types


type alias Model =
    Types.BackendModel



{-
   - REAL STARTING POSITIONS -
   startPositionPlayer1 : List FigureState
   startPositionPlayer1 =
       [ { figure = Rook, moves = [ { x = 1, y = 1 } ] }
       , { figure = Rook, moves = [ { x = 8, y = 1 } ] }
       , { figure = Pawn, moves = [ { x = 1, y = 2 } ] }
       , { figure = Pawn, moves = [ { x = 2, y = 2 } ] }
       , { figure = Pawn, moves = [ { x = 3, y = 2 } ] }
       , { figure = Pawn, moves = [ { x = 4, y = 2 } ] }
       , { figure = Pawn, moves = [ { x = 5, y = 2 } ] }
       , { figure = Pawn, moves = [ { x = 6, y = 2 } ] }
       , { figure = Pawn, moves = [ { x = 7, y = 2 } ] }
       , { figure = Pawn, moves = [ { x = 8, y = 2 } ] }
       , { figure = Knight, moves = [ { x = 2, y = 1 } ] }
       , { figure = Knight, moves = [ { x = 7, y = 1 } ] }
       , { figure = Bishop, moves = [ { x = 3, y = 1 } ] }
       , { figure = Bishop, moves = [ { x = 6, y = 1 } ] }
       , { figure = King, moves = [ { x = 5, y = 1 } ] }
       , { figure = Queen, moves = [ { x = 4, y = 1 } ] }
       ]
   {-


   -}
   startPositionPlayer2 : List FigureState
   startPositionPlayer2 =
       [ { figure = Rook, moves = [ { x = 1, y = 8 } ] }
       , { figure = Rook, moves = [ { x = 8, y = 8 } ] }
       , { figure = Types.Pawn, moves = [ { x = 1, y = 7 } ] }
       , { figure = Types.Pawn, moves = [ { x = 2, y = 7 } ] }
       , { figure = Types.Pawn, moves = [ { x = 3, y = 7 } ] }
       , { figure = Types.Pawn, moves = [ { x = 4, y = 7 } ] }
       , { figure = Types.Pawn, moves = [ { x = 5, y = 7 } ] }
       , { figure = Types.Pawn, moves = [ { x = 6, y = 7 } ] }
       , { figure = Types.Pawn, moves = [ { x = 7, y = 7 } ] }
       , { figure = Types.Pawn, moves = [ { x = 8, y = 7 } ] }
       , { figure = Knight, moves = [ { x = 2, y = 8 } ] }
       , { figure = Knight, moves = [ { x = 7, y = 8 } ] }
       , { figure = Bishop, moves = [ { x = 3, y = 8 } ] }
       , { figure = Bishop, moves = [ { x = 6, y = 8 } ] }
       , { figure = King, moves = [ { x = 5, y = 8 } ] }
       , { figure = Queen, moves = [ { x = 4, y = 8 } ] }
       ]


-}


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
        games = Dict.empty
      }
    , Cmd.none
    )


update : Types.BackendMsg -> Model -> ( Model, Cmd Types.BackendMsg )
update msg model =
    case msg of
        Types.UserDisconnected sessionId clientId ->
            let
                roomIdsInvitee : List { roomId : String, isOwner : Bool }
                roomIdsInvitee =
                    -- filter rooms where this sessionId has active game and its invitee
                    model.games
                        |> Dict.filter
                            (\roomId { owner, invitee } ->
                                Maybe.map
                                    (\inviteeAsPlayer ->
                                        inviteeAsPlayer.playersSessionId == sessionId
                                    )
                                    invitee
                                    |> Maybe.withDefault False
                            )
                        |> Dict.toList
                        |> List.map (\t -> { roomId = Tuple.first t, isOwner = False })

                roomIdsOwner : List { roomId : String, isOwner : Bool }
                roomIdsOwner =
                    -- filter rooms where this sessionId has active game and its owner
                    model.games
                        |> Dict.filter
                            (\roomId { owner, invitee } ->
                                owner.playersSessionId == sessionId
                            )
                        |> Dict.toList
                        |> List.map (\t -> { roomId = Tuple.first t, isOwner = True })

                updatedGames : Dict String Types.Game
                updatedGames =
                    -- if user is leaving room where he is owner/invitee, we need to set either Frozen or Inactive
                    List.concat [ roomIdsInvitee, roomIdsOwner ]
                        |> List.foldr
                            (\{ roomId, isOwner } sum ->
                                sum
                                    |> Dict.update roomId
                                        (Maybe.andThen
                                            (\({ owner, invitee } as game) ->
                                                let
                                                    updateInvitee =
                                                        Maybe.map
                                                            (\invitee_ ->
                                                                { invitee_
                                                                    | status =
                                                                        case ( isOwner, invitee_.status ) of
                                                                            ( True, Types.Active ) ->
                                                                                Types.Freezed

                                                                            ( False, Types.Active ) ->
                                                                                Types.Inactive

                                                                            _ ->
                                                                                invitee_.status
                                                                }
                                                            )
                                                            invitee

                                                    updateOwner =
                                                        { owner
                                                            | status =
                                                                case ( isOwner, owner.status ) of
                                                                    ( True, Types.Active ) ->
                                                                        Types.Inactive

                                                                    ( False, Types.Active ) ->
                                                                        Types.Freezed

                                                                    _ ->
                                                                        owner.status
                                                        }
                                                in
                                                Just { game | owner = updateOwner, invitee = updateInvitee }
                                            )
                                        )
                            )
                            model.games
            in
            ( { model | games = updatedGames }
            , List.concat
                [ roomIdsInvitee, roomIdsOwner ]
                |> List.map
                    (\{ roomId } ->
                        [ Lamdera.sendToFrontend
                            sessionId
                            (Types.BeToChess <|
                                Types.BeToChessResponse <|
                                    Types.Notification "Your opponent has left the game"
                            )
                        , BackendUtil.transformGameToSendToFE
                            updatedGames
                            (BackendUtil.getWhoseMoveMaybeWhite roomId updatedGames)
                        ]
                    )
                |> List.concat
                |> Cmd.batch
            )

        Types.UserConnected sessionId clientId ->
            -- TODO issue with inactive game - user will get that he is inactive, but its actually there
            let
                _ =
                    Debug.log "User Connected" ( sessionId, clientId )
            in
            ( model
            , Cmd.none
            )


updateFromFrontend : Lamdera.SessionId -> Lamdera.ClientId -> Types.ToBackend -> Model -> ( Model, Cmd Types.BackendMsg )
updateFromFrontend sessionId clientId msg model =
    case msg of
        Types.NoOpToBackend ->
            ( model, Cmd.none )

        Types.InitiateGame roomId ->
            -- Check if you are in persistent game (maybe invitee've refreshed browser or left game and then re-joined?)
            case Dict.get roomId model.games of
                Just gameInProgress ->
                    if gameInProgress.owner.playersSessionId == sessionId then
                        case gameInProgress.invitee of
                            Just invitee_ ->
                                let
                                    owner_ : Types.Player
                                    owner_ =
                                        gameInProgress.owner

                                    updateStatus : Types.PlayerStatus
                                    updateStatus =
                                        case invitee_.status of
                                            Types.Inactive ->
                                                Types.Freezed

                                            Types.Freezed ->
                                                Types.Active

                                            _ ->
                                                invitee_.status

                                    updateOwner : Types.Player
                                    updateOwner =
                                        { owner_ | status = updateStatus }

                                    updateInvitee : Types.Player
                                    updateInvitee =
                                        { invitee_ | status = updateStatus }

                                    updatedGames : Dict String Types.Game
                                    updatedGames =
                                        Dict.update roomId
                                            (Maybe.map
                                                (\game ->
                                                    { game
                                                        | owner = updateOwner
                                                        , invitee = Just updateInvitee
                                                    }
                                                )
                                            )
                                            model.games
                                in
                                ( { model | games = updatedGames }
                                , Cmd.batch <|
                                    List.concat <|
                                        [ BackendUtil.toPlayersPerspective
                                            gameInProgress.whoseMove
                                            { owner = updateOwner
                                            , invitee = updateInvitee
                                            , whoWon = gameInProgress.whoWon
                                            }
                                        , [ Lamdera.sendToFrontend
                                                updateInvitee.playersSessionId
                                                (Types.BeToChess <|
                                                    Types.BeToChessResponse <|
                                                        Types.Notification "Your opponent has re-joined the game"
                                                )
                                          ]
                                        ]
                                )

                            Nothing ->
                                ( model
                                , Lamdera.sendToFrontend sessionId
                                    (Types.BeToChess <| Types.BeToChessResponse <| Types.Notification "Your opponent never accepted invitation")
                                )

                    else
                        ( model
                        , Lamdera.sendToFrontend sessionId
                            (Types.BeToChess <| Types.BeToChessResponse <| Types.Error "You are trying to opt-in into a game you are not invited")
                        )

                Nothing ->
                    ( { model
                        | games =
                            Dict.insert roomId
                                { owner =
                                    { playersSessionId = sessionId
                                    , figures = startPositionPlayer2
                                    , captures = []
                                    , status = Types.Active
                                    , isInChess = False
                                    }
                                , invitee = Nothing
                                , whoseMove = Types.PlayersMove Types.White
                                , whoWon = Nothing
                                }
                                model.games
                      }
                    , Cmd.none
                    )

        Types.JoinGame roomId ->
            let
                newGameUpdateFlow : ( Model, Cmd Types.BackendMsg )
                newGameUpdateFlow =
                    let
                        updated : ( Model, Cmd Types.BackendMsg )
                        updated =
                            let
                                updatedGames : Dict String Types.Game
                                updatedGames =
                                    Dict.update roomId
                                        (Maybe.map
                                            (\game ->
                                                { game
                                                    | invitee =
                                                        Just
                                                            { playersSessionId = sessionId
                                                            , figures = startPositionPlayer1
                                                            , captures = []
                                                            , status = Types.Active
                                                            , isInChess = False
                                                            }
                                                }
                                            )
                                        )
                                        model.games
                            in
                            ( { model | games = updatedGames }
                            , BackendUtil.transformGameToSendToFE updatedGames (BackendUtil.getWhoseMoveMaybeWhite roomId updatedGames)
                            )
                    in
                    case BackendUtil.checkForProblems roomId sessionId model updated of
                        Err err ->
                            ( model
                            , Lamdera.sendToFrontend sessionId
                                (Types.BeToChess <| Types.BeToChessResponse <| Types.Error err)
                            )

                        Ok updated_ ->
                            updated_
            in
            -- Check if you are in persistent game (maybe invitee've refreshed browser or left game and then re-joined?)
            case Dict.get roomId model.games of
                Just gameInProgress ->
                    case gameInProgress.invitee of
                        Just invitee_ ->
                            if invitee_.playersSessionId == sessionId then
                                let
                                    updateStatus : Types.PlayerStatus
                                    updateStatus =
                                        case gameInProgress.owner.status of
                                            Types.Inactive ->
                                                Types.Freezed

                                            Types.Freezed ->
                                                Types.Active

                                            _ ->
                                                gameInProgress.owner.status

                                    updateInvitee : Types.Player
                                    updateInvitee =
                                        { invitee_ | status = updateStatus }

                                    owner_ : Types.Player
                                    owner_ =
                                        gameInProgress.owner

                                    updateOwner : Types.Player
                                    updateOwner =
                                        { owner_ | status = updateStatus }

                                    updatedGames : Dict String Types.Game
                                    updatedGames =
                                        Dict.update roomId
                                            (Maybe.map
                                                (\game ->
                                                    { game
                                                        | invitee = Just updateInvitee
                                                        , owner = updateOwner
                                                    }
                                                )
                                            )
                                            model.games
                                in
                                ( { model | games = updatedGames }
                                , Cmd.batch <|
                                    List.concat <|
                                        [ BackendUtil.toPlayersPerspective
                                            gameInProgress.whoseMove
                                            { owner = updateOwner, invitee = updateInvitee, whoWon = gameInProgress.whoWon }
                                        , [ Lamdera.sendToFrontend updateOwner.playersSessionId
                                                (Types.BeToChess <|
                                                    Types.BeToChessResponse <|
                                                        Types.Notification "Your opponent has re-joined the game"
                                                )
                                          ]
                                        ]
                                )

                            else
                                ( model
                                , Lamdera.sendToFrontend sessionId
                                    (Types.BeToChess <| Types.BeToChessResponse <| Types.Error "You are trying to opt-in into a game you are not invited")
                                )

                        Nothing ->
                            -- Not started game should have roomId but not invitee
                            newGameUpdateFlow

                Nothing ->
                    newGameUpdateFlow

        Types.ChessOutMsg_toBackend_SendPositionsUpdate roomId figureColor ( pl1, pl2 ) haveYouGaveChessToOpponent ->
            let
                whoseMove_ : Types.WhoseMove
                whoseMove_ =
                    BackendUtil.switchMove figureColor

                updatedGames : Dict String Types.Game
                updatedGames =
                    case figureColor of
                        Types.Black ->
                            BackendUtil.updateGames
                                roomId
                                model.games
                                (\game invitee_ ->
                                    let
                                        owner_ : Types.Player
                                        owner_ =
                                            game.owner

                                        updateOwner : Types.Player
                                        updateOwner =
                                            { owner_
                                                | figures = BackendUtil.convertRoles pl1
                                                , isInChess = haveYouGaveChessToOpponent
                                            }

                                        updateInvitee : Types.Player
                                        updateInvitee =
                                            { invitee_
                                                | figures = BackendUtil.convertRoles pl2
                                            }
                                    in
                                    { invitee = Just updateInvitee
                                    , owner = updateOwner
                                    , whoseMove = whoseMove_
                                    , whoWon = Nothing
                                    }
                                )

                        Types.White ->
                            BackendUtil.updateGames
                                roomId
                                model.games
                                (\game invitee_ ->
                                    let
                                        owner_ : Types.Player
                                        owner_ =
                                            game.owner

                                        updateOwner : Types.Player
                                        updateOwner =
                                            { owner_
                                                | figures = pl2
                                            }

                                        updateInvitee : Types.Player
                                        updateInvitee =
                                            { invitee_
                                                | figures = pl1
                                                , isInChess = haveYouGaveChessToOpponent
                                            }
                                    in
                                    { invitee = Just updateInvitee
                                    , owner = updateOwner
                                    , whoseMove = whoseMove_
                                    , whoWon = Nothing
                                    }
                                )
            in
            ( { model | games = updatedGames }
            , BackendUtil.transformGameToSendToFE updatedGames whoseMove_
            )

        Types.ChessOutMsg_toBackend_SendCaptureUpdate roomId figureColor capture ->
            let
                whoseMove_ : Types.WhoseMove
                whoseMove_ =
                    BackendUtil.switchMove figureColor

                updatedGames : Dict String Types.Game
                updatedGames =
                    BackendUtil.updateGames
                        roomId
                        model.games
                        (\game invitee_ ->
                            case figureColor of
                                Types.Black ->
                                    let
                                        updateInvitee : Types.Player
                                        updateInvitee =
                                            { invitee_
                                                | captures = capture :: invitee_.captures
                                            }
                                    in
                                    { game
                                        | invitee = Just updateInvitee
                                        , whoseMove = whoseMove_
                                    }

                                Types.White ->
                                    let
                                        owner_ : Types.Player
                                        owner_ =
                                            game.owner

                                        updateOwner : Types.Player
                                        updateOwner =
                                            { owner_ | captures = capture :: owner_.captures }
                                    in
                                    { game
                                        | owner = updateOwner
                                        , whoseMove = whoseMove_
                                    }
                        )
            in
            ( { model | games = updatedGames }
            , BackendUtil.transformGameToSendToFE updatedGames whoseMove_
            )

        Types.ChessOutMsg_toBackend_IsGameOver roomId figureColorWhoWon ->
            case Dict.get roomId model.games of
                Just gameInProgress ->
                    case gameInProgress.invitee of
                        Just invitee ->
                            let
                                ownerId : Lamdera.SessionId
                                ownerId =
                                    gameInProgress.owner.playersSessionId

                                inviteeId : Lamdera.SessionId
                                inviteeId =
                                    invitee.playersSessionId

                                updatedGames : Dict String Types.Game
                                updatedGames =
                                    Dict.update roomId
                                        (Maybe.map
                                            (\game ->
                                                { game
                                                    | whoWon = Just figureColorWhoWon
                                                }
                                            )
                                        )
                                        model.games
                            in
                            ( { model | games = updatedGames }
                            , [ Lamdera.sendToFrontend ownerId
                                    (Types.BeToChess <| Types.BeToChessResponse <| Types.GameEnded figureColorWhoWon)
                              , Lamdera.sendToFrontend inviteeId
                                    (Types.BeToChess <| Types.BeToChessResponse <| Types.GameEnded figureColorWhoWon)
                              , BackendUtil.transformGameToSendToFE
                                    updatedGames
                                    Types.GameIdle
                              ]
                                |> Cmd.batch
                            )

                        Nothing ->
                            ( model, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )


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
