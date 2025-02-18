module BackwardCompatibility exposing (Model, Msg, init, update, view)

-- import Html.Events as HE
-- import List.Extra

import Dict exposing (Dict)
import Diff
import Helper.Test as Helper
import Html exposing (Html)
import Html.Attributes as HA
import Html.Extra
import Json.Encode
import Svg
import Svg.Attributes as SVGHA
import Types
import Util



-- import Svg.Events


type alias Msg =
    Types.BackwardCompatibilityMsg


type alias Model =
    Types.BackwardCompatibilityModel


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Types.NoOpB ->
            ( model, Cmd.none )


init : Maybe Types.Figure -> ( Model, Cmd Msg )
init maybeFigure =
    ( { figure = maybeFigure }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div
        [ HA.class "p-5" ]
        [ Html.h1
            []
            [ Html.text "TESTS !!" ]
        , Html.nav
            []
            [ Html.a
                [ HA.href "/tests/queen"
                , HA.class <|
                    "hover:bg-gray-400 font-bold py-2 px-4 rounded-l"
                        ++ (if model.figure == Just Types.Queen then
                                " bg-blue-500 text-white text-white"

                            else
                                " bg-gray-300 text-gray-800"
                           )
                ]
                [ Html.text "Queen" ]
            , Html.a
                [ HA.href "/tests/king"
                , HA.class <|
                    "hover:bg-gray-400 font-bold py-2 px-4"
                        ++ (if model.figure == Just Types.King then
                                " bg-blue-500 text-white"

                            else
                                " bg-gray-300 text-gray-800"
                           )
                ]
                [ Html.text "King" ]
            , Html.a
                [ HA.href "/tests/rook"
                , HA.class <|
                    "hover:bg-gray-400 font-bold py-2 px-4"
                        ++ (if model.figure == Just Types.Rook then
                                " bg-blue-500 text-white"

                            else
                                " bg-gray-300 text-gray-800"
                           )
                ]
                [ Html.text "Rook" ]
            , Html.a
                [ HA.href "/tests/knight"
                , HA.class <|
                    "hover:bg-gray-400 font-bold py-2 px-4"
                        ++ (if model.figure == Just Types.Knight then
                                " bg-blue-500 text-white"

                            else
                                " bg-gray-300 text-gray-800"
                           )
                ]
                [ Html.text "Knight" ]
            , Html.a
                [ HA.href "/tests/bishop"
                , HA.class <|
                    "hover:bg-gray-400 font-bold py-2 px-4"
                        ++ (if model.figure == Just Types.Bishop then
                                " bg-blue-500 text-white"

                            else
                                " bg-gray-300 text-gray-800"
                           )
                ]
                [ Html.text "Bishop" ]
            , Html.a
                [ HA.href "/tests/pawn"
                , HA.class <|
                    "hover:bg-gray-400 font-bold py-2 px-4 rounded-r"
                        ++ (if model.figure == Just Types.Pawn then
                                " bg-blue-500 text-white"

                            else
                                " bg-gray-300 text-gray-800"
                           )
                ]
                [ Html.text "Pawn" ]
            ]
        , Html.div
            [ HA.class "" ]
            [ case model.figure of
                Just Types.Queen ->
                    let
                        queenTestUnitLst =
                            [ { startPosition = { x = 5, y = 5 }
                              , maybeSpot = Util.fieldToSpot False { x = 5, y = 5 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Queen
                                        { x = 5, y = 5 }
                                        Helper.opponentPositions
                                        Helper.queenPossitionsTest1
                              , expected = Helper.queenExpectedTestUnit1
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.queenPossitionsTest1
                              }
                            , { startPosition = { x = 2, y = 8 }
                              , maybeSpot = Util.fieldToSpot False { x = 2, y = 8 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Queen
                                        { x = 2, y = 8 }
                                        Helper.opponentPositions
                                        Helper.queenPossitionsTest2
                              , expected = Helper.queenExpectedTestUnit2
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.queenPossitionsTest2
                              }
                            , { startPosition = { x = 7, y = 3 }
                              , maybeSpot = Util.fieldToSpot False { x = 7, y = 3 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Queen
                                        { x = 7, y = 3 }
                                        Helper.opponentPositions
                                        Helper.queenPossitionsTest3
                              , expected = Helper.queenExpectedTestUnit3
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.queenPossitionsTest3
                              }
                            ]
                    in
                    Html.div
                        []
                        [ Html.h2
                            []
                            [ Html.text "QUEEN" ]
                        , Html.ul
                            [ HA.class "" ]
                            (List.map testUnitView queenTestUnitLst)
                        ]

                Just Types.King ->
                    let
                        kingTestUnitLst =
                            [ { startPosition = { x = 5, y = 6 }
                              , maybeSpot = Util.fieldToSpot False { x = 5, y = 6 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.King
                                        { x = 5, y = 6 }
                                        Helper.opponentPositions
                                        Helper.kingPossitionsTest1
                              , expected = Helper.kingExpectedTestUnit1
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.kingPossitionsTest1
                              }
                            , { startPosition = { x = 6, y = 3 }
                              , maybeSpot = Util.fieldToSpot False { x = 6, y = 3 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.King
                                        { x = 6, y = 3 }
                                        Helper.opponentPositions
                                        Helper.kingPossitionsTest2
                              , expected = Helper.kingExpectedTestUnit2
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.kingPossitionsTest2
                              }
                            , { startPosition = { x = 1, y = 3 }
                              , maybeSpot = Util.fieldToSpot False { x = 1, y = 3 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.King
                                        { x = 1, y = 3 }
                                        Helper.opponentPositions
                                        Helper.kingPossitionsTest3
                              , expected = Helper.kingExpectedTestUnit3
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.kingPossitionsTest3
                              }
                            ]
                    in
                    Html.div
                        []
                        [ Html.h2
                            []
                            [ Html.text "KING" ]
                        , Html.ul
                            [ HA.class "" ]
                            (List.map testUnitView kingTestUnitLst)
                        ]

                Just Types.Rook ->
                    let
                        rookTestUnitLst =
                            [ { startPosition = { x = 4, y = 7 }
                              , maybeSpot = Util.fieldToSpot False { x = 4, y = 7 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Rook
                                        { x = 4, y = 7 }
                                        Helper.opponentPositions
                                        Helper.rookPossitionsTest1
                              , expected = Helper.rookExpectedTestUnit1
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.rookPossitionsTest1
                              }
                            , { startPosition = { x = 6, y = 4 }
                              , maybeSpot = Util.fieldToSpot False { x = 6, y = 4 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Rook
                                        { x = 6, y = 4 }
                                        Helper.opponentPositions
                                        Helper.rookPossitionsTest2
                              , expected = Helper.rookExpectedTestUnit2
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.rookPossitionsTest2
                              }
                            , { startPosition = { x = 1, y = 8 }
                              , maybeSpot = Util.fieldToSpot False { x = 1, y = 8 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Rook
                                        { x = 1, y = 8 }
                                        Helper.opponentPositions
                                        Helper.rookPossitionsTest3
                              , expected = Helper.rookExpectedTestUnit3
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.rookPossitionsTest3
                              }
                            ]
                    in
                    Html.div
                        []
                        [ Html.h2
                            []
                            [ Html.text "ROOK" ]
                        , Html.ul
                            [ HA.class "" ]
                            (List.map testUnitView rookTestUnitLst)
                        ]

                Just Types.Knight ->
                    let
                        knightTestUnitLst =
                            [ { startPosition = { x = 6, y = 7 }
                              , maybeSpot = Util.fieldToSpot False { x = 6, y = 7 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Knight
                                        { x = 6, y = 7 }
                                        Helper.opponentPositions
                                        Helper.knightPossitionsTest1
                              , expected = Helper.knightExpectedTestUnit1
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.knightPossitionsTest1
                              }
                            , { startPosition = { x = 5, y = 4 }
                              , maybeSpot = Util.fieldToSpot False { x = 5, y = 4 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Knight
                                        { x = 5, y = 4 }
                                        Helper.opponentPositions
                                        Helper.knightPossitionsTest2
                              , expected = Helper.knightExpectedTestUnit2
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.knightPossitionsTest2
                              }
                            , { startPosition = { x = 3, y = 3 }
                              , maybeSpot = Util.fieldToSpot False { x = 3, y = 3 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Knight
                                        { x = 3, y = 3 }
                                        Helper.opponentPositions
                                        Helper.knightPossitionsTest3
                              , expected = Helper.knightExpectedTestUnit3
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.knightPossitionsTest3
                              }
                            ]
                    in
                    Html.div
                        []
                        [ Html.h2
                            []
                            [ Html.text "KNIGHT" ]
                        , Html.ul
                            [ HA.class "" ]
                            (List.map testUnitView knightTestUnitLst)
                        ]

                Just Types.Bishop ->
                    let
                        bishopTestUnitLst =
                            [ { startPosition = { x = 4, y = 5 }
                              , maybeSpot = Util.fieldToSpot False { x = 4, y = 5 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Bishop
                                        { x = 4, y = 5 }
                                        Helper.opponentPositions
                                        Helper.bishopPossitionsTest1
                              , expected = Helper.bishopExpectedTestUnit1
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.bishopPossitionsTest1
                              }
                            , { startPosition = { x = 6, y = 3 }
                              , maybeSpot = Util.fieldToSpot False { x = 6, y = 3 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Bishop
                                        { x = 6, y = 3 }
                                        Helper.opponentPositions
                                        Helper.bishopPossitionsTest2
                              , expected = Helper.bishopExpectedTestUnit2
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.bishopPossitionsTest2
                              }
                            , { startPosition = { x = 2, y = 3 }
                              , maybeSpot = Util.fieldToSpot False { x = 2, y = 3 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Bishop
                                        { x = 2, y = 3 }
                                        Helper.opponentPositions
                                        Helper.bishopPossitionsTest3
                              , expected = Helper.bishopExpectedTestUnit3
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.bishopPossitionsTest3
                              }
                            ]
                    in
                    Html.div
                        []
                        [ Html.h2
                            []
                            [ Html.text "BISHOP" ]
                        , Html.ul
                            [ HA.class "" ]
                            (List.map testUnitView bishopTestUnitLst)
                        ]

                Just Types.Pawn ->
                    let
                        pawnTestUnitLst =
                            [ { startPosition = { x = 7, y = 4 }
                              , maybeSpot = Util.fieldToSpot False { x = 7, y = 4 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Pawn
                                        { x = 7, y = 4 }
                                        Helper.opponentPositions
                                        Helper.pawnPossitionsTest1
                              , expected = Helper.pawnExpectedTestUnit1
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.pawnPossitionsTest1
                              }
                            , { startPosition = { x = 7, y = 3 }
                              , maybeSpot = Util.fieldToSpot False { x = 7, y = 3 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Pawn
                                        { x = 7, y = 3 }
                                        Helper.opponentPositions
                                        Helper.pawnPossitionsTest2
                              , expected = Helper.pawnExpectedTestUnit2
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.pawnPossitionsTest2
                              }
                            , { startPosition = { x = 7, y = 2 }
                              , maybeSpot = Util.fieldToSpot False { x = 7, y = 2 }
                              , actual =
                                    Util.getNextPossibleMoves
                                        Types.Pawn
                                        { x = 7, y = 2 }
                                        Helper.opponentPositions
                                        Helper.pawnPossitionsTest3
                              , expected = Helper.pawnExpectedTestUnit3
                              , opponentPositions = Helper.opponentPositions
                              , myPossitions = Helper.pawnPossitionsTest3
                              }
                            ]
                    in
                    Html.div
                        []
                        [ Html.h2
                            []
                            [ Html.text "PAWN" ]
                        , Html.ul
                            [ HA.class "" ]
                            (List.map testUnitView pawnTestUnitLst)
                        ]

                _ ->
                    Html.div
                        []
                        [ Html.text "Choose figure" ]
            ]
        ]


testUnitView :
    { maybeSpot : Maybe String
    , startPosition : Types.Field
    , expected : Types.NextMoves
    , actual : Types.NextMoves
    , opponentPositions : List Types.FigureState
    , myPossitions : List Types.FigureState
    }
    -> Html Msg
testUnitView { maybeSpot, startPosition, expected, actual, opponentPositions, myPossitions } =
    Html.li
        []
        [ Html.h3
            []
            [ case maybeSpot of
                Just spot ->
                    Html.text <| "Movements and captures when on field " ++ spot

                Nothing ->
                    Html.text "There has been issue with provided field"
            ]
        , Html.div
            []
            [ Html.div
                [ HA.class "w-[200px] h-[200px]" ]
                [ currentSetupToSvg opponentPositions myPossitions startPosition.x startPosition.y ]
            ]
        , getTestResults actual expected
        ]


getTestResults : Types.NextMoves -> Types.NextMoves -> Html Msg
getTestResults actual_ expected_ =
    let
        isTrue =
            actual_ == expected_

        potentialMovesDiff =
            Diff.diff expected_.potentialMoves actual_.potentialMoves

        potentialCapturesDiff : List (Diff.Change Types.Field)
        potentialCapturesDiff =
            Diff.diff expected_.potentialCaptures actual_.potentialCaptures
    in
    Html.div
        []
        [ if isTrue then
            Html.p
                [ HA.class "text-green-500" ]
                [ Html.text "Result is looking good ! ✅" ]

          else
            Html.div
                []
                [ Html.p
                    [ HA.class "text-red-500" ]
                    [ Html.text "Result is not correct ❌, this is what I've expected !" ]
                , Html.div
                    [ HA.class "flex gap-6" ]
                    [ Html.div
                        [ HA.class "flex gap-6" ]
                        [ Html.Extra.viewIf (not <| List.isEmpty potentialMovesDiff)
                            (Html.div
                                []
                                [ Html.p
                                    []
                                    [ Html.text "Potential moves:" ]
                                , Html.code
                                    []
                                    [ Html.ul
                                        []
                                        (potentialMovesDiff
                                            |> List.map toDiffHtml
                                        )
                                    ]
                                ]
                            )
                        , Html.Extra.viewIf (not <| List.isEmpty potentialCapturesDiff)
                            (Html.div
                                []
                                [ Html.p
                                    []
                                    [ Html.text "Potential captures:" ]
                                , Html.code
                                    []
                                    [ Html.ul
                                        []
                                        (potentialCapturesDiff
                                            |> List.map toDiffHtml
                                        )
                                    ]
                                ]
                            )
                        ]
                    ]
                ]
        ]


toDiffHtml : Diff.Change Types.Field -> Html msg
toDiffHtml diffField =
    case diffField of
        Diff.Added f ->
            Html.li
                [ HA.class "text-green-500 relative" ]
                [ Html.span
                    [ HA.class "absolute left-[80%] bottom-[40%]" ]
                    [ Html.text "+" ]
                , Html.text <| encodeFieldRecord f ++ ","
                ]

        Diff.NoChange f ->
            Html.li
                []
                [ Html.text <| encodeFieldRecord f ++ "," ]

        Diff.Removed f ->
            Html.li
                [ HA.class "text-red-500 relative" ]
                [ Html.span
                    [ HA.class "absolute left-[80%] bottom-[40%]" ]
                    [ Html.text "-" ]
                , Html.text <| encodeFieldRecord f ++ ","
                ]


encodeFieldRecord : Types.Field -> String
encodeFieldRecord field =
    [ ( "x", Json.Encode.int field.x )
    , ( "y", Json.Encode.int field.y )
    ]
        |> Json.Encode.object
        |> Json.Encode.encode 4
        |> String.replace "\"" ""


toTuple : Types.Field -> ( Int, Int )
toTuple { x, y } =
    ( x, y )


playerTypeToText : Types.PlayerType -> String
playerTypeToText pt =
    case pt of
        Types.Me ->
            "X"

        Types.Opponent ->
            "O"


playerTypeToColor : Types.PlayerType -> String
playerTypeToColor pt =
    case pt of
        Types.Me ->
            "blue"

        Types.Opponent ->
            "red"


figureOnField : ( String, String ) -> Types.PlayerType -> Bool -> Svg.Svg Msg
figureOnField ( x, y ) pt isMe =
    -- figureOnField : ("25", "35") -> Figure on { x = 1, y = 1 }
    Svg.text_
        [ SVGHA.x x, SVGHA.y y, SVGHA.fontSize "30", SVGHA.fontFamily "Arial", SVGHA.textAnchor "middle", SVGHA.fill <| playerTypeToColor pt ]
        [ pt
            |> playerTypeToText
            |> (\s ->
                    if isMe then
                        Svg.text "Me"

                    else
                        Svg.text s
               )
        ]


fromFieldToSvgCoordinates : Int -> Int -> Types.FigureState -> Svg.Svg Msg
fromFieldToSvgCoordinates x1 y1 ( pt, { figure, moves } ) =
    moves
        |> List.head
        |> Maybe.andThen
            (\field ->
                let
                    isMe : Bool
                    isMe =
                        Util.isEqualPosition field.x x1 field.y y1
                in
                dictOfCoordinates
                    |> Dict.get (toTuple field)
                    |> Maybe.map
                        (\coord ->
                            figureOnField coord pt isMe
                        )
            )
        |> (Maybe.withDefault <| Svg.text "")


dictOfCoordinates : Dict ( Int, Int ) ( String, String )
dictOfCoordinates =
    generateCoordinateDict 8 8


generateCoordinateDict : Int -> Int -> Dict ( Int, Int ) ( String, String )
generateCoordinateDict rows cols =
    let
        rowList : List Int
        rowList =
            List.range 1 rows

        colList : List Int
        colList =
            List.range 1 cols

        computeCoordinates : Int -> Int -> ( ( Int, Int ), ( String, String ) )
        computeCoordinates row col =
            ( ( col, row )
            , ( String.fromInt (25 + (col - 1) * 50)
              , String.fromInt (35 + (row - 1) * 50)
              )
            )
    in
    rowList
        |> List.concatMap
            (\row ->
                List.map (computeCoordinates row) colList
            )
        |> Dict.fromList


currentSetupToSvg : List Types.FigureState -> List Types.FigureState -> Int -> Int -> Html Msg
currentSetupToSvg oppPositions mPositions x1 y1 =
    Svg.svg
        [ SVGHA.class "w-[100%] h-[100%]", SVGHA.width "400", SVGHA.height "400", SVGHA.viewBox "0 0 400 400" ]
        [ Svg.rect
            [ SVGHA.x "0", SVGHA.y "0", SVGHA.width "400", SVGHA.height "400", SVGHA.fill "#ffffff", SVGHA.stroke "#000000", SVGHA.strokeWidth "2", SVGHA.fill "#f0d9b5" ]
            []
        , Svg.g
            [ SVGHA.stroke "#000000", SVGHA.strokeWidth "1" ]
            (List.concat
                [ List.map
                    (\i ->
                        Svg.line
                            [ SVGHA.x1 (String.fromInt (i * 50)), SVGHA.y1 "0", SVGHA.x2 (String.fromInt (i * 50)), SVGHA.y2 "400" ]
                            []
                    )
                    (List.range 1 7)
                    ++ List.map
                        (\i ->
                            Svg.line
                                [ SVGHA.x1 "0", SVGHA.y1 (String.fromInt (i * 50)), SVGHA.x2 "400", SVGHA.y2 (String.fromInt (i * 50)) ]
                                []
                        )
                        (List.range 1 7)
                , [ oppPositions, mPositions ]
                    |> List.concat
                    |> List.map (fromFieldToSvgCoordinates x1 y1)
                ]
            )
        ]
