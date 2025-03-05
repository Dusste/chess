module Chess exposing (..)

import Components.Button
import Components.InputField
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Html.Extra
import List.Extra
import Maybe.Extra
import OutMsg
import Ports
import Types
import Util


number_of_rows : Int
number_of_rows =
    8


number_of_columns : Int
number_of_columns =
    8


figureElement : String -> Html msg
figureElement txt =
    Html.div
        [ HA.class "font-extrabold" ]
        [ Html.text txt ]


figureToHtml : Maybe Types.Figure -> Html msg
figureToHtml maybeFigure =
    -- TODO should be images
    case maybeFigure of
        Just figure ->
            case figure of
                Types.Rook ->
                    figureElement "ROOK"

                Types.Pawn ->
                    figureElement "PAWN"

                Types.Knight ->
                    figureElement "KNIGHT"

                Types.Bishop ->
                    figureElement "BISHOP"

                Types.King ->
                    figureElement "KING"

                Types.Queen ->
                    figureElement "QUEEN"

        Nothing ->
            Html.text ""


type alias Model =
    Types.ChessModel


init : String -> String -> Types.FigureColor -> ( Model, Cmd Msg )
init roomId urlString figureColor =
    ( initialModel urlString figureColor roomId
    , Cmd.none
    )


initialModel : String -> Types.FigureColor -> String -> Model
initialModel urlString figureColor roomId =
    { player1 = ( [], Types.Inactive )
    , player2 = ( [], Types.Inactive )
    , possibleNextMoves = Types.Idle
    , error = Nothing
    , player1Captures = [] -- TODO Need to send captures from BE for opponent
    , player2Captures = []
    , urlString = urlString
    , figureColor = figureColor
    , roomId = roomId
    , whoseMove = Types.GameIdle
    }



-- MESSAGES


type alias Msg =
    Types.ChessMsg



-- UPDATE


hasInitiatedMove : Types.PossibleNextMove -> Bool
hasInitiatedMove pnm =
    case pnm of
        Types.NextMove _ _ ->
            True

        Types.Idle ->
            False


getPossitionOfActiveFigure : Types.PossibleNextMove -> Maybe Types.Field
getPossitionOfActiveFigure pnm =
    case pnm of
        Types.NextMove { x, y } _ ->
            Just (Types.Field x y)

        Types.Idle ->
            Nothing


