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



-- startPositionPlayer1 : List FigureState
-- startPositionPlayer1 =
--     [ { figure = Rook, moves = [ { x = 1, y = 1 } ] }
--     , { figure = Rook, moves = [ { x = 8, y = 1 } ] }
--     , { figure = Pawn, moves = [ { x = 1, y = 2 } ] }
--     , { figure = Pawn, moves = [ { x = 2, y = 2 } ] }
--     , { figure = Pawn, moves = [ { x = 3, y = 2 } ] }
--     , { figure = Pawn, moves = [ { x = 4, y = 2 } ] }
--     , { figure = Pawn, moves = [ { x = 5, y = 2 } ] }
--     , { figure = Pawn, moves = [ { x = 6, y = 2 } ] }
--     , { figure = Pawn, moves = [ { x = 7, y = 2 } ] }
--     , { figure = Pawn, moves = [ { x = 8, y = 2 } ] }
--     , { figure = Knight, moves = [ { x = 2, y = 1 } ] }
--     , { figure = Knight, moves = [ { x = 7, y = 1 } ] }
--     , { figure = Bishop, moves = [ { x = 3, y = 1 } ] }
--     , { figure = Bishop, moves = [ { x = 6, y = 1 } ] }
--     , { figure = King, moves = [ { x = 5, y = 1 } ] }
--     , { figure = Queen, moves = [ { x = 4, y = 1 } ] }
--     ]
-- {-


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



-- -}
-- startPositionPlayer2 : List FigureState
-- startPositionPlayer2 =
--     [ { figure = Rook, moves = [ { x = 1, y = 8 } ] }
--     , { figure = Rook, moves = [ { x = 8, y = 8 } ] }
--     , { figure = Types.Pawn, moves = [ { x = 1, y = 7 } ] }
--     , { figure = Types.Pawn, moves = [ { x = 2, y = 7 } ] }
--     , { figure = Types.Pawn, moves = [ { x = 3, y = 7 } ] }
--     , { figure = Types.Pawn, moves = [ { x = 4, y = 7 } ] }
--     , { figure = Types.Pawn, moves = [ { x = 5, y = 7 } ] }
--     , { figure = Types.Pawn, moves = [ { x = 6, y = 7 } ] }
--     , { figure = Types.Pawn, moves = [ { x = 7, y = 7 } ] }
--     , { figure = Types.Pawn, moves = [ { x = 8, y = 7 } ] }
--     , { figure = Knight, moves = [ { x = 2, y = 8 } ] }
--     , { figure = Knight, moves = [ { x = 7, y = 8 } ] }
--     , { figure = Bishop, moves = [ { x = 3, y = 8 } ] }
--     , { figure = Bishop, moves = [ { x = 6, y = 8 } ] }
--     , { figure = King, moves = [ { x = 5, y = 8 } ] }
--     , { figure = Queen, moves = [ { x = 4, y = 8 } ] }
--     ]


figureElement : String -> Html msg
figureElement txt =
    Html.div
        [ HA.class "font-extrabold" ]
        [ Html.text txt ]


figureToHtml : Maybe Types.Figure -> Html msg
figureToHtml maybeFigure =
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


init : String -> String -> Bool -> ( Model, Cmd Msg )
init roomId urlString isInvited =
    ( initialModel urlString isInvited roomId
    , Cmd.none
    )


