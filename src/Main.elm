module Main exposing (main)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import List.Extra
import Maybe.Extra


number_of_rows : Int
number_of_rows =
    8


number_of_columns : Int
number_of_columns =
    8


type Axis
    = X
    | Y


type alias FigureState =
    { figure : Figure
    , moves : List Field
    }


type alias Field =
    { x : Int
    , y : Int
    }


type Figure
    = King
    | Queen
    | Bishop
    | Knight
    | Rook
    | Pawn


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

    -- , { figure = Pawn, moves = [ { x = 8, y = 2 } ] }
    , { figure = Knight, moves = [ { x = 2, y = 1 } ] }
    , { figure = Knight, moves = [ { x = 7, y = 1 } ] }

    -- , { figure = Knight, moves = [ { x = 2, y = 4 } ] }
    , { figure = Bishop, moves = [ { x = 3, y = 1 } ] }
    , { figure = Bishop, moves = [ { x = 6, y = 1 } ] }
    , { figure = King, moves = [ { x = 5, y = 1 } ] }
    , { figure = Queen, moves = [ { x = 4, y = 1 } ] }
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


startPositionPlayer2 : List FigureState
startPositionPlayer2 =
    [ { figure = Rook, moves = [ { x = 4, y = 7 } ] }
    , { figure = Rook, moves = [ { x = 7, y = 3 } ] }
    , { figure = Rook, moves = [ { x = 7, y = 8 } ] }
    , { figure = Rook, moves = [ { x = 5, y = 4 } ] }
    , { figure = Pawn, moves = [ { x = 8, y = 3 } ] }
    , { figure = Pawn, moves = [ { x = 4, y = 5 } ] }
    , { figure = Pawn, moves = [ { x = 6, y = 5 } ] }
    , { figure = Pawn, moves = [ { x = 5, y = 3 } ] }
    , { figure = Pawn, moves = [ { x = 1, y = 5 } ] }
    , { figure = Pawn, moves = [ { x = 5, y = 7 } ] }
    , { figure = Pawn, moves = [ { x = 6, y = 7 } ] }
    , { figure = Pawn, moves = [ { x = 8, y = 2 } ] }
    , { figure = Pawn, moves = [ { x = 8, y = 7 } ] }
    , { figure = Knight, moves = [ { x = 2, y = 5 } ] }
    , { figure = Knight, moves = [ { x = 8, y = 8 } ] }
    , { figure = Bishop, moves = [ { x = 3, y = 8 } ] }
    , { figure = Bishop, moves = [ { x = 6, y = 8 } ] }

    -- , { figure = King, moves = [ { x = 5, y = 8 } ] }
    , { figure = Queen, moves = [ { x = 4, y = 8 } ] }
    ]



