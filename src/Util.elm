module Util exposing (..)

import BackendUtil
import Dict exposing (Dict)
import Json.Decode
import List.Extra
import Ports
import Types
import Url exposing (Url)


subscribeOnTimestamp : (Int -> msg) -> Sub msg
subscribeOnTimestamp toMsg =
    Ports.onTimestamp (\val -> toMsg (decodeInt val))


getFigureBasedOnField : Int -> Int -> List Types.FigureState -> Maybe Types.Figure
getFigureBasedOnField x y lst =
    lst
        |> List.Extra.find
            (\( _, { moves } ) ->
                List.head moves == Just (Types.Field x y)
            )
        |> Maybe.map (Tuple.second >> .figure)


mapToFigureColor : Maybe String -> Maybe Types.FigureColor
mapToFigureColor ms =
    ms
        |> Maybe.map
            (\str ->
                if str == "true" then
                    Just Types.Black

                else
                    Nothing
            )
        |> Maybe.withDefault (Just Types.White)


decodeInt : Json.Decode.Value -> Int
decodeInt val =
    case Json.Decode.decodeValue Json.Decode.int val |> Result.toMaybe of
        Just int_ ->
            int_

        Nothing ->
            0


{-| Is any opponent giving chess to my king AFTER I moved ?
If so, I can't move, I need to move king, capture opponent or stand in front of opp
-}
numberOfFiguresThatThreatToKing : ( List Types.FigureState, Types.PlayerStatus ) -> ( List Types.FigureState, Types.PlayerStatus ) -> List Types.Figure
numberOfFiguresThatThreatToKing opponent me =
    let
        convertMeToOppPlayer : ( List Types.FigureState, Types.PlayerStatus )
        convertMeToOppPlayer =
            -- we just switch from `Me` to `Opponent` and mirror fields
            me
                |> Tuple.mapFirst BackendUtil.convertRoles

        convertOppToMePlayer : ( List Types.FigureState, Types.PlayerStatus )
        convertOppToMePlayer =
            opponent
                |> Tuple.mapFirst BackendUtil.convertRoles
    in
    opponent
        |> Tuple.first
        |> List.foldr
            (\( pt, { figure, moves } ) sum ->
                case List.head moves of
                    Just field ->
                        let
                            isKingStillInChess : Bool
                            isKingStillInChess =
                                -- We need to turn perspective upside down, not just role switch, but to mirror moves
                                getNextPossibleMoves
                                    Types.Me
                                    figure
                                    { x = BackendUtil.coordinateInMirror field.x
                                    , y = BackendUtil.coordinateInMirror field.y
                                    }
                                    convertMeToOppPlayer
                                    convertOppToMePlayer
                                    |> .potentialCaptures
                                    |> List.filter
                                        (\f -> getFigureBasedOnField f.x f.y (Tuple.first convertMeToOppPlayer) == Just Types.King)
                                    |> List.length
                                    |> (/=) 0
                        in
                        if isKingStillInChess then
                            figure :: sum

                        else
                            sum

                    Nothing ->
                        sum
            )
            []


isEqualPosition : Int -> Int -> Int -> Int -> Bool
isEqualPosition x x1 y y1 =
    x == x1 && y == y1


getBaseUrl : Url -> String
getBaseUrl u =
    case u.port_ of
        Nothing ->
            "https://" ++ u.host ++ "/"

        Just p ->
            "http://"
                ++ u.host
                ++ ":"
                ++ (p |> String.fromInt)
                ++ "/"


indexToLetter : Types.FigureColor -> Int -> String
indexToLetter figureColor idx =
    case figureColor of
        Types.Black ->
            case idx of
                1 ->
                    "H"

                2 ->
                    "G"

                3 ->
                    "F"

                4 ->
                    "E"

                5 ->
                    "D"

                6 ->
                    "C"

                7 ->
                    "B"

                _ ->
                    "A"

        Types.White ->
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