update : Msg -> Model -> ( Model, List OutMsg.OutMsg, Cmd Msg )
update msg model =
    case msg of
        Types.NoOp ->
            ( model, [], Cmd.none )

        Types.CopyRoomUrl ->
            ( model, [], Ports.copyUrlToClipboard <| model.urlString ++ "?invite=true" )

        Types.InitiateMove desiredOrCurrentPosition ->
            case desiredOrCurrentPosition.figure of
                Just figure ->
                    if hasInitiatedMove model.possibleNextMoves then
                        -- Move was already initialized - RESET
                        ( { model
                            | possibleNextMoves = Types.Idle
                            , error = Nothing
                          }
                        , []
                        , Cmd.none
                        )

                    else
                        let
                            nextMoves : Types.NextMoves
                            nextMoves =
                                Util.getNextPossibleMoves
                                    figure
                                    (Types.Field
                                        desiredOrCurrentPosition.x
                                        desiredOrCurrentPosition.y
                                    )
                                    model.player1
                                    model.player2

                            cannotMoveOrCapture : Bool
                            cannotMoveOrCapture =
                                -- TODO if I cannot move it doesn't mean I cannot capture !
                                List.concat
                                    [ nextMoves.potentialMoves
                                    , nextMoves.potentialCaptures
                                    ]
                                    |> List.length
                                    |> (==) 0
                        in
                        -- It's IDLE -> Check if someone is blocking your move
                        if cannotMoveOrCapture then
                            -- Ilegal move -> Your other figure is preventing you to move
                            ( { model | error = Just "Your other figure is preventing you to move with this figure" }
                            , []
                            , Cmd.none
                            )

                        else
                            -- It's IDLE -> Choosing figure you want to move
                            ( { model
                                | possibleNextMoves =
                                    Types.NextMove
                                        { x = desiredOrCurrentPosition.x
                                        , y = desiredOrCurrentPosition.y
                                        }
                                        nextMoves
                                , error = Nothing
                              }
                            , []
                            , Cmd.none
                            )

                Nothing ->
                    case model.possibleNextMoves of
                        Types.NextMove currentField nextMoves ->
                            -- Alright ! Maybe we can move figure, let's check if selected field is among allowed fields !
                            let
                                isOkToMove : Bool
                                isOkToMove =
                                    nextMoves.potentialMoves
                                        |> List.any
                                            (\{ x, y } ->
                                                Util.isEqualPosition x desiredOrCurrentPosition.x y desiredOrCurrentPosition.y
                                            )

                                updated : ( Model, List OutMsg.OutMsg, Cmd Msg )
                                updated =
                                    if isOkToMove then
                                        -- Alright, good to go !
                                        let
                                            updatePlayer2 : ( List Types.FigureState, Types.PlayerStatus )
                                            updatePlayer2 =
                                                ( List.map
                                                    (\( pt, fs ) ->
                                                        ( pt
                                                        , { fs
                                                            | moves =
                                                                if List.head fs.moves == Just currentField then
                                                                    { x = desiredOrCurrentPosition.x
                                                                    , y = desiredOrCurrentPosition.y
                                                                    }
                                                                        :: fs.moves

                                                                else
                                                                    fs.moves
                                                          }
                                                        )
                                                    )
                                                    (Tuple.first model.player2)
                                                , Tuple.second model.player2
                                                )
                                        in
                                        ( { model
                                            | player2 = updatePlayer2
                                            , possibleNextMoves = Types.Idle
                                          }
                                        , [ OutMsg.SendPositionsUpdate model.roomId model.figureColor ( Tuple.first model.player1, Tuple.first updatePlayer2 )
                                          ]
                                        , Cmd.none
                                        )

                                    else
                                        -- Bummer, selected figure can't move to that field!
                                        ( { model
                                            | error = Just "Selected figure can't move to that field"
                                          }
                                        , []
                                        , Cmd.none
                                        )
                            in
                            updated

                        Types.Idle ->
                            -- Move wasn't initialized - You need to choose figure first !
                            ( { model | error = Just "First choose figure you want to play with" }
                            , []
                            , Cmd.none
                            )

        Types.InitiateCapture positionToCapture ->
            case model.possibleNextMoves of
                Types.NextMove attackerCurrentField { potentialCaptures } ->
                    let
                        positionToCaptureFound : Maybe ( Types.Figure, Types.Field )
                        positionToCaptureFound =
                            -- Try to find desired field within potential captures fields
                            potentialCaptures
                                |> List.Extra.find
                                    (\f ->
                                        Util.isEqualPosition f.x positionToCapture.x f.y positionToCapture.y
                                    )
                                |> Maybe.map (\f -> ( positionToCapture.figure, f ))

                        updatedPlayer1 : ( List Types.FigureState, Types.PlayerStatus )
                        updatedPlayer1 =
                            ( Tuple.first model.player1
                                |> List.filter
                                    (\( pt, { figure, moves } ) ->
                                        case ( positionToCaptureFound, moves |> List.head ) of
                                            ( Just ( _, captureField ), Just field ) ->
                                                not <| Util.isEqualPosition field.x captureField.x field.y captureField.y

                                            _ ->
                                                True
                                    )
                            , Tuple.second model.player1
                            )

                        updatedPlayer2 : ( List Types.FigureState, Types.PlayerStatus )
                        updatedPlayer2 =
                            ( Tuple.first model.player2
                                |> List.map
                                    (\( pt, { figure, moves } ) ->
                                        case ( List.head moves, positionToCaptureFound ) of
                                            ( Just currentPositon, Just ( _, positionToCaptureFound_ ) ) ->
                                                if Util.isEqualPosition currentPositon.x attackerCurrentField.x currentPositon.y attackerCurrentField.y then
                                                    ( pt
                                                    , { figure = figure
                                                      , moves = { x = positionToCaptureFound_.x, y = positionToCaptureFound_.y } :: moves
                                                      }
                                                    )

                                                else
                                                    ( pt, { figure = figure, moves = moves } )

                                            _ ->
                                                ( pt, { figure = figure, moves = moves } )
                                    )
                            , Tuple.second model.player2
                            )
                    in
                    ( { model
                        | possibleNextMoves = Types.Idle
                        , player1 = updatedPlayer1
                        , player2 = updatedPlayer2
                        , player2Captures =
                            case positionToCaptureFound of
                                Just captureFigureState ->
                                    captureFigureState :: model.player2Captures

                                Nothing ->
                                    model.player2Captures
                      }
                    , [ case positionToCaptureFound of
                            Just capture_ ->
                                [ OutMsg.SendCaptureUpdate model.roomId model.figureColor capture_
                                , OutMsg.SendPositionsUpdate model.roomId model.figureColor ( Tuple.first updatedPlayer1, Tuple.first updatedPlayer2 )
                                ]

                            Nothing ->
                                []
                      ]
                        |> List.concat
                    , Cmd.none
                    )

                Types.Idle ->
                    ( { model | error = Just "You need to choose figure first" }
                    , []
                    , Cmd.none
                    )

        Types.FeToChess_GotGameData { player1, player2 } whoseMove ->
            let
                _ =
                    Debug.log "UPDATE FROM BE" ( player1.status, player2.status )
            in
            ( { model
                | player1 = ( player1.figures, player1.status )
                , player2 = ( player2.figures, player2.status )
                , player1Captures = player1.captures
                , player2Captures = player2.captures
                , whoseMove = whoseMove
              }
            , []
            , Cmd.none
            )

        Types.NotYourMove ->
            -- TODO should be a toster notification, check todo list
            ( { model | error = Just "It's not your move buddy" }, [], Cmd.none )

        Types.AbsentOpponent ->
            -- TODO should be a toster notification, check todo list
            ( { model | error = Just "Your opponent is currently absent, you can't make a move" }
            , []
            , Cmd.none
            )


