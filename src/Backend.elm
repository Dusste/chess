module Backend exposing (app)

import BackendUtil
import Dict exposing (Dict)
import Lamdera
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
            -- Check if you are in persistent game (maybe you've refreshed browser?)
            case Dict.get roomId model.games of
                Just gameinProgress ->
                    case gameinProgress.invitee of
                        Just invitee_ ->
                            ( model
                            , Cmd.batch <|
                                BackendUtil.toPlayersPerspective
                                    gameinProgress.whoseMove
                                    { owner = gameinProgress.owner, invitee = invitee_ }
                            )

                        Nothing ->
                            ( model, Cmd.none )

                Nothing ->
                    ( { model
                        | games =
                            Dict.insert roomId
                                { owner =
                                    { playersSessionId = sessionId
                                    , figures = startPositionPlayer2
                                    , captures = []
                                    }
                                , invitee = Nothing
                                , whoseMove = Types.PlayersMove Types.White
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
                                updateGames : Dict String Types.Game
                                updateGames =
                                    Dict.update roomId
                                        (Maybe.map
                                            (\game ->
                                                { game
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
                            ( { model | games = updateGames }
                            , BackendUtil.transformGameToSendToFE updateGames <| Types.PlayersMove Types.White
                            )
                    in
                    case BackendUtil.checkForProblems roomId sessionId model updated of
                        Err err ->
                            ( model
                            , Lamdera.sendToFrontend sessionId
                                (Types.BeToChess <| Types.ResponseError err)
                            )

                        Ok updated_ ->
                            updated_
            in
            -- Check if you are in persistent game (maybe you've refreshed browser?)
            case Dict.get roomId model.games of
                Just gameinProgress ->
                    case gameinProgress.invitee of
                        Just invitee_ ->
                            ( model
                            , Cmd.batch <|
                                BackendUtil.toPlayersPerspective
                                    gameinProgress.whoseMove
                                    { owner = gameinProgress.owner, invitee = invitee_ }
                            )

                        Nothing ->
                            -- Not started game should have roomId but not invitee
                            newGameUpdateFlow

                Nothing ->
                    newGameUpdateFlow

        Types.ChessOutMsg_toBackend_SendPositionsUpdate roomId figureColor ( pl1, pl2 ) ->
            let
                whoseMove_ : Types.WhoseMove
                whoseMove_ =
                    case figureColor of
                        Types.Black ->
                            Types.PlayersMove Types.White

                        Types.White ->
                            Types.PlayersMove Types.Black

                updateGames : Dict String Types.Game
                updateGames =
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
                                            { owner_ | figures = BackendUtil.convertRoles pl1 }

                                        updateInvitee : Types.Player
                                        updateInvitee =
                                            { invitee_
                                                | figures = BackendUtil.convertRoles pl2
                                            }
                                    in
                                    { invitee = Just updateInvitee
                                    , owner = updateOwner
                                    , whoseMove = whoseMove_
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
                                            { owner_ | figures = pl2 }

                                        updateInvitee : Types.Player
                                        updateInvitee =
                                            { invitee_
                                                | figures = pl1
                                            }
                                    in
                                    { invitee = Just updateInvitee
                                    , owner = updateOwner
                                    , whoseMove = whoseMove_
                                    }
                                )
            in
            ( { model | games = updateGames }
            , BackendUtil.transformGameToSendToFE updateGames whoseMove_
            )

        Types.ChessOutMsg_toBackend_SendCaptureUpdate roomId figureColor capture ->
            let
                whoseMove_ : Types.WhoseMove
                whoseMove_ =
                    case figureColor of
                        Types.Black ->
                            Types.PlayersMove Types.White

                        Types.White ->
                            Types.PlayersMove Types.Black

                updateGames : Dict String Types.Game
                updateGames =
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
            ( { model | games = updateGames }
            , BackendUtil.transformGameToSendToFE updateGames whoseMove_
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