initialModel : String -> Bool -> String -> Model
initialModel urlString isInvited roomId =
    { player1 = []
    , player2 = []
    , possibleNextMoves = Types.Idle
    , error = Nothing
    , player1Captures = [] -- TODO Need to send captures from BE for opponent
    , player2Captures = []
    , urlString = urlString
    , isInvited = isInvited
    , roomId = roomId
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
                            let
                                _ =
                                    Debug.log "It seems that potential next step for this figure is to step over your other figure :( Not possible" ""
                            in
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
                                            updatePlayer2 : List Types.FigureState
                                            updatePlayer2 =
                                                List.map
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
                                                    model.player2
                                        in
                                        ( { model
                                            | player2 = updatePlayer2
                                            , possibleNextMoves = Types.Idle
                                          }
                                        , [ OutMsg.SendPositionsUpdate model.roomId model.isInvited ( model.player1, updatePlayer2 )
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
                        positionToCaptureFound : Maybe ( Types.Figure, { x : Int, y : Int } )
                        positionToCaptureFound =
                            -- Try to find desired field within potential captures fields
                            potentialCaptures
                                |> List.Extra.find
                                    (\f ->
                                        Util.isEqualPosition f.x positionToCapture.x f.y positionToCapture.y
                                    )
                                |> Maybe.map (\f -> ( positionToCapture.figure, f ))

                        updatedPlayer1 : List Types.FigureState
                        updatedPlayer1 =
                            model.player1
                                |> List.filter
                                    (\( pt, { figure, moves } ) ->
                                        case ( positionToCaptureFound, moves |> List.head ) of
                                            ( Just ( _, captureField ), Just field ) ->
                                                not <| Util.isEqualPosition field.x captureField.x field.y captureField.y

                                            _ ->
                                                True
                                    )

                        updatedPlayer2 : List Types.FigureState
                        updatedPlayer2 =
                            model.player2
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
                    , [ OutMsg.SendPositionsUpdate model.roomId model.isInvited ( updatedPlayer1, updatedPlayer2 ) ]
                    , Cmd.none
                    )

                Types.Idle ->
                    ( { model | error = Just "You need to choose figure first" }
                    , []
                    , Cmd.none
                    )

        Types.FeToChess_GotGameData ( pl1, pl2 ) ->
            ( { model | player1 = pl1, player2 = pl2 }
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


viewFields : Model -> Bool -> Int -> Int -> Html Msg
viewFields model shouldShowLetter xIndex yIndex =
    let
        letter : String
        letter =
            Util.indexToLetter model.isInvited xIndex

        maybeFigure : Maybe Types.Figure
        maybeFigure =
            coordinatesToFigure xIndex yIndex (List.concat [ model.player1, model.player2 ])

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
            isMyFigure xIndex yIndex model.player2

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
            if isMyFigure_ || maybeFigure == Nothing then
                Types.InitiateMove position

            else
                case maybeFigure of
                    Just fg ->
                        Types.InitiateCapture { figure = fg, x = position.x, y = position.y }

                    Nothing ->
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
        , if shouldShowLetter then
            Html.div
                [ HA.class "absolute bottom-[-30px] left-[45%]" ]
                [ Html.text letter ]

          else
            Html.text ""
        ]


viewRows : Model -> Int -> Html Msg
viewRows model colNum =
    let
        shouldShowLetter : Bool
        shouldShowLetter =
            if model.isInvited then
                colNum == number_of_columns

            else
                colNum == 1
    in
    Html.div
        [ HA.class "flex flex-row" ]
        (List.append
            (List.repeat number_of_rows (viewFields model)
                |> List.indexedMap
                    (\i el ->
                        el shouldShowLetter (i + 1) colNum
                    )
            )
            [ Html.div
                [ HA.class "flex self-center" ]
                [ Html.text <| String.fromInt colNum ]
            ]
        )


viewColumns : Model -> Html Msg
viewColumns model =
    Html.div
        [ HA.class "flex flex-col border border-white" ]
        (List.repeat number_of_columns (viewRows model)
            |> List.indexedMap
                (\i el ->
                    if model.isInvited then
                        el (i + 1)

                    else
                        el (8 - i)
                )
        )


view : Model -> Html Msg
view model =
    Html.div
        [ HA.class "" ]
        [ if model.isInvited then
            Html.div
                [ HA.class "flex flex-col mb-4" ]
                [ Html.h1
                    [ HA.class "text-4xl m-10 text-center" ]
                    [ Html.text "Welcome to game"
                    ]
                , Html.p
                    [ HA.class "text-center" ]
                    [ Html.text "Thanks for accepting invitation" ]
                ]

          else
            Html.div
                [ HA.class "flex flex-col mb-4" ]
                [ Html.h1
                    [ HA.class "text-4xl m-10 text-center" ]
                    [ Html.text "You are about to start a game with friend"
                    ]
                , Html.p
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
        , case model.error of
            Just err ->
                Html.p
                    [ HA.class "absolute w-[100%] top-0 bg-red-500 text-white p-3 text-center" ]
                    [ Html.text err ]

            Nothing ->
                Html.text ""
        , Html.Extra.viewIf (not <| List.isEmpty (List.concat [ model.player1, model.player2 ]))
            (Html.div [ HA.class "flex justify-center" ]
                [ viewColumns model ]
            )
        , capturesView model
        ]


capturesView : Model -> Html Msg
capturesView model =
    Html.div
        []
        [ Html.ul
            []
            (List.map
                (\( figure, lastHeldField ) ->
                    -- TODO make player2Captures to have only figure and field that figure had when it was capture
                    Html.li
                        []
                        [ figureToHtml (Just figure)
                        , Html.p []
                            [ Util.fieldToSpot model.isInvited lastHeldField
                                |> Maybe.withDefault ""
                                |> Html.text
                            ]
                        ]
                )
                model.player2Captures
            )
        ]