findFigureOnThatField : Int -> Int -> List Types.FigureState -> Maybe Types.FigureState
findFigureOnThatField x1 y1 lst =
    lst
        |> List.Extra.find
            (\( _, { moves } ) ->
                List.head moves
                    |> Maybe.map (\{ x, y } -> Util.isEqualPosition x x1 y y1)
                    |> Maybe.withDefault False
            )


coordinatesToFigure : Int -> Int -> List Types.FigureState -> Maybe Types.Figure
coordinatesToFigure x1 y1 lst =
    lst
        |> findFigureOnThatField x1 y1
        |> Maybe.map (\( _, fs ) -> fs.figure)


isMyFigure : Int -> Int -> List Types.FigureState -> Bool
isMyFigure x y lst =
    findFigureOnThatField x y lst
        |> Maybe.Extra.isJust


viewField : Model -> Int -> Int -> Html Msg
viewField model xIndex yIndex =
    let
        letter : String
        letter =
            Util.indexToLetter model.figureColor xIndex

        maybeFigure : Maybe Types.Figure
        maybeFigure =
            coordinatesToFigure xIndex yIndex (List.concat [ Tuple.first model.player1, Tuple.first model.player2 ])

        figureEl : Html Msg
        figureEl =
            figureToHtml maybeFigure

        isPotenitalMove : Bool
        isPotenitalMove =
            case model.possibleNextMoves of
                Types.NextMove _ nextMoves ->
                    nextMoves.potentialMoves
                        |> List.filter (\{ x, y } -> Util.isEqualPosition xIndex x yIndex y)
                        |> List.length
                        |> (/=) 0

                Types.Idle ->
                    False

        isMyFigure_ : Bool
        isMyFigure_ =
            isMyFigure xIndex yIndex (Tuple.first model.player2)

        isPotenitalCapture : Bool
        isPotenitalCapture =
            case model.possibleNextMoves of
                Types.NextMove _ nextMoves ->
                    nextMoves.potentialCaptures
                        |> List.Extra.find
                            (\{ x, y } -> Util.isEqualPosition xIndex x yIndex y)
                        |> Maybe.Extra.isJust

                Types.Idle ->
                    False

        position : Types.Position
        position =
            { figure = maybeFigure, x = xIndex, y = yIndex }
    in
    Html.div
        [ HE.onClick <|
            -- TODO make it smarter
            case model.whoseMove of
                Types.PlayersMove figureColor ->
                    case figureColor of
                        Types.White ->
                            if Tuple.second model.player2 == Types.Freezed then
                                Types.AbsentOpponent

                            else if model.figureColor == Types.White then
                                if isMyFigure_ || maybeFigure == Nothing then
                                    Types.InitiateMove position

                                else
                                    case maybeFigure of
                                        Just fg ->
                                            Types.InitiateCapture { figure = fg, x = position.x, y = position.y }

                                        Nothing ->
                                            Types.NoOp

                            else
                                Types.NotYourMove

                        Types.Black ->
                            if Tuple.second model.player2 == Types.Freezed then
                                Types.AbsentOpponent

                            else if model.figureColor == Types.Black then
                                if isMyFigure_ || maybeFigure == Nothing then
                                    Types.InitiateMove position

                                else
                                    case maybeFigure of
                                        Just fg ->
                                            Types.InitiateCapture { figure = fg, x = position.x, y = position.y }

                                        Nothing ->
                                            Types.NoOp

                            else
                                Types.NotYourMove

                Types.GameIdle ->
                    Types.NoOp
        , HA.class <|
            "relative cursor-pointer flex w-[100px] h-[100px]"
                ++ (if isPotenitalMove then
                        " bg-green-100"

                    else if isPotenitalCapture then
                        " bg-red-500"

                    else
                        ""
                   )
                ++ (case getPossitionOfActiveFigure model.possibleNextMoves of
                        Just { x, y } ->
                            if Util.isEqualPosition x xIndex y yIndex then
                                " border-2 border-pink-400"

                            else
                                " border border-white"

                        Nothing ->
                            " border border-white"
                   )
        ]
        [ Html.div
            []
            [ figureEl ]
        , if yIndex == 8 then
            Html.div
                [ HA.class "absolute bottom-[-30px] left-[45%]" ]
                [ Html.text letter ]

          else
            Html.text ""
        ]