fieldToSpot : Types.FigureColor -> Types.Field -> String
fieldToSpot figureColor { x, y } =
    let
        sideTableNum : String
        sideTableNum =
            case figureColor of
                Types.Black ->
                    y |> String.fromInt

                Types.White ->
                    (9 - y) |> String.fromInt
    in
    indexToLetter figureColor x ++ sideTableNum


isOccupiedFieldsXY : Types.Field -> Int -> Int -> Bool
isOccupiedFieldsXY currentField xx yy =
    xx
        == currentField.x
        && yy
        /= currentField.y
        || yy
        == currentField.y
        && xx
        /= currentField.x


anyRange : Int -> Int -> List Int
anyRange n1 n2 =
    if n1 > n2 then
        List.range n2 n1

    else
        List.range n1 n2


isOccupiedFieldsDiagonaly : Types.Field -> Int -> Int -> Bool
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
    Types.PlayerType
    -> Types.Figure
    -> Types.Field
    -> ( List Types.FigureState, Types.PlayerStatus )
    -> ( List Types.FigureState, Types.PlayerStatus )
    -> Types.NextMoves
getNextPossibleMoves playerType fg currentField ( opponent, _ ) ( myTeam, _ ) =
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
                                Types.Pawn ->
                                    --top
                                    (currentField.y - f.y == 1 && currentField.x == f.x)
                                        -- top/right
                                        || (currentField.x + 1 == f.x && currentField.y - 1 == f.y)
                                        -- top/left
                                        || (currentField.x - 1 == f.x && currentField.y - 1 == f.y)

                                -- || (pt == Opponent && currentField.y - f.y == 1 && (currentField.x - 1 == f.x && currentField.x + 1 == f.x))
                                Types.Rook ->
                                    isOccupiedFieldsXY currentField f.x f.y

                                Types.Knight ->
                                    ((currentField.x + 1 == f.x || currentField.x - 1 == f.x) && currentField.y - 2 == f.y)
                                        -- down left/right
                                        || ((currentField.x + 1 == f.x || currentField.x - 1 == f.x) && currentField.y + 2 == f.y)
                                        -- left up/bottom
                                        || ((currentField.y + 1 == f.y || currentField.y - 1 == f.y) && currentField.x - 2 == f.x)
                                        || -- right up/bottom
                                           ((currentField.y + 1 == f.y || currentField.y - 1 == f.y) && currentField.x + 2 == f.x)

                                Types.Bishop ->
                                    isOccupiedFieldsDiagonaly currentField f.x f.y

                                Types.Queen ->
                                    isOccupiedFieldsDiagonaly currentField f.x f.y
                                        || isOccupiedFieldsXY currentField f.x f.y

                                Types.King ->
                                    --Due to special logic for capture and move we need to let every figure pass
                                    True
                        )
                    |> Maybe.withDefault False
            )
        |> List.map
            (\( pt, fs ) ->
                fs.moves
                    |> List.head
                    |> Maybe.map (\f -> ( fs.figure, pt, f ))
            )
        |> List.filterMap identity
        |> (\figuresLst ->
                let
                    ( opponentsLst, myFiguresLst ) =
                        List.foldr
                            (\curr sumTuple ->
                                case curr of
                                    ( figure, Types.Opponent, fld ) ->
                                        sumTuple
                                            |> Tuple.mapFirst ((::) ( figure, fld ))

                                    ( figure, Types.Me, fld ) ->
                                        sumTuple
                                            |> Tuple.mapSecond ((::) ( figure, fld ))
                            )
                            ( [], [] )
                            figuresLst
                in
                case fg of
                    Types.Pawn ->
                        getAllPossibleMovesPawn currentField figuresLst

                    Types.Rook ->
                        getAllPossibleXYMoves currentField figuresLst

                    Types.Knight ->
                        { potentialMoves = getAllPossibleMovesForKnight currentField (List.concat [ opponentsLst, myFiguresLst ])
                        , potentialCaptures = opponentsLst |> List.map Tuple.second
                        }

                    Types.Bishop ->
                        getAllPossibleDiagonalMoves currentField figuresLst

                    Types.Queen ->
                        getAllPossibleMovesForQueen currentField figuresLst

                    Types.King ->
                        getAllPossibleMovesKing currentField opponentsLst myFiguresLst figuresLst
           )


