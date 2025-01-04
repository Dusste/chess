module Main exposing (main)

import Browser
import Dict
import Html exposing (Html, th)
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



-- MODEL
-- type Horizontal
--     = A
--     | B
--     | C
--     | D
--     | E
--     | F
--     | G
--     | H
-- horizontalToString : Horizontal -> String
-- horizontalToString hz =
--     case hz of
--         A ->
--             "A"
--         B ->
--             "B"
--         C ->
--             "C"
--         D ->
--             "D"
--         E ->
--             "E"
--         F ->
--             "F"
--         G ->
--             "G"
--         H ->
--             "H"
-- stringToHorizantal : String -> Horizontal
-- stringToHorizantal str =
--     case str of
--         "A" ->
--             A
--         "B" ->
--             B
--         "C" ->
--             C
--         "D" ->
--             D
--         "E" ->
--             E
--         "F" ->
--             F
--         "G" ->
--             G
--         _ ->
--             H
-- type Vertical
--     = One
--     | Two
--     | Three
--     | Four
--     | Five
--     | Six
--     | Seven
--     | Eight
-- verticalToString : Vertical -> String
-- verticalToString hz =
--     case hz of
--         One ->
--             "1"
--         Two ->
--             "2"
--         Three ->
--             "3"
--         Four ->
--             "4"
--         Five ->
--             "5"
--         Six ->
--             "6"
--         Seven ->
--             "7"
--         Eight ->
--             "8"
-- intToVertical : Int -> Vertical
-- intToVertical num =
--     case num of
--         1 ->
--             One
--         2 ->
--             Two
--         3 ->
--             Three
--         4 ->
--             Four
--         5 ->
--             Five
--         6 ->
--             Six
--         7 ->
--             Seven
--         _ ->
--             Eight


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
    , { figure = Knight, moves = [ { x = 2, y = 8 } ] }
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


calcNextMovesBasedOnFigure : Figure -> Int -> Int -> List FigureState -> List FigureState -> List Field
calcNextMovesBasedOnFigure fg x y player1 player2 =
    let
        positionsOfMyOtherFigures : ( List Field, List Field )
        positionsOfMyOtherFigures =
            ( getPositionsOfMyOtherFigures X (Field x y) player2
            , getPositionsOfMyOtherFigures Y (Field x y) player2
            )
    in
    case fg of
        Pawn ->
            let
                result =
                    moveByAxisPerFigure.pawn (Field x y) (positionsOfMyOtherFigures |> Tuple.first)
            in
            result

        Rook ->
            let
                myClosestFigures =
                    List.concat
                        [ Tuple.first positionsOfMyOtherFigures
                        , Tuple.second positionsOfMyOtherFigures
                        ]
                        |> getClosestFigures (Field x y)

                result =
                    moveByAxisPerFigure.rook (Field x y) myClosestFigures

                -- result =
                --     [ moveByAxisPerFigure.rook X (Field x y) (positionsOfMyOtherFigures |> Tuple.first)
                --     , moveByAxisPerFigure.rook Y (Field x y) (positionsOfMyOtherFigures |> Tuple.second)
                --     ]
                --         |> List.concat
                -- |> Debug.log "getAllPossibleMovesByAxisForRook"
                -- |> List.minimum
            in
            -- positionsOfMyOtherFigures
            result

        -- |> List.filter
        --     (\m ->
        --         let
        --             List.maximum (abs (y - m.y))
        --         in
        --     )
        -- List.repeat
        --     number_of_columns
        --     { x = number_of_rows, y = number_of_columns }
        --     |> List.map (\curr -> { x = curr.x - 1, y = curr.y - 1 })
        -- _ ->
        --     []
        _ ->
            []


figureElement : String -> Html msg
figureElement txt =
    Html.div [ HA.class "font-extrabold" ] [ Html.text txt ]


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
    -- Next Move - Current Field and Next Potential fields
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


getPositionsOfMyOtherFigures : Axis -> Field -> List FigureState -> List Field
getPositionsOfMyOtherFigures axis currentField myTeam =
    {-
       For X, it will return whole vertical
       For Y, it will return whole horizontal
    -}
    myTeam
        |> List.filter
            (\fs ->
                fs.moves
                    |> List.head
                    -- have other then me Figures in the same column / row
                    |> Maybe.Extra.filter
                        (\m ->
                            case axis of
                                X ->
                                    m.x == currentField.x && m.y /= currentField.y

                                Y ->
                                    m.y == currentField.y && m.x /= currentField.x
                        )
                    |> Maybe.Extra.isJust
            )
        |> List.map (\fs -> fs.moves |> List.head)
        |> List.filterMap identity


type alias MoveByAxisPerFigure =
    { pawn : Field -> List Field -> List Field
    , rook : Axis -> Field -> List Field -> List Field
    , knight : ()
    , bishop : ()
    , queen : ()
    , king : ()
    }


getAllPossibleMovesByAxisForPawn : Field -> List Field -> List Field
getAllPossibleMovesByAxisForPawn currentField positionsOfMyOtherFigures =
    let
        obstacle : Maybe Field
        obstacle =
            -- maybe directly in front of us
            positionsOfMyOtherFigures
                |> List.Extra.find
                    (\f -> currentField.y > f.y && currentField.y - f.y == 1)
    in
    if obstacle |> Maybe.Extra.isJust then
        []

    else
        [ { x = currentField.x
          , y = currentField.y - 1
          }
        ]