viewRows : Model -> Int -> Html Msg
viewRows model colNum =
    let
        sideTableNum : Int
        sideTableNum =
            case model.figureColor of
                Types.Black ->
                    colNum

                Types.White ->
                    9 - colNum
    in
    Html.div
        [ HA.class "flex flex-row" ]
        (List.append
            (List.repeat number_of_rows (viewField model)
                |> List.indexedMap
                    (\i el ->
                        el (i + 1) colNum
                    )
            )
            [ Html.div
                [ HA.class "flex self-center" ]
                [ Html.text <| String.fromInt sideTableNum ]
            ]
        )


viewColumns : Model -> Html Msg
viewColumns model =
    Html.div
        [ HA.class "flex flex-col border border-white" ]
        (List.repeat number_of_columns (viewRows model)
            |> List.indexedMap
                (\i el -> el (i + 1))
        )


viewStatus : Model -> Html Msg
viewStatus model =
    Html.div
        [ HA.class "border flex w-[100px] m-2 p-2" ]
        [ case Tuple.second model.player2 of
            Types.Active ->
                Html.div
                    [ HA.class "flex items-center gap-1" ]
                    [ Html.div
                        [ HA.class "rounded-full bg-green-500 w-[8px] h-[8px]" ]
                        []
                    , Html.p [] [ Html.text "Active" ]
                    ]

            Types.Inactive ->
                Html.div
                    [ HA.class "flex items-center gap-1" ]
                    [ Html.div
                        [ HA.class "rounded-full bg-red-500 w-[8px] h-[8px]" ]
                        []
                    , Html.p [] [ Html.text "Inactive" ]
                    ]

            Types.Freezed ->
                Html.div
                    [ HA.class "flex items-center gap-1" ]
                    [ Html.div
                        [ HA.class "rounded-full bg-yellow-500 w-[8px] h-[8px]" ]
                        []
                    , Html.p [] [ Html.text "Freezed" ]
                    ]
        ]