getAllPossibleMovesKing : Types.Field -> List ( Types.Figure, Types.Field ) -> List ( Types.Figure, Types.Field ) -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> Types.NextMoves
getAllPossibleMovesKing myPosition opponentsLst myFiguresLst allFiguresLst =
    let
        opponentsLstThatArePotentialCaptures : List Types.Field
        opponentsLstThatArePotentialCaptures =
            opponentsLst
                |> List.filter
                    (\( _, opponentField ) ->
                        (myPosition.y - opponentField.y == 1 && myPosition.x == opponentField.x)
                            || --bottom
                               (opponentField.y - myPosition.y == 1 && opponentField.x == myPosition.x)
                            -- left
                            || (myPosition.x - opponentField.x == 1 && myPosition.y == opponentField.y)
                            -- right
                            || (opponentField.x - myPosition.x == 1 && opponentField.y == myPosition.y)
                            -- top/right
                            || (myPosition.x + 1 == opponentField.x && myPosition.y - 1 == opponentField.y)
                            -- top/left
                            || (myPosition.x - 1 == opponentField.x && myPosition.y - 1 == opponentField.y)
                            -- bottom/right
                            || (myPosition.x + 1 == opponentField.x && myPosition.y + 1 == opponentField.y)
                            -- bottom/left
                            || (myPosition.x - 1 == opponentField.x && myPosition.y + 1 == opponentField.y)
                    )
                |> List.map Tuple.second
    in
    [ { x = myPosition.x, y = myPosition.y - 1 }
    , { x = myPosition.x, y = myPosition.y + 1 }
    , { x = myPosition.x - 1, y = myPosition.y }
    , { x = myPosition.x + 1, y = myPosition.y }
    , { x = myPosition.x + 1, y = myPosition.y + 1 }
    , { x = myPosition.x - 1, y = myPosition.y - 1 }
    , { x = myPosition.x + 1, y = myPosition.y - 1 }
    , { x = myPosition.x - 1, y = myPosition.y + 1 }
    ]
        |> List.foldr
            (\field sum ->
                let
                    isMyFigureOnPotentialNextField =
                        List.member field (myFiguresLst |> List.map (\( _, f ) -> f))

                    unavailableMoves : List ( Types.Figure, Types.PlayerType, Types.Field )
                    unavailableMoves =
                        if List.concat [ myFiguresLst ] |> List.filter (\( _, f ) -> isEqualPosition f.x field.x f.y field.y) |> List.isEmpty then
                            allFiguresLst
                                |> List.foldr
                                    (\( currentFigure, pt, currentField ) sum_ ->
                                        case pt of
                                            Types.Opponent ->
                                                case currentFigure of
                                                    Types.Pawn ->
                                                        if
                                                            (currentField.y + field.y == 1 && currentField.x == field.x)
                                                                -- top/right
                                                                || (currentField.x + 1 == field.x && currentField.y + 1 == field.y)
                                                                -- top/left
                                                                || (currentField.x - 1 == field.x && currentField.y + 1 == field.y)
                                                        then
                                                            getAllPossibleMovesPawn currentField [ ( Types.King, Types.Opponent, field ) ]
                                                                |> .potentialCaptures
                                                                |> List.Extra.find
                                                                    (\f_ -> f_ == field)
                                                                |> Maybe.map (\field_ -> ( currentFigure, pt, field_ ) :: sum_)
                                                                |> Maybe.withDefault sum_

                                                        else
                                                            sum_

                                                    Types.Rook ->
                                                        getAllPossibleXYMoves currentField (( Types.King, Types.Opponent, field ) :: allFiguresLst)
                                                            |> .potentialCaptures
                                                            |> List.Extra.find
                                                                (\f_ -> f_ == field)
                                                            |> Maybe.map (\field_ -> ( currentFigure, pt, field_ ) :: sum_)
                                                            |> Maybe.withDefault sum_

                                                    Types.Knight ->
                                                        ((currentField.x + 1 == field.x || currentField.x - 1 == field.x) && currentField.y - 2 == field.y)
                                                            -- down left/right
                                                            || ((currentField.x + 1 == field.x || currentField.x - 1 == field.x) && currentField.y + 2 == field.y)
                                                            -- left up/bottom
                                                            || ((currentField.y + 1 == field.y || currentField.y - 1 == field.y) && currentField.x - 2 == field.x)
                                                            || -- right up/bottom
                                                               ((currentField.y + 1 == field.y || currentField.y - 1 == field.y) && currentField.x + 2 == field.x)
                                                            |> (\isTrue ->
                                                                    if isTrue then
                                                                        ( currentFigure, pt, field ) :: sum_

                                                                    else
                                                                        sum_
                                                               )

                                                    Types.Bishop ->
                                                        getAllPossibleDiagonalMoves currentField (( Types.King, Types.Opponent, field ) :: allFiguresLst)
                                                            |> .potentialCaptures
                                                            |> List.Extra.find
                                                                (\f_ -> f_ == field)
                                                            |> Maybe.map (\field_ -> ( currentFigure, pt, field_ ) :: sum_)
                                                            |> Maybe.withDefault sum_

                                                    Types.Queen ->
                                                        getAllPossibleMovesForQueen currentField (( Types.King, Types.Opponent, field ) :: allFiguresLst)
                                                            |> .potentialCaptures
                                                            |> List.Extra.find
                                                                (\f_ -> f_ == field)
                                                            |> Maybe.map (\field_ -> ( currentFigure, pt, field_ ) :: sum_)
                                                            |> Maybe.withDefault sum_

                                                    Types.King ->
                                                        if pt == Types.Opponent then
                                                            (currentField.y - field.y == 1 && currentField.x == field.x)
                                                                || --bottom
                                                                   (field.y - currentField.y == 1 && field.x == currentField.x)
                                                                -- left
                                                                || (currentField.x - field.x == 1 && currentField.y == field.y)
                                                                -- right
                                                                || (field.x - currentField.x == 1 && field.y == currentField.y)
                                                                -- top/right
                                                                || (currentField.x + 1 == field.x && currentField.y - 1 == field.y)
                                                                -- top/left
                                                                || (currentField.x - 1 == field.x && currentField.y - 1 == field.y)
                                                                -- bottom/right
                                                                || (currentField.x + 1 == field.x && currentField.y + 1 == field.y)
                                                                -- bottom/left
                                                                || (currentField.x - 1 == field.x && currentField.y + 1 == field.y)
                                                                |> (\isTrue ->
                                                                        if isTrue then
                                                                            ( currentFigure, pt, field ) :: sum_

                                                                        else
                                                                            sum_
                                                                   )

                                                        else
                                                            sum_

                                            Types.Me ->
                                                sum_
                                    )
                                    []

                        else
                            []
                in
                if List.member field (unavailableMoves |> List.map (\( _, _, f ) -> f)) then
                    { sum
                        | potentialCaptures =
                            List.filter (\f_ -> f_ /= field) sum.potentialCaptures
                    }

                else if not isMyFigureOnPotentialNextField && (not <| List.member field sum.potentialCaptures) then
                    { sum | potentialMoves = field :: sum.potentialMoves }

                else
                    sum
            )
            { potentialMoves = []
            , potentialCaptures = opponentsLstThatArePotentialCaptures
            }