-- startPositionPlayer2 : List FigureState
-- startPositionPlayer2 =
--     [ { figure = Rook, moves = [ { x = 1, y = 8 } ] }
--     , { figure = Rook, moves = [ { x = 8, y = 8 } ] }
--     , { figure = Pawn, moves = [ { x = 1, y = 7 } ] }
--     , { figure = Pawn, moves = [ { x = 2, y = 7 } ] }
--     , { figure = Pawn, moves = [ { x = 3, y = 7 } ] }
--     , { figure = Pawn, moves = [ { x = 4, y = 7 } ] }
--     , { figure = Pawn, moves = [ { x = 5, y = 7 } ] }
--     , { figure = Pawn, moves = [ { x = 6, y = 7 } ] }
--     , { figure = Pawn, moves = [ { x = 7, y = 7 } ] }
--     , { figure = Pawn, moves = [ { x = 8, y = 7 } ] }
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


figureToHtml : Maybe Figure -> Html msg
figureToHtml maybeFigure =
    case maybeFigure of
        Just figure ->
            case figure of
                Rook ->
                    figureElement "ROOK"

                Pawn ->
                    figureElement "PAWN"

                Knight ->
                    figureElement "KNIGHT"

                Bishop ->
                    figureElement "BISHOP"

                King ->
                    figureElement "KING"

                Queen ->
                    figureElement "QUEEN"

        Nothing ->
            Html.text ""


indexToLetter : Int -> String
indexToLetter idx =
    case idx of
        1 ->
            "A"

        2 ->
            "B"

        3 ->
            "C"

        4 ->
            "D"

        5 ->
            "E"

        6 ->
            "F"

        7 ->
            "G"

        _ ->
            "H"


isEqualPosition : Int -> Int -> Int -> Int -> Bool
isEqualPosition x x1 y y1 =
    x == x1 && y == y1


type
    PossibleNextMove
    -- Next Move - Current Field and Next Move Potential fields
    = NextMove Field (List Field)
    | Idle


type alias Model =
    { player1 : List FigureState
    , player2 : List FigureState
    , possibleNextMoves : PossibleNextMove
    , error : Maybe String
    }


initialModel : Model
initialModel =
    { player1 = startPositionPlayer1
    , player2 = startPositionPlayer2
    , possibleNextMoves = Idle
    , error = Nothing
    }


type alias Position =
    { figure : Maybe Figure
    , x : Int
    , y : Int
    }



-- MESSAGES


type Msg
    = NoOp
    | InitiateMove Position



-- UPDATE


hasInitiatedMove : PossibleNextMove -> Bool
hasInitiatedMove pnm =
    case pnm of
        NextMove _ _ ->
            True

        Idle ->
            False


getPossitionOfActiveFigure : PossibleNextMove -> Maybe Field
getPossitionOfActiveFigure pnm =
    case pnm of
        NextMove { x, y } _ ->
            Just (Field x y)

        Idle ->
            Nothing


getPossibleFieldsToMove : Figure -> Field -> List FigureState -> List Field
getPossibleFieldsToMove fg currentField myTeam =
    myTeam
        |> List.filter
            (\fs ->
                fs.moves
                    |> List.head
                    -- have opponent Figures somewhere on my path
                    |> Maybe.Extra.filter
                        (\f ->
                            case fg of
                                Pawn ->
                                    currentField.y - f.y == 1 && currentField.x == f.x

                                Rook ->
                                    f.x
                                        == currentField.x
                                        && f.y
                                        /= currentField.y
                                        || f.y
                                        == currentField.y
                                        && f.x
                                        /= currentField.x

                                Knight ->
                                    -- up left/right
                                    ((currentField.x + 1 == f.x || currentField.x - 1 == f.x) && currentField.y - 2 == f.y)
                                        -- down left/right
                                        || ((currentField.x + 1 == f.x || currentField.x - 1 == f.x) && currentField.y + 2 == f.y)
                                        -- left up/bottom
                                        || ((currentField.y + 1 == f.y || currentField.y - 1 == f.y) && currentField.x - 2 == f.x)
                                        || -- right up/bottom
                                           ((currentField.y + 1 == f.y || currentField.y - 1 == f.y) && currentField.x + 2 == f.x)

                                _ ->
                                    False
                        )
                    |> Maybe.Extra.isJust
            )
        |> List.map (\fs -> fs.moves |> List.head)
        |> List.filterMap identity
        |> (\opponentFieldLst ->
                case fg of
                    Pawn ->
                        if List.isEmpty opponentFieldLst then
                            [ { x = currentField.x, y = currentField.y - 1 } ]

                        else
                            []

                    Rook ->
                        getAllPossibleMovesForRook currentField opponentFieldLst

                    Knight ->
                        getAllPossibleMovesForKnight currentField opponentFieldLst

                    _ ->
                        opponentFieldLst
           )


getAllPossibleMovesForRook : Field -> List Field -> List Field
getAllPossibleMovesForRook myPosition positionsOfMyOtherFigures =
    let
        fromMeToTop : Field -> List Field -> List Field
        fromMeToTop currentField lst =
            --go up -> lower number
            let
                nextField : Field
                nextField =
                    { currentField | y = currentField.y - 1 }
            in
            if nextField.y /= 0 then
                if
                    lst
                        |> List.Extra.find
                            (\f -> isEqualPosition nextField.x f.x nextField.y f.y)
                        |> Maybe.Extra.isJust
                then
                    -- closest figure found -> exit
                    []

                else
                    nextField :: fromMeToTop nextField lst

            else
                []

        fromMeToBottom : Field -> List Field -> List Field
        fromMeToBottom currentField lst =
            --go down -> bigger number
            let
                nextField : Field
                nextField =
                    { currentField | y = currentField.y + 1 }
            in
            if nextField.y <= 8 then
                if
                    lst
                        |> List.Extra.find
                            (\f -> isEqualPosition nextField.x f.x nextField.y f.y)
                        |> Maybe.Extra.isJust
                then
                    []

                else
                    nextField :: fromMeToBottom nextField lst

            else
                []

        fromMeToLeft : Field -> List Field -> List Field
        fromMeToLeft currentField lst =
            --go left -> lower number
            let
                nextField : Field
                nextField =
                    { currentField | x = currentField.x - 1 }
            in
            if nextField.x /= 0 then
                if
                    lst
                        |> List.Extra.find
                            (\f -> isEqualPosition nextField.x f.x nextField.y f.y)
                        |> Maybe.Extra.isJust
                then
                    []

                else
                    nextField :: fromMeToLeft nextField lst

            else
                []

        fromMeToRight : Field -> List Field -> List Field
        fromMeToRight currentField lst =
            --go right -> bigger number
            let
                nextField : Field
                nextField =
                    { currentField | x = currentField.x + 1 }
            in
            if nextField.x <= 8 then
                if
                    lst
                        |> List.Extra.find
                            (\f -> isEqualPosition nextField.x f.x nextField.y f.y)
                        |> Maybe.Extra.isJust
                then
                    []

                else
                    nextField :: fromMeToRight nextField lst

            else
                []
    in
    List.concat
        [ fromMeToTop myPosition positionsOfMyOtherFigures
        , fromMeToBottom myPosition positionsOfMyOtherFigures
        , fromMeToLeft myPosition positionsOfMyOtherFigures
        , fromMeToRight myPosition positionsOfMyOtherFigures
        ]


getAllPossibleMovesForKnight : Field -> List Field -> List Field
getAllPossibleMovesForKnight myPosition positionsOfMyOtherFigures =
    let
        fromMeToTop : Field -> List Field -> List Field
        fromMeToTop currentField lst =
            --go up -> lower number
            let
                nextFields : List Field
                nextFields =
                    [ -- 2 up 1 right
                      { x = currentField.x + 1, y = currentField.y - 2 }

                    -- 2 up 1 left
                    , { x = currentField.x - 1, y = currentField.y - 2 }
                    ]
            in
            List.filter
                (\f ->
                    lst
                        |> List.any
                            (\f1 ->
                                isEqualPosition f.x f1.x f.y f1.y
                            )
                        |> not
                )
                nextFields

        fromMeToBottom : Field -> List Field -> List Field
        fromMeToBottom currentField lst =
            --go down -> bigger number
            let
                nextFields : List Field
                nextFields =
                    [ -- 2 down 1 right
                      { x = currentField.x + 1, y = currentField.y + 2 }

                    -- 2 down 1 left
                    , { x = currentField.x - 1, y = currentField.y + 2 }
                    ]
            in
            List.filter
                (\f ->
                    lst
                        |> List.any
                            (\f1 ->
                                isEqualPosition f.x f1.x f.y f1.y
                            )
                        |> not
                )
                nextFields

        fromMeToLeft : Field -> List Field -> List Field
        fromMeToLeft currentField lst =
            --go left -> lower number
            let
                nextFields : List Field
                nextFields =
                    [ -- 2 left 1 top
                      { x = currentField.x - 2, y = currentField.y - 1 }

                    -- 2 left 1 down
                    , { x = currentField.x - 2, y = currentField.y + 1 }
                    ]
            in
            List.filter
                (\f ->
                    lst
                        |> List.any
                            (\f1 ->
                                isEqualPosition f.x f1.x f.y f1.y
                            )
                        |> not
                )
                nextFields

        fromMeToRight : Field -> List Field -> List Field
        fromMeToRight currentField lst =
            --go right -> bigger number
            let
                nextFields : List Field
                nextFields =
                    [ -- 2 left 1 top
                      { x = currentField.x + 2, y = currentField.y - 1 }

                    -- 2 left 1 down
                    , { x = currentField.x + 2, y = currentField.y + 1 }
                    ]
            in
            List.filter
                (\f ->
                    lst
                        |> List.any
                            (\f1 ->
                                isEqualPosition f.x f1.x f.y f1.y
                            )
                        |> not
                )
                nextFields
    in
    List.concat
        [ fromMeToTop myPosition positionsOfMyOtherFigures
        , fromMeToBottom myPosition positionsOfMyOtherFigures
        , fromMeToLeft myPosition positionsOfMyOtherFigures
        , fromMeToRight myPosition positionsOfMyOtherFigures
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        InitiateMove desiredOrCurrentPosition ->
            case desiredOrCurrentPosition.figure of
                Just figure ->
                    if hasInitiatedMove model.possibleNextMoves then
                        -- Move was already initialized - RESET
                        ( { model
                            | possibleNextMoves = Idle
                            , error = Nothing
                          }
                        , Cmd.none
                        )

                    else
                        let
                            nextMoves : List Field
                            nextMoves =
                                getPossibleFieldsToMove
                                    figure
                                    (Field
                                        desiredOrCurrentPosition.x
                                        desiredOrCurrentPosition.y
                                    )
                                    model.player2

                            cannotMove : Bool
                            cannotMove =
                                nextMoves
                                    |> List.length
                                    |> (==) 0
                        in
                        -- It's IDLE -> Check if someone is blocking your move
                        if cannotMove then
                            -- PAWN: Ilegal move -> Your other figure is preventing you to move
                            let
                                _ =
                                    Debug.log "It seems that potential next step for this figure is to step over your other figure :( Not possible" ""
                            in
                            ( { model | error = Just "Your other figure is preventing you to move with this figure" }
                            , Cmd.none
                            )

                        else
                            -- It's IDLE -> Choosing figure you want to move
                            case model.possibleNextMoves of
                                Idle ->
                                    ( { model
                                        | possibleNextMoves =
                                            NextMove
                                                { x = desiredOrCurrentPosition.x
                                                , y = desiredOrCurrentPosition.y
                                                }
                                                nextMoves
                                        , error = Nothing
                                      }
                                    , Cmd.none
                                    )

                                NextMove _ lstOfMoves ->
                                    ( model, Cmd.none )

                Nothing ->
                    case model.possibleNextMoves of
                        NextMove previousField lstOfMoves ->
                            -- Alright ! Maybe we can move figure, let's check if selected field is among allowed fields !
                            let
                                isOkToMove : Bool
                                isOkToMove =
                                    lstOfMoves
                                        |> List.any
                                            (\{ x, y } ->
                                                isEqualPosition x desiredOrCurrentPosition.x y desiredOrCurrentPosition.y
                                            )

                                updatedModel : Model
                                updatedModel =
                                    if isOkToMove then
                                        -- Alright, good to go !
                                        let
                                            updatePlayer2 : List FigureState
                                            updatePlayer2 =
                                                List.map
                                                    (\fs ->
                                                        { fs
                                                            | moves =
                                                                if List.head fs.moves == Just previousField then
                                                                    { x = desiredOrCurrentPosition.x
                                                                    , y = desiredOrCurrentPosition.y
                                                                    }
                                                                        :: fs.moves

                                                                else
                                                                    fs.moves
                                                        }
                                                    )
                                                    model.player2
                                        in
                                        { model
                                            | player2 = updatePlayer2
                                            , possibleNextMoves = Idle
                                        }

                                    else
                                        -- Bummer, selected figure can't move to that field!
                                        { model
                                            | player2 = model.player2
                                            , error = Just "Selected figure can't move to that field"
                                        }
                            in
                            ( updatedModel
                            , Cmd.none
                            )

                        Idle ->
                            -- Move wasn't initialized - You need to choose figure first !
                            ( { model | error = Just "First choose figure you want to play with" }
                            , Cmd.none
                            )


findFigureOnThatField : Int -> Int -> List FigureState -> Maybe FigureState
findFigureOnThatField x1 y1 lst =
    lst
        |> List.Extra.find
            (\{ moves } ->
                List.head moves
                    |> Maybe.map (\{ x, y } -> isEqualPosition x x1 y y1)
                    |> Maybe.withDefault False
            )


coordinatesToFigure : Int -> Int -> List FigureState -> Maybe Figure
coordinatesToFigure x1 y1 lst =
    lst
        |> findFigureOnThatField x1 y1
        |> Maybe.map .figure


viewSquare : Model -> Bool -> Int -> Int -> Html Msg
viewSquare { player1, player2, possibleNextMoves } shouldShowLetter xIndex yIndex =
    let
        letter : String
        letter =
            indexToLetter xIndex

        maybeFigure : Maybe Figure
        maybeFigure =
            coordinatesToFigure xIndex yIndex (List.concat [ player1, player2 ])

        figureEl : Html Msg
        figureEl =
            figureToHtml maybeFigure

        isPossibleNextMove : Bool
        isPossibleNextMove =
            case possibleNextMoves of
                NextMove _ lstOfMoves ->
                    lstOfMoves
                        |> List.filter (\{ x, y } -> isEqualPosition xIndex x yIndex y)
                        |> List.length
                        |> (/=) 0

                Idle ->
                    False

        position : Position
        position =
            { figure = maybeFigure, x = xIndex, y = yIndex }
    in
    Html.div
        [ HE.onClick <| InitiateMove position
        , HA.class <|
            "relative cursor-pointer flex w-[100px] h-[100px]"
                ++ (if isPossibleNextMove then
                        " bg-green-100"

                    else
                        ""
                   )
                ++ (case getPossitionOfActiveFigure possibleNextMoves of
                        Just { x, y } ->
                            if isEqualPosition x xIndex y yIndex then
                                " border-2 border-pink-400"

                            else
                                " border border-black"

                        Nothing ->
                            " border border-black"
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
    Html.div
        [ HA.class "flex flex-row" ]
        (List.append
            (List.repeat number_of_rows (viewSquare model)
                |> List.indexedMap
                    (\i el ->
                        el (colNum == number_of_columns) (i + 1) colNum
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
        [ HA.class "flex flex-col border border-black" ]
        (List.repeat number_of_columns (viewRows model)
            |> List.indexedMap (\i el -> el (i + 1))
        )


view : Model -> Html Msg
view model =
    Html.div
        [ HA.class "" ]
        [ Html.h1
            [ HA.class "text-4xl m-10 text-center" ]
            [ Html.text "Welcome to match" ]
        , case model.error of
            Just err ->
                Html.p
                    [ HA.class "absolute w-[100%] top-0 bg-red-500 text-white p-3 text-center" ]
                    [ Html.text err ]

            Nothing ->
                Html.text ""
        , Html.div [ HA.class "flex justify-center" ]
            [ viewColumns model ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( initialModel, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