moveByAxisPerFigure =
    { pawn = getAllPossibleMovesByAxisForPawn
    , rook = getAllPossibleMovesByAxisForRook
    , knight = ()
    , bishop = ()
    , queen = ()
    , king = ()
    }


fromMeToTop : Field -> List Field -> Maybe Field
fromMeToTop target lst =
    --go up -> lower number
    if target.y /= 0 then
        case List.Extra.find (\f -> target.x == f.x && target.y == f.y) lst of
            Just found ->
                Just found

            Nothing ->
                fromMeToTop { y = target.y - 1, x = target.x } lst

    else
        Nothing


fromMeToBottom : Field -> List Field -> Maybe Field
fromMeToBottom target lst =
    --go down -> bigger number
    if target.y <= 8 then
        case List.Extra.find (\f -> target.x == f.x && target.y == f.y) lst of
            Just found ->
                Just found

            Nothing ->
                fromMeToBottom { y = target.y + 1, x = target.x } lst

    else
        Nothing


fromMeToLeft : Field -> List Field -> Maybe Field
fromMeToLeft target lst =
    --go left -> lower number
    if target.x /= 0 then
        case List.Extra.find (\f -> target.y == f.y && target.x == f.x) lst of
            Just found ->
                Just found

            Nothing ->
                fromMeToLeft { x = target.x - 1, y = target.y } lst

    else
        Nothing


fromMeToRight : Field -> List Field -> Maybe Field
fromMeToRight target lst =
    --go right -> bigger number
    if target.x <= 8 then
        case List.Extra.find (\f -> target.y == f.y && target.x == f.x) lst of
            Just found ->
                Just found

            Nothing ->
                fromMeToRight { x = target.x + 1, y = target.y } lst

    else
        Nothing


type alias MyClosestFiguresPerDirection =
    { toTop : Maybe Field
    , toBottom : Maybe Field
    , toLeft : Maybe Field
    , toRight : Maybe Field
    }


getClosestFigures : Field -> List Field -> MyClosestFiguresPerDirection
getClosestFigures currentField lst =
    -- returns closest figures in all four directions, up, down, left, right
    -- if Nothing then your road is clear in that direction
    { toTop = fromMeToTop currentField lst
    , toBottom = fromMeToBottom currentField lst
    , toLeft = fromMeToLeft currentField lst
    , toRight = fromMeToRight currentField lst
    }


getAllPossibleMovesByAxisForRook : Field -> MyClosestFiguresPerDirection -> List Field
getAllPossibleMovesByAxisForRook currentField fgPositions =
    List.concat
        [ List.range
            (fgPositions.toTop
                |> Maybe.map (\{ x, y } -> { x = x, y = y + 1 })
                |> Maybe.withDefault { x = currentField.x, y = 1 }
                |> .y
            )
            (currentField.y - 1)
            |> List.map (\y -> { y = y, x = currentField.x })
        , List.range
            (currentField.y + 1)
            (fgPositions.toBottom
                |> Maybe.map (\{ x, y } -> { x = x, y = y - 1 })
                |> Maybe.withDefault { x = currentField.x, y = 8 }
                |> .y
            )
            |> List.map (\y -> { y = y, x = currentField.x })
        , List.range
            (fgPositions.toLeft
                |> Maybe.map (\{ x, y } -> { y = y, x = x + 1 })
                |> Maybe.withDefault { y = currentField.y, x = 1 }
                |> .x
            )
            (currentField.x - 1)
            |> List.map (\x -> { y = currentField.y, x = x })
        , List.range
            (currentField.x + 1)
            (fgPositions.toRight
                |> Maybe.map (\{ x, y } -> { y = y, x = x - 1 })
                |> Maybe.withDefault { y = currentField.y, x = 8 }
                |> .x
            )
            |> List.map (\x -> { y = currentField.y, x = x })
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
                                calcNextMovesBasedOnFigure
                                    figure
                                    desiredOrCurrentPosition.x
                                    desiredOrCurrentPosition.y
                                    model.player1
                                    model.player2

                            cannotMove : Bool
                            cannotMove =
                                nextMoves
                                    |> List.length
                                    |> (==) 0

                            -- nextMoves
                            --     |> List.filter
                            --         (\nextMove ->
                            --             coordinatesToFigure
                            --                 nextMove.x
                            --                 nextMove.y
                            --                 (List.concat [ model.player1, model.player2 ])
                            --                 |> Maybe.Extra.isJust
                            --         )
                            --     |> List.length
                            --     |> (/=) 0
                        in
                        -- It's IDLE -> Check if someone is blocking your move
                        case figure of
                            Pawn ->
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

                            Rook ->
                                if cannotMove then
                                    -- Ilegal move -> Your other figure is preventing you to move
                                    let
                                        _ =
                                            Debug.log "It seems that potential next step for this figure is to step over your other figure :( Not possible" ""
                                    in
                                    ( model, Cmd.none )

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

                            _ ->
                                ( model, Cmd.none )

                Nothing ->
                    case model.possibleNextMoves of
                        NextMove cp lstOfMoves ->
                            -- Alright ! We can maybe move figure, let's check if selected field is among allowed fileds !
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
                                                                List.concatMap
                                                                    (\({ x, y } as move) ->
                                                                        if isEqualPosition cp.x x cp.y y then
                                                                            { x = desiredOrCurrentPosition.x
                                                                            , y = desiredOrCurrentPosition.y
                                                                            }
                                                                                :: fs.moves

                                                                        else
                                                                            [ move ]
                                                                    )
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