getAllPossibleMovesPawn : Types.Field -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> Types.NextMoves
getAllPossibleMovesPawn myPosition figuresLst =
    -- `reverse` to make it work for preventing King from moving to unavailable field
    let
        inFrontOfMe : Types.Field
        inFrontOfMe =
            { x = myPosition.x
            , y = myPosition.y - 1
            }

        transformFigures : List ( Maybe Types.PlayerType, Types.Field )
        transformFigures =
            -- Transform figures so player type can be maybe
            -- giving opportunity to include potential move forward as playerType Nothing
            figuresLst |> List.map (\( _, ft, f ) -> ( Just ft, f ))
    in
    figuresLst
        |> List.Extra.find
            (\( _, _, f ) ->
                isEqualPosition f.x
                    myPosition.x
                    f.y
                    (myPosition.y - 1)
            )
        |> Maybe.map
            (\( _, _, f_ ) ->
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
                                Types.Opponent ->
                                    { sum | potentialCaptures = f :: sum.potentialCaptures }

                                Types.Me ->
                                    sum
                        )
                    |> Maybe.withDefault { sum | potentialMoves = [ f ] }
            )
            (Types.NextMoves [] [])


getAllPossibleXYMoves : Types.Field -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> Types.NextMoves
getAllPossibleXYMoves myPosition figureLst =
    let
        fromMeToTop : Types.Field -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> List Types.Move
        fromMeToTop currentField lst =
            --go up -> lower number
            let
                nextField : Types.Field
                nextField =
                    { currentField | y = currentField.y - 1 }

                base : Types.Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.y /= 0 then
                case
                    lst
                        |> List.Extra.find
                            (\( _, pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( _, pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Types.Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Types.Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToTop nextField lst

            else
                []

        fromMeToBottom : Types.Field -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> List Types.Move
        fromMeToBottom currentField lst =
            --go down -> bigger number
            let
                nextField : Types.Field
                nextField =
                    { currentField | y = currentField.y + 1 }

                base : Types.Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.y <= 8 then
                case
                    lst
                        |> List.Extra.find
                            (\( _, pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( _, pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Types.Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Types.Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToBottom nextField lst

            else
                []

        fromMeToLeft : Types.Field -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> List Types.Move
        fromMeToLeft currentField lst =
            --go left -> lower number
            let
                nextField : Types.Field
                nextField =
                    { currentField | x = currentField.x - 1 }

                base : Types.Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.x /= 0 then
                case
                    lst
                        |> List.Extra.find
                            (\( _, pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( _, pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Types.Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Types.Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToLeft nextField lst

            else
                []

        fromMeToRight : Types.Field -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> List Types.Move
        fromMeToRight currentField lst =
            --go right -> bigger number
            let
                nextField : Types.Field
                nextField =
                    { currentField | x = currentField.x + 1 }

                base : Types.Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.x <= 8 then
                case
                    lst
                        |> List.Extra.find
                            (\( _, pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( _, pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Types.Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Types.Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToRight nextField lst

            else
                []

        top : Types.NextMoves
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
                    (Types.NextMoves [] [])

        bottom : Types.NextMoves
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
                    (Types.NextMoves [] [])

        left : Types.NextMoves
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
                    (Types.NextMoves [] [])

        right : Types.NextMoves
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
                    (Types.NextMoves [] [])
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


getAllPossibleMovesForKnight : Types.Field -> List ( Types.Figure, Types.Field ) -> List Types.Field
getAllPossibleMovesForKnight myPosition positionsOfOtherFigures =
    let
        fromMeToTop : Types.Field -> List ( Types.Figure, Types.Field ) -> List Types.Field
        fromMeToTop currentField lst =
            --go up -> lower number
            let
                nextFields : List Types.Field
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
                            (\( _, f1 ) ->
                                isEqualPosition f.x f1.x f.y f1.y
                            )
                        |> not
                )
                nextFields

        fromMeToBottom : Types.Field -> List ( Types.Figure, Types.Field ) -> List Types.Field
        fromMeToBottom currentField lst =
            --go down -> bigger number
            let
                nextFields : List Types.Field
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
                            (\( _, f1 ) ->
                                isEqualPosition f.x f1.x f.y f1.y
                            )
                        |> not
                )
                nextFields

        fromMeToLeft : Types.Field -> List ( Types.Figure, Types.Field ) -> List Types.Field
        fromMeToLeft currentField lst =
            --go left -> lower number
            let
                nextFields : List Types.Field
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
                            (\( _, f1 ) ->
                                isEqualPosition f.x f1.x f.y f1.y
                            )
                        |> not
                )
                nextFields

        fromMeToRight : Types.Field -> List ( Types.Figure, Types.Field ) -> List Types.Field
        fromMeToRight currentField lst =
            --go right -> bigger number
            let
                nextFields : List Types.Field
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
                            (\( _, f1 ) ->
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


getAllPossibleDiagonalMoves : Types.Field -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> Types.NextMoves
getAllPossibleDiagonalMoves myPosition figureLst =
    let
        fromMeToTopRight : Types.Field -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> List Types.Move
        fromMeToTopRight currentField lst =
            --go up/right -> lower y, bigger x
            let
                nextField : Types.Field
                nextField =
                    { x = currentField.x + 1, y = currentField.y - 1 }

                base : Types.Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.y <= 8 && nextField.y >= 1 && nextField.x <= 8 && nextField.x >= 1 then
                case
                    lst
                        |> List.Extra.find
                            (\( _, pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( _, pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Types.Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Types.Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToTopRight nextField lst

            else
                []

        fromMeToBottomRight : Types.Field -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> List Types.Move
        fromMeToBottomRight currentField lst =
            --go bottom/right -> bigger y, bigger x
            let
                nextField : Types.Field
                nextField =
                    { x = currentField.x + 1, y = currentField.y + 1 }

                base : Types.Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.y <= 8 && nextField.y >= 1 && nextField.x <= 8 && nextField.x >= 1 then
                case
                    lst
                        |> List.Extra.find
                            (\( _, pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( _, pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Types.Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Types.Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToBottomRight nextField lst

            else
                []

        fromMeToTopLeft : Types.Field -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> List Types.Move
        fromMeToTopLeft currentField lst =
            --go top/left -> bigger y, smaller x
            let
                nextField : Types.Field
                nextField =
                    { x = currentField.x - 1, y = currentField.y - 1 }

                base : Types.Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.y <= 8 && nextField.y >= 1 && nextField.x <= 8 && nextField.x >= 1 then
                case
                    lst
                        |> List.Extra.find
                            (\( _, pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( _, pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Types.Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Types.Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToTopLeft nextField lst

            else
                []

        fromMeToBottomLeft : Types.Field -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> List Types.Move
        fromMeToBottomLeft currentField lst =
            --go top/left -> bigger y, smaller x
            let
                nextField : Types.Field
                nextField =
                    { x = currentField.x - 1, y = currentField.y + 1 }

                base : Types.Move
                base =
                    { potentialMove = Nothing, potentialCapture = Nothing }
            in
            if nextField.y <= 8 && nextField.y >= 1 && nextField.x <= 8 && nextField.x >= 1 then
                case
                    lst
                        |> List.Extra.find
                            (\( _, pt, f ) -> isEqualPosition nextField.x f.x nextField.y f.y)
                of
                    Just ( _, pt, f ) ->
                        -- closest figure found -> we care only for opponent
                        case pt of
                            Types.Opponent ->
                                [ { base | potentialCapture = Just f } ]

                            Types.Me ->
                                []

                    Nothing ->
                        { base | potentialMove = Just nextField } :: fromMeToBottomLeft nextField lst

            else
                []

        topRight : Types.NextMoves
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
                    (Types.NextMoves [] [])

        bottomRight : Types.NextMoves
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
                    (Types.NextMoves [] [])

        topLeft : Types.NextMoves
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
                    (Types.NextMoves [] [])

        bottomLeft : Types.NextMoves
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
                    (Types.NextMoves [] [])
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


getAllPossibleMovesForQueen : Types.Field -> List ( Types.Figure, Types.PlayerType, Types.Field ) -> Types.NextMoves
getAllPossibleMovesForQueen myPosition figureLst =
    let
        xyMoves : Types.NextMoves
        xyMoves =
            getAllPossibleXYMoves myPosition figureLst

        diagonalMoves : Types.NextMoves
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
