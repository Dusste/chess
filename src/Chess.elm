module Chess exposing (..)

import Dict exposing (Dict)
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


type PlayerType
    = Opponent
    | Me


type alias FigureState =
    ( PlayerType
    , FigureMoves
    )


type alias FigureMoves =
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


type alias NextMoves =
    { potentialMoves : List Field
    , potentialCaptures : List Field
    }


type alias Move =
    { potentialMove : Maybe Field
    , potentialCapture : Maybe Field
    }


startPositionPlayer1 : List FigureState
startPositionPlayer1 =
    [ ( Opponent, { figure = Rook, moves = [ { x = 1, y = 1 } ] } )
    , ( Opponent, { figure = Rook, moves = [ { x = 8, y = 1 } ] } )
    , ( Opponent, { figure = Pawn, moves = [ { x = 1, y = 2 } ] } )
    , ( Opponent, { figure = Pawn, moves = [ { x = 2, y = 2 } ] } )
    , ( Opponent, { figure = Pawn, moves = [ { x = 3, y = 2 } ] } )
    , ( Opponent, { figure = Pawn, moves = [ { x = 4, y = 2 } ] } )
    , ( Opponent, { figure = Pawn, moves = [ { x = 5, y = 2 } ] } )
    , ( Opponent, { figure = Pawn, moves = [ { x = 6, y = 2 } ] } )
    , ( Opponent, { figure = Pawn, moves = [ { x = 7, y = 7 } ] } )
    , ( Opponent, { figure = Pawn, moves = [ { x = 8, y = 2 } ] } )
    , ( Opponent, { figure = Knight, moves = [ { x = 2, y = 1 } ] } )
    , ( Opponent, { figure = Knight, moves = [ { x = 7, y = 1 } ] } )
    , ( Opponent, { figure = Bishop, moves = [ { x = 3, y = 1 } ] } )
    , ( Opponent, { figure = Bishop, moves = [ { x = 6, y = 1 } ] } )
    , ( Opponent, { figure = King, moves = [ { x = 5, y = 1 } ] } )
    , ( Opponent, { figure = Queen, moves = [ { x = 4, y = 1 } ] } )
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


startPositionPlayer2 : List FigureState
startPositionPlayer2 =
    [ ( Me, { figure = Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Me, { figure = Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Me, { figure = Rook, moves = [ { x = 6, y = 8 } ] } )
    , ( Me, { figure = Rook, moves = [ { x = 4, y = 3 } ] } )
    , ( Me, { figure = Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Me, { figure = Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Me, { figure = Pawn, moves = [ { x = 1, y = 6 } ] } )

    -- , { figure = Pawn, moves = [ { x = 5, y = 3 } ] }
    -- , { figure = Pawn, moves = [ { x = 1, y = 3 } ] }
    -- , { figure = Pawn, moves = [ { x = 5, y = 7 } ] }
    , ( Me, { figure = Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Me, { figure = Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Me, { figure = Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Me, { figure = Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Me, { figure = Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Me, { figure = Knight, moves = [ { x = 3, y = 6 } ] } )
    , ( Me, { figure = Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Me, { figure = King, moves = [ { x = 5, y = 6 } ] } )
    , ( Me, { figure = Queen, moves = [ { x = 5, y = 5 } ] } )
    ]



-- -}
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


fieldToSpot : Field -> Maybe String
fieldToSpot { x, y } =
    let
        rowList : List Int
        rowList =
            List.range 1 8

        spotLst : Dict ( Int, Int ) String
        spotLst =
            rowList
                |> List.concatMap
                    (\col ->
                        List.map (\row -> ( ( row, col ), indexToLetter row ++ String.fromInt col )) rowList
                    )
                |> Dict.fromList
    in
    spotLst
        |> Dict.get ( x, y )


isEqualPosition : Int -> Int -> Int -> Int -> Bool
isEqualPosition x x1 y y1 =
    x == x1 && y == y1


type
    PossibleNextMove
    -- Next Move - Current Field and Next Move fields and Capture figures
    = NextMove Field NextMoves
    | Idle


type alias Model =
    { player1 : List FigureState
    , player2 : List FigureState
    , possibleNextMoves : PossibleNextMove
    , error : Maybe String
    , player1Captures : List FigureMoves
    , player2Captures : List FigureMoves
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { player1 = startPositionPlayer1
    , player2 = startPositionPlayer2
    , possibleNextMoves = Idle
    , error = Nothing
    , player1Captures = []
    , player2Captures = []
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
    | InitiateCapture
        { figure : Figure
        , x : Int
        , y : Int
        }



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


anyRange : Int -> Int -> List Int
anyRange n1 n2 =
    if n1 > n2 then
        List.range n2 n1

    else
        List.range n1 n2


isOccupiedFieldsXY : Field -> Int -> Int -> Bool
isOccupiedFieldsXY currentField xx yy =
    xx
        == currentField.x
        && yy
        /= currentField.y
        || yy
        == currentField.y
        && xx
        /= currentField.x


isOccupiedFieldsDiagonaly : Field -> Int -> Int -> Bool
isOccupiedFieldsDiagonaly currentField xx yy =
    {-
        my field: 3,5
       -top-right: 4,4 - 5,3 - 6,2 - 7,1
       -top-left: 2,4 - 1,3
       -bottom-right: 4,6 - 5,7 - 6,8
       -bottom-left: 2,6 - 1,7
    -}
    -- bottom/left corner
    let
        topRight =
            List.map2
                (\x y ->
                    if x == xx && y == yy then
                        Just { x = x, y = y }

                    else
                        Nothing
                )
                (anyRange (currentField.x + 1) 8)
                (anyRange (currentField.y - 1) 1
                    |> List.reverse
                )
                |> List.filterMap identity

        topLeft =
            -- I am at top-left
            List.map2
                (\x y ->
                    if x == xx && y == yy then
                        Just { x = x, y = y }

                    else
                        Nothing
                )
                (anyRange (currentField.x - 1) 1
                    |> List.reverse
                )
                (anyRange (currentField.y - 1) 1
                    |> List.reverse
                )
                |> List.filterMap identity

        bottomRight =
            List.map2
                (\x y ->
                    if x == xx && y == yy then
                        Just { x = x, y = y }

                    else
                        Nothing
                )
                (anyRange (currentField.x + 1) 8)
                (anyRange (currentField.y + 1) 8)
                |> List.filterMap identity

        bottomLeft =
            List.map2
                (\x y ->
                    if x == xx && y == yy then
                        Just { x = x, y = y }

                    else
                        Nothing
                )
                (anyRange (currentField.x - 1) 1
                    |> List.reverse
                )
                (anyRange (currentField.y + 1) 8)
                |> List.filterMap identity
    in
    List.concat
        [ topRight
        , topLeft
        , bottomRight
        , bottomLeft
        ]
        |> List.length
        |> (/=) 0


getNextPossibleMoves :
    Figure
    -> Field
    -> List FigureState
    -> List FigureState
    -> NextMoves
getNextPossibleMoves fg currentField opponent myTeam =
    [ opponent, myTeam ]
        |> List.concat
        |> List.filter
            (\( pt, fs ) ->
                fs.moves
                    |> List.head
                    |> Maybe.map
                        (\f ->
                            -- mapping over all figures standing on potential next fields
                            case fg of
                                Pawn ->
                                    --top
                                    (currentField.y - f.y == 1 && currentField.x == f.x)
                                        -- top/right
                                        || (currentField.x + 1 == f.x && currentField.y - 1 == f.y)
                                        -- top/left
                                        || (currentField.x - 1 == f.x && currentField.y - 1 == f.y)

                                -- || (pt == Opponent && currentField.y - f.y == 1 && (currentField.x - 1 == f.x && currentField.x + 1 == f.x))
                                Rook ->
                                    isOccupiedFieldsXY currentField f.x f.y

                                Knight ->
                                    ((currentField.x + 1 == f.x || currentField.x - 1 == f.x) && currentField.y - 2 == f.y)
                                        -- down left/right
                                        || ((currentField.x + 1 == f.x || currentField.x - 1 == f.x) && currentField.y + 2 == f.y)
                                        -- left up/bottom
                                        || ((currentField.y + 1 == f.y || currentField.y - 1 == f.y) && currentField.x - 2 == f.x)
                                        || -- right up/bottom
                                           ((currentField.y + 1 == f.y || currentField.y - 1 == f.y) && currentField.x + 2 == f.x)

                                Bishop ->
                                    isOccupiedFieldsDiagonaly currentField f.x f.y

                                Queen ->
                                    isOccupiedFieldsDiagonaly currentField f.x f.y
                                        || isOccupiedFieldsXY currentField f.x f.y

                                King ->
                                    --top
                                    (currentField.y - f.y == 1 && currentField.x == f.x)
                                        || --bottom
                                           (f.y - currentField.y == 1 && f.x == currentField.x)
                                        -- left
                                        || (currentField.x - f.x == 1 && currentField.y == f.y)
                                        -- right
                                        || (f.x - currentField.x == 1 && f.y == currentField.y)
                                        -- top/right
                                        || (currentField.x + 1 == f.x && currentField.y - 1 == f.y)
                                        -- top/left
                                        || (currentField.x - 1 == f.x && currentField.y - 1 == f.y)
                                        -- bottom/right
                                        || (currentField.x + 1 == f.x && currentField.y + 1 == f.y)
                                        -- bottom/left
                                        || (currentField.x - 1 == f.x && currentField.y + 1 == f.y)
                        )
                    |> Maybe.withDefault False
            )
        |> List.map
            (\( pt, fs ) ->
                fs.moves
                    |> List.head
                    |> Maybe.map (\f -> ( pt, f ))
            )
        |> List.filterMap identity
        |> (\figuresLst ->
                let
                    ( opponentsLst, myFiguresLst ) =
                        List.foldr
                            (\curr sumTuple ->
                                case curr of
                                    ( Opponent, fld ) ->
                                        sumTuple
                                            |> Tuple.mapFirst ((::) fld)

                                    ( Me, fld ) ->
                                        sumTuple
                                            |> Tuple.mapSecond ((::) fld)
                            )
                            ( [], [] )
                            figuresLst
                in
                case fg of
                    Pawn ->
                        getAllPossibleMovesPawn currentField figuresLst

                    Rook ->
                        getAllPossibleXYMoves currentField figuresLst

                    Knight ->
                        { potentialMoves = getAllPossibleMovesForKnight currentField (List.concat [ opponentsLst, myFiguresLst ])
                        , potentialCaptures = opponentsLst
                        }

                    Bishop ->
                        getAllPossibleDiagonalMoves currentField figuresLst

                    Queen ->
                        getAllPossibleMovesForQueen currentField figuresLst

                    King ->
                        getAllPossibleMovesKing currentField opponentsLst myFiguresLst
           )


getAllPossibleMovesKing : Field -> List Field -> List Field -> NextMoves
getAllPossibleMovesKing myPosition opponentsLst myFiguresLst =
    [ { x = myPosition.x, y = myPosition.y - 1 }
    , { x = myPosition.x, y = myPosition.y + 1 }
    , { x = myPosition.x - 1, y = myPosition.y }
    , { x = myPosition.x + 1, y = myPosition.y }
    , { x = myPosition.x + 1, y = myPosition.y + 1 }
    , { x = myPosition.x - 1, y = myPosition.y - 1 }
    , { x = myPosition.x + 1, y = myPosition.y - 1 }
    , { x = myPosition.x - 1, y = myPosition.y + 1 }
    ]
        |> List.filter
            (\field ->
                List.concat [ opponentsLst, myFiguresLst ]
                    |> List.Extra.find (\f -> f == field)
                    |> Maybe.map (\_ -> False)
                    |> Maybe.withDefault True
            )
        |> (\possibleMoves ->
                { potentialMoves = possibleMoves
                , potentialCaptures = opponentsLst
                }
           )


getAllPossibleMovesPawn : Field -> List ( PlayerType, Field ) -> NextMoves
getAllPossibleMovesPawn myPosition figuresLst =
    let
        inFrontOfMe : Field
        inFrontOfMe =
            { x = myPosition.x, y = myPosition.y - 1 }

        transformFigures : List ( Maybe PlayerType, Field )
        transformFigures =
            -- Transform figures so player type can be maybe
            -- giving opportunity to include potential move forward as playerType Nothing
            figuresLst |> List.map (\( ft, f ) -> ( Just ft, f ))
    in
    figuresLst
        |> List.Extra.find
            (\( _, f ) ->
                isEqualPosition f.x myPosition.x f.y (myPosition.y - 1)
            )
        |> Maybe.map
            (\( _, f_ ) ->
                transformFigures
                    |> List.filter
                        (\( _, f1 ) ->
                            not <| isEqualPosition f_.x f1.x f_.y f1.y
                        )
            )
        |> Maybe.withDefault (( Nothing, inFrontOfMe ) :: transformFigures)
        |> List.foldl
            (\( maybePt, f ) sum ->
                maybePt
                    |> Maybe.map
                        (\pt ->
                            case pt of
                                Opponent ->
                                    { sum | potentialCaptures = f :: sum.potentialCaptures }

                                Me ->
                                    sum
                        )
                    |> Maybe.withDefault { sum | potentialMoves = [ f ] }
            )
            (NextMoves [] [])


getAllPossibleXYMoves : Field -> List ( PlayerType, Field ) -> NextMoves
getAllPossibleXYMoves myPosition figureLst =
    let
        fromMeToTop : Field -> List ( PlayerType, Field ) -> List Move
        fromMeToTop currentField lst =
            --go up -> lower number
            let
                nextField : Field
                nextField =
                    { currentField | y = currentField.y - 1 }

                base : Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.y /= 0 then
                case
                    lst
                        |> List.Extra.find
                            (\( pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToTop nextField lst

            else
                []

        fromMeToBottom : Field -> List ( PlayerType, Field ) -> List Move
        fromMeToBottom currentField lst =
            --go down -> bigger number
            let
                nextField : Field
                nextField =
                    { currentField | y = currentField.y + 1 }

                base : Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.y <= 8 then
                case
                    lst
                        |> List.Extra.find
                            (\( pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToBottom nextField lst

            else
                []

        fromMeToLeft : Field -> List ( PlayerType, Field ) -> List Move
        fromMeToLeft currentField lst =
            --go left -> lower number
            let
                nextField : Field
                nextField =
                    { currentField | x = currentField.x - 1 }

                base : Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.x /= 0 then
                case
                    lst
                        |> List.Extra.find
                            (\( pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToLeft nextField lst

            else
                []

        fromMeToRight : Field -> List ( PlayerType, Field ) -> List Move
        fromMeToRight currentField lst =
            --go right -> bigger number
            let
                nextField : Field
                nextField =
                    { currentField | x = currentField.x + 1 }

                base : Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.x <= 8 then
                case
                    lst
                        |> List.Extra.find
                            (\( pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToRight nextField lst

            else
                []

        top : NextMoves
        top =
            fromMeToTop myPosition figureLst
                |> List.foldr
                    (\curr sum ->
                        { sum
                            | potentialCaptures =
                                curr.potentialCapture
                                    |> Maybe.map (\v -> v :: sum.potentialCaptures)
                                    |> Maybe.withDefault sum.potentialCaptures
                            , potentialMoves =
                                curr.potentialMove
                                    |> Maybe.map (\v -> v :: sum.potentialMoves)
                                    |> Maybe.withDefault sum.potentialMoves
                        }
                    )
                    (NextMoves [] [])

        bottom : NextMoves
        bottom =
            fromMeToBottom myPosition figureLst
                |> List.foldr
                    (\curr sum ->
                        { sum
                            | potentialCaptures =
                                curr.potentialCapture
                                    |> Maybe.map (\v -> v :: sum.potentialCaptures)
                                    |> Maybe.withDefault sum.potentialCaptures
                            , potentialMoves =
                                curr.potentialMove
                                    |> Maybe.map (\v -> v :: sum.potentialMoves)
                                    |> Maybe.withDefault sum.potentialMoves
                        }
                    )
                    (NextMoves [] [])

        left : NextMoves
        left =
            fromMeToLeft myPosition figureLst
                |> List.foldr
                    (\curr sum ->
                        { sum
                            | potentialCaptures =
                                curr.potentialCapture
                                    |> Maybe.map (\v -> v :: sum.potentialCaptures)
                                    |> Maybe.withDefault sum.potentialCaptures
                            , potentialMoves =
                                curr.potentialMove
                                    |> Maybe.map (\v -> v :: sum.potentialMoves)
                                    |> Maybe.withDefault sum.potentialMoves
                        }
                    )
                    (NextMoves [] [])

        right : NextMoves
        right =
            fromMeToRight myPosition figureLst
                |> List.foldr
                    (\curr sum ->
                        { sum
                            | potentialCaptures =
                                curr.potentialCapture
                                    |> Maybe.map (\v -> v :: sum.potentialCaptures)
                                    |> Maybe.withDefault sum.potentialCaptures
                            , potentialMoves =
                                curr.potentialMove
                                    |> Maybe.map (\v -> v :: sum.potentialMoves)
                                    |> Maybe.withDefault sum.potentialMoves
                        }
                    )
                    (NextMoves [] [])
    in
    { potentialMoves =
        List.concat
            [ top.potentialMoves
            , bottom.potentialMoves
            , left.potentialMoves
            , right.potentialMoves
            ]
    , potentialCaptures =
        List.concat
            [ top.potentialCaptures
            , bottom.potentialCaptures
            , left.potentialCaptures
            , right.potentialCaptures
            ]
    }


getAllPossibleMovesForKnight : Field -> List Field -> List Field
getAllPossibleMovesForKnight myPosition positionsOfOtherFigures =
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
        [ fromMeToTop myPosition positionsOfOtherFigures
        , fromMeToBottom myPosition positionsOfOtherFigures
        , fromMeToLeft myPosition positionsOfOtherFigures
        , fromMeToRight myPosition positionsOfOtherFigures
        ]


getAllPossibleDiagonalMoves : Field -> List ( PlayerType, Field ) -> NextMoves
getAllPossibleDiagonalMoves myPosition figureLst =
    let
        fromMeToTopRight : Field -> List ( PlayerType, Field ) -> List Move
        fromMeToTopRight currentField lst =
            --go up/right -> lower y, bigger x
            let
                nextField : Field
                nextField =
                    { x = currentField.x + 1, y = currentField.y - 1 }

                base : Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.y <= 8 && nextField.y >= 1 && nextField.x <= 8 && nextField.x >= 1 then
                case
                    lst
                        |> List.Extra.find
                            (\( pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToTopRight nextField lst

            else
                []

        fromMeToBottomRight : Field -> List ( PlayerType, Field ) -> List Move
        fromMeToBottomRight currentField lst =
            --go bottom/right -> bigger y, bigger x
            let
                nextField : Field
                nextField =
                    { x = currentField.x + 1, y = currentField.y + 1 }

                base : Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.y <= 8 && nextField.y >= 1 && nextField.x <= 8 && nextField.x >= 1 then
                case
                    lst
                        |> List.Extra.find
                            (\( pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToBottomRight nextField lst

            else
                []

        fromMeToTopLeft : Field -> List ( PlayerType, Field ) -> List Move
        fromMeToTopLeft currentField lst =
            --go top/left -> bigger y, smaller x
            let
                nextField : Field
                nextField =
                    { x = currentField.x - 1, y = currentField.y - 1 }

                base : Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.y <= 8 && nextField.y >= 1 && nextField.x <= 8 && nextField.x >= 1 then
                case
                    lst
                        |> List.Extra.find
                            (\( pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToTopLeft nextField lst

            else
                []

        fromMeToBottomLeft : Field -> List ( PlayerType, Field ) -> List Move
        fromMeToBottomLeft currentField lst =
            --go top/left -> bigger y, smaller x
            let
                nextField : Field
                nextField =
                    { x = currentField.x - 1, y = currentField.y + 1 }

                base : Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.y <= 8 && nextField.y >= 1 && nextField.x <= 8 && nextField.x >= 1 then
                case
                    lst
                        |> List.Extra.find
                            (\( pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToBottomLeft nextField lst

            else
                []

        topRight : NextMoves
        topRight =
            fromMeToTopRight myPosition figureLst
                |> List.foldr
                    (\curr sum ->
                        { sum
                            | potentialCaptures =
                                curr.potentialCapture
                                    |> Maybe.map (\v -> v :: sum.potentialCaptures)
                                    |> Maybe.withDefault sum.potentialCaptures
                            , potentialMoves =
                                curr.potentialMove
                                    |> Maybe.map (\v -> v :: sum.potentialMoves)
                                    |> Maybe.withDefault sum.potentialMoves
                        }
                    )
                    (NextMoves [] [])

        bottomRight : NextMoves
        bottomRight =
            fromMeToBottomRight myPosition figureLst
                |> List.foldr
                    (\curr sum ->
                        { sum
                            | potentialCaptures =
                                curr.potentialCapture
                                    |> Maybe.map (\v -> v :: sum.potentialCaptures)
                                    |> Maybe.withDefault sum.potentialCaptures
                            , potentialMoves =
                                curr.potentialMove
                                    |> Maybe.map (\v -> v :: sum.potentialMoves)
                                    |> Maybe.withDefault sum.potentialMoves
                        }
                    )
                    (NextMoves [] [])

        topLeft : NextMoves
        topLeft =
            fromMeToTopLeft myPosition figureLst
                |> List.foldr
                    (\curr sum ->
                        { sum
                            | potentialCaptures =
                                curr.potentialCapture
                                    |> Maybe.map (\v -> v :: sum.potentialCaptures)
                                    |> Maybe.withDefault sum.potentialCaptures
                            , potentialMoves =
                                curr.potentialMove
                                    |> Maybe.map (\v -> v :: sum.potentialMoves)
                                    |> Maybe.withDefault sum.potentialMoves
                        }
                    )
                    (NextMoves [] [])

        bottomLeft : NextMoves
        bottomLeft =
            fromMeToBottomLeft myPosition figureLst
                |> List.foldr
                    (\curr sum ->
                        { sum
                            | potentialCaptures =
                                curr.potentialCapture
                                    |> Maybe.map (\v -> v :: sum.potentialCaptures)
                                    |> Maybe.withDefault sum.potentialCaptures
                            , potentialMoves =
                                curr.potentialMove
                                    |> Maybe.map (\v -> v :: sum.potentialMoves)
                                    |> Maybe.withDefault sum.potentialMoves
                        }
                    )
                    (NextMoves [] [])
    in
    { potentialMoves =
        List.concat
            [ topRight.potentialMoves
            , bottomRight.potentialMoves
            , topLeft.potentialMoves
            , bottomLeft.potentialMoves
            ]
    , potentialCaptures =
        List.concat
            [ topRight.potentialCaptures
            , bottomRight.potentialCaptures
            , topLeft.potentialCaptures
            , bottomLeft.potentialCaptures
            ]
    }


getAllPossibleMovesForQueen : Field -> List ( PlayerType, Field ) -> NextMoves
getAllPossibleMovesForQueen myPosition figureLst =
    let
        xyMoves : NextMoves
        xyMoves =
            getAllPossibleXYMoves myPosition figureLst

        diagonalMoves : NextMoves
        diagonalMoves =
            getAllPossibleDiagonalMoves myPosition figureLst
    in
    { potentialCaptures =
        List.concat
            [ xyMoves.potentialCaptures
            , diagonalMoves.potentialCaptures
            ]
    , potentialMoves =
        List.concat
            [ xyMoves.potentialMoves
            , diagonalMoves.potentialMoves
            ]
    }


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
                            nextMoves : NextMoves
                            nextMoves =
                                getNextPossibleMoves
                                    figure
                                    (Field
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
                            , Cmd.none
                            )

                        else
                            -- It's IDLE -> Choosing figure you want to move
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

                Nothing ->
                    case model.possibleNextMoves of
                        NextMove previousField nextMoves ->
                            -- Alright ! Maybe we can move figure, let's check if selected field is among allowed fields !
                            let
                                isOkToMove : Bool
                                isOkToMove =
                                    nextMoves.potentialMoves
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
                                                    (\( pt, fs ) ->
                                                        ( pt
                                                        , { fs
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
                                            | error = Just "Selected figure can't move to that field"
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

        InitiateCapture positionToCapture ->
            case model.possibleNextMoves of
                NextMove attackerCurrentField { potentialCaptures } ->
                    let
                        capturePosition : Maybe FigureState
                        capturePosition =
                            List.Extra.find
                                (\( pt, { figure, moves } ) ->
                                    moves
                                        |> List.head
                                        |> Maybe.map
                                            (\f ->
                                                isEqualPosition f.x positionToCapture.x f.y positionToCapture.y
                                            )
                                        |> Maybe.withDefault False
                                )
                                model.player1

                        updatedPlayer1 : List FigureState
                        updatedPlayer1 =
                            model.player1
                                |> List.filter
                                    (\( pt, { figure, moves } ) ->
                                        moves
                                            |> List.head
                                            |> Maybe.map
                                                (\field ->
                                                    not <| isEqualPosition field.x positionToCapture.x field.y positionToCapture.y
                                                )
                                            |> Maybe.withDefault False
                                    )

                        updatedPlayer2 : List FigureState
                        updatedPlayer2 =
                            model.player2
                                |> List.map
                                    (\( pt, { figure, moves } ) ->
                                        case List.head moves of
                                            Just currentPositon ->
                                                if isEqualPosition currentPositon.x attackerCurrentField.x currentPositon.y attackerCurrentField.y then
                                                    ( pt
                                                    , { figure = figure
                                                      , moves = { x = positionToCapture.x, y = positionToCapture.y } :: moves
                                                      }
                                                    )

                                                else
                                                    ( pt, { figure = figure, moves = moves } )

                                            Nothing ->
                                                ( pt, { figure = figure, moves = moves } )
                                    )
                    in
                    ( { model
                        | possibleNextMoves = Idle
                        , player1 = updatedPlayer1
                        , player2 = updatedPlayer2
                        , player2Captures =
                            case capturePosition of
                                Just captureFigureState ->
                                    (captureFigureState |> Tuple.second) :: model.player2Captures

                                Nothing ->
                                    model.player2Captures
                      }
                    , Cmd.none
                    )

                Idle ->
                    ( { model | error = Just "You need to choose figure first" }, Cmd.none )



-- in
-- ( model, Cmd.none )


findFigureOnThatField : Int -> Int -> List FigureState -> Maybe FigureState
findFigureOnThatField x1 y1 lst =
    lst
        |> List.Extra.find
            (\( _, { moves } ) ->
                List.head moves
                    |> Maybe.map (\{ x, y } -> isEqualPosition x x1 y y1)
                    |> Maybe.withDefault False
            )


coordinatesToFigure : Int -> Int -> List FigureState -> Maybe Figure
coordinatesToFigure x1 y1 lst =
    lst
        |> findFigureOnThatField x1 y1
        |> Maybe.map (\( _, fs ) -> fs.figure)


isMyFigure : Int -> Int -> List FigureState -> Bool
isMyFigure x y lst =
    findFigureOnThatField x y lst
        |> Maybe.Extra.isJust


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

        isPotenitalMove : Bool
        isPotenitalMove =
            case possibleNextMoves of
                NextMove _ nextMoves ->
                    nextMoves.potentialMoves
                        |> List.filter (\{ x, y } -> isEqualPosition xIndex x yIndex y)
                        |> List.length
                        |> (/=) 0

                Idle ->
                    False

        isMyFigure_ : Bool
        isMyFigure_ =
            isMyFigure xIndex yIndex player2

        isPotenitalCapture : Bool
        isPotenitalCapture =
            case possibleNextMoves of
                NextMove _ nextMoves ->
                    nextMoves.potentialCaptures
                        |> List.Extra.find
                            (\{ x, y } -> isEqualPosition xIndex x yIndex y)
                        |> Maybe.Extra.isJust

                Idle ->
                    False

        position : Position
        position =
            { figure = maybeFigure, x = xIndex, y = yIndex }
    in
    Html.div
        [ HE.onClick <|
            if isMyFigure_ || maybeFigure == Nothing then
                InitiateMove position

            else
                case maybeFigure of
                    Just fg ->
                        InitiateCapture { figure = fg, x = position.x, y = position.y }

                    Nothing ->
                        NoOp
        , HA.class <|
            "relative cursor-pointer flex w-[100px] h-[100px]"
                ++ (if isPotenitalMove then
                        " bg-green-100"

                    else if isPotenitalCapture then
                        " bg-red-500"

                    else
                        ""
                   )
                ++ (case getPossitionOfActiveFigure possibleNextMoves of
                        Just { x, y } ->
                            if isEqualPosition x xIndex y yIndex then
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
        [ HA.class "flex flex-col border border-white" ]
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
        , capturesView model
        ]


capturesView : Model -> Html Msg
capturesView model =
    Html.div
        []
        [ Html.ul
            []
            (List.map
                (\{ figure, moves } ->
                    -- TODO make player2Captures to have only figure and field that figure had when it was capture
                    Html.li
                        []
                        [ figureToHtml (Just figure)
                        , Html.p []
                            [ moves
                                |> List.head
                                |> Maybe.andThen
                                    (\lastHeldField ->
                                        fieldToSpot lastHeldField
                                    )
                                |> Maybe.withDefault ""
                                |> Html.text
                            ]
                        ]
                )
                model.player2Captures
            )
        ]