view : Model -> Html Msg
view model =
    Html.div
        [ HA.class "" ]
        [ Html.Extra.viewIf (model.whoseMove /= Types.GameIdle)
            (viewStatus model)
        , case model.figureColor of
            Types.Black ->
                Html.div
                    [ HA.class "flex flex-col mb-4" ]
                    [ Html.h1
                        [ HA.class "text-4xl m-10 text-center" ]
                        [ Html.text "Welcome to game"
                        ]
                    , case model.whoseMove of
                        Types.GameIdle ->
                            Html.text ""

                        -- Types.StartGame ->
                        --     Html.p
                        --         [ HA.class "text-center" ]
                        --         [ Html.text "Thanks for accepting invitation ! Its White's move" ]
                        Types.PlayersMove figureColor ->
                            case figureColor of
                                Types.Black ->
                                    Html.p
                                        [ HA.class "text-center" ]
                                        [ Html.text "Black's move" ]

                                Types.White ->
                                    Html.p
                                        [ HA.class "text-center" ]
                                        [ Html.text "White's move" ]
                    ]

            Types.White ->
                -- TODO I see some annoying jumps on refresh
                Html.div
                    [ HA.class "flex flex-col mb-4" ]
                    [ case model.whoseMove of
                        Types.GameIdle ->
                            Html.h1
                                [ HA.class "text-4xl m-10 text-center" ]
                                [ Html.text "You are about to start a game with friend" ]

                        -- Types.StartGame ->
                        --     "Let the game begin ! White's move"
                        Types.PlayersMove figureColor ->
                            viewWhoseMove figureColor
                    , Html.Extra.viewIf (model.whoseMove == Types.GameIdle)
                        (Html.div [ HA.class "flex flex-col" ]
                            [ Html.p
                                [ HA.class "text-center" ]
                                [ Html.text "Send invite to your friend" ]
                            , Html.div
                                [ HA.class "flex self-center" ]
                                [ Components.InputField.view
                                    |> Components.InputField.withValue (model.urlString ++ "?invite=true")
                                    |> Components.InputField.withReadOnly
                                    |> Components.InputField.withDisable False
                                    |> Components.InputField.withError []
                                    |> Components.InputField.withExtraText (Components.InputField.Placeholder "Email")
                                    |> Components.InputField.toHtml
                                , Components.Button.view
                                    |> Components.Button.withText "Copy"
                                    |> Components.Button.withMsg Types.CopyRoomUrl
                                    |> Components.Button.withDisabled False
                                    |> Components.Button.withPrimaryStyle
                                    |> Components.Button.toHtml
                                ]
                            ]
                        )
                    ]
        , case model.error of
            Just err ->
                Html.p
                    [ HA.class "absolute w-[100%] top-0 bg-red-500 text-white p-3 text-center" ]
                    [ Html.text err ]

            Nothing ->
                Html.text ""
        , Html.Extra.viewIf (not <| List.isEmpty (List.concat [ Tuple.first model.player1, Tuple.first model.player2 ]))
            (Html.div [ HA.class "flex justify-center" ]
                [ viewColumns model ]
            )
        , Html.Extra.viewIf
            ([ model.player1Captures, model.player2Captures ]
                |> List.concat
                |> List.isEmpty
                |> not
            )
            (capturesView model)
        ]


viewWhoseMove : Types.FigureColor -> Html Msg
viewWhoseMove figureColor =
    case figureColor of
        Types.Black ->
            Html.p
                [ HA.class "text-center" ]
                [ Html.text "Black's move" ]

        Types.White ->
            Html.p
                [ HA.class "text-center" ]
                [ Html.text "White's move" ]


capturesView : Model -> Html Msg
capturesView model =
    {-
       TODO logic is too complex and its hard to follow who is who:
       make improvement in the future
    -}
    Html.div
        []
        [ case model.figureColor of
            Types.Black ->
                Html.div
                    [ HA.class "flex gap-2" ]
                    [ Html.div
                        [ HA.class "border border-white p-2" ]
                        [ Html.h3
                            []
                            [ Html.text "White" ]
                        , Html.ul
                            []
                            (List.map
                                (\( figure, lastHeldField ) ->
                                    Html.li
                                        []
                                        [ figureToHtml (Just figure)
                                        , Html.p []
                                            [ Util.fieldToSpot Types.White lastHeldField
                                                |> Html.text
                                            ]
                                        ]
                                )
                                model.player1Captures
                            )
                        ]
                    , Html.div
                        [ HA.class "border border-white p-2]" ]
                        [ Html.h3
                            []
                            [ Html.text "Black" ]
                        , Html.ul
                            []
                            (List.map
                                (\( figure, lastHeldField ) ->
                                    Html.li
                                        []
                                        [ figureToHtml (Just figure)
                                        , Html.p []
                                            [ Util.fieldToSpot model.figureColor lastHeldField
                                                |> Html.text
                                            ]
                                        ]
                                )
                                model.player2Captures
                            )
                        ]
                    ]

            Types.White ->
                Html.div
                    [ HA.class "flex gap-2" ]
                    [ Html.div
                        [ HA.class "border border-white p-2" ]
                        [ Html.h3
                            []
                            [ Html.text "White" ]
                        , Html.ul
                            []
                            (List.map
                                (\( figure, lastHeldField ) ->
                                    Html.li
                                        []
                                        [ figureToHtml (Just figure)
                                        , Html.p []
                                            [ Util.fieldToSpot model.figureColor lastHeldField
                                                |> Html.text
                                            ]
                                        ]
                                )
                                model.player2Captures
                            )
                        ]
                    , Html.div
                        [ HA.class "border border-white p-2]" ]
                        [ Html.h3
                            []
                            [ Html.text "Black" ]
                        , Html.ul
                            []
                            (List.map
                                (\( figure, lastHeldField ) ->
                                    Html.li
                                        []
                                        [ figureToHtml (Just figure)
                                        , Html.p []
                                            [ Util.fieldToSpot Types.Black lastHeldField
                                                |> Html.text
                                            ]
                                        ]
                                )
                                model.player1Captures
                            )
                        ]
                    ]
        ]
