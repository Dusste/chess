module Main exposing (main)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes as HA
import List.Extra


number_of_rows : Int
number_of_rows =
    8


number_of_columns : Int
number_of_columns =
    8



-- MODEL


type Horizontal
    = A
    | B
    | C
    | D
    | E
    | F
    | G
    | H


horizontalToString : Horizontal -> String
horizontalToString hz =
    case hz of
        A ->
            "A"

        B ->
            "B"

        C ->
            "C"

        D ->
            "D"

        E ->
            "E"

        F ->
            "F"

        G ->
            "G"

        H ->
            "H"


stringToHorizantal : String -> Horizontal
stringToHorizantal str =
    case str of
        "A" ->
            A

        "B" ->
            B

        "C" ->
            C

        "D" ->
            D

        "E" ->
            E

        "F" ->
            F

        "G" ->
            G

        _ ->
            H


type Vertical
    = One
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight


verticalToString : Vertical -> String
verticalToString hz =
    case hz of
        One ->
            "1"

        Two ->
            "2"

        Three ->
            "3"

        Four ->
            "4"

        Five ->
            "5"

        Six ->
            "6"

        Seven ->
            "7"

        Eight ->
            "8"


intToVertical : Int -> Vertical
intToVertical num =
    case num of
        1 ->
            One

        2 ->
            Two

        3 ->
            Three

        4 ->
            Four

        5 ->
            Five

        6 ->
            Six

        7 ->
            Seven

        _ ->
            Eight


type alias Position =
    { figure : Figure
    , x : Horizontal
    , y : Vertical
    }


type alias Move =
    ( Position, Position )


type Figure
    = King
    | Queen
    | Bishop
    | Knight
    | Rook
    | Pawn



-- type Player
--     = Rook


type alias Player =
    { rook1 : Figure
    , rook2 : Figure
    , pawn1 : Figure
    , pawn2 : Figure
    , pawn3 : Figure
    , pawn4 : Figure
    , pawn5 : Figure
    , pawn6 : Figure
    , pawn7 : Figure
    , pawn8 : Figure
    , bishop1 : Figure
    , bishop2 : Figure
    , knight1 : Figure
    , knight2 : Figure
    , king : Figure
    , queen : Figure
    }


startPositionsPlayerOne : List Position
startPositionsPlayerOne =
    [ { figure = Rook, x = A, y = One }
    , { figure = Rook, x = H, y = One }
    , { figure = Pawn, x = A, y = Two }
    , { figure = Pawn, x = B, y = Two }
    , { figure = Pawn, x = C, y = Two }
    , { figure = Pawn, x = D, y = Two }
    , { figure = Pawn, x = E, y = Two }
    , { figure = Pawn, x = F, y = Two }
    , { figure = Pawn, x = G, y = Two }
    , { figure = Pawn, x = H, y = Two }
    , { figure = Knight, x = B, y = One }
    , { figure = Knight, x = G, y = One }
    , { figure = Bishop, x = C, y = One }
    , { figure = Bishop, x = F, y = One }
    , { figure = King, x = E, y = One }
    , { figure = Queen, x = D, y = One }
    ]



-- startPositionsPlayerOne : Player
-- startPositionsPlayerOne =
--     { rook1 = Rook A One
--     , rook2 = Rook H One
--     , pawn1 = Pawn A Two
--     , pawn2 = Pawn B Two
--     , pawn3 = Pawn C Two
--     , pawn4 = Pawn D Two
--     , pawn5 = Pawn E Two
--     , pawn6 = Pawn F Two
--     , pawn7 = Pawn G Two
--     , pawn8 = Pawn H Two
--     , knight1 = Knight B One
--     , knight2 = Knight G One
--     , bishop1 = Bishop C One
--     , bishop2 = Bishop F One
--     , king = King E One
--     , queen = Queen D One
--     }


startPositionsPlayerTwo : List Position
startPositionsPlayerTwo =
    [ { figure = Rook, x = A, y = Eight }
    , { figure = Rook, x = H, y = Eight }
    , { figure = Pawn, x = A, y = Seven }
    , { figure = Pawn, x = B, y = Seven }
    , { figure = Pawn, x = C, y = Seven }
    , { figure = Pawn, x = D, y = Seven }
    , { figure = Pawn, x = E, y = Seven }
    , { figure = Pawn, x = F, y = Seven }
    , { figure = Pawn, x = G, y = Seven }
    , { figure = Pawn, x = H, y = Seven }
    , { figure = Knight, x = B, y = Eight }
    , { figure = Knight, x = G, y = Eight }
    , { figure = Bishop, x = C, y = Eight }
    , { figure = Bishop, x = F, y = Eight }
    , { figure = King, x = E, y = Eight }
    , { figure = Queen, x = D, y = Eight }
    ]



-- startPositionsPlayerTwo : Player
-- startPositionsPlayerTwo =
--     { rook1 = Rook A Eight
--     , rook2 = Rook H Eight
--     , pawn1 = Pawn A Seven
--     , pawn2 = Pawn B Seven
--     , pawn3 = Pawn C Seven
--     , pawn4 = Pawn D Seven
--     , pawn5 = Pawn E Seven
--     , pawn6 = Pawn F Seven
--     , pawn7 = Pawn G Seven
--     , pawn8 = Pawn H Seven
--     , knight1 = Knight B Eight
--     , knight2 = Knight G Eight
--     , bishop1 = Bishop C Eight
--     , bishop2 = Bishop F Eight
--     , king = King E Eight
--     , queen = Queen D Eight
--     }
-- player1 : ( Position, Position )
-- player1 =
--     ( Position B Three, Position D Five )
-- player2 : ( Position, Position )
-- player2 =
--     ( Position C One, Position G Eight )


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


type alias Model =
    { player1 : List Position
    , player2 : List Position
    }


initialModel : Model
initialModel =
    { player1 = startPositionsPlayerOne
    , player2 = startPositionsPlayerTwo
    }



-- MESSAGES


type Msg
    = NoOp



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW
-- f : Horizontal -> Vertical -> Figure
-- f x y =
--     King


coordinatesToFigure : Horizontal -> Vertical -> List Position -> Maybe Figure
coordinatesToFigure x1 y1 lst =
    lst
        |> List.Extra.find
            (\{ x, y } -> x == x1 && y == y1)
        |> Maybe.map .figure


viewSquare : Model -> Bool -> Int -> Int -> Html msg
viewSquare { player1, player2 } shouldShowLetter index colNum =
    let
        letter : String
        letter =
            indexToLetter index

        _ =
            Debug.log "View Squeare" ( letter, colNum )

        figureEl =
            coordinatesToFigure (stringToHorizantal letter) (intToVertical colNum) (List.concat [ player1, player2 ])
                |> figureToHtml
    in
    Html.div
        [ HA.class "relative flex border border-black w-[100px] h-[100px]" ]
        [ figureEl
        , if shouldShowLetter then
            Html.div [ HA.class "absolute bottom-[-30px] left-[45%]" ] [ Html.text letter ]

          else
            Html.text ""
        ]


viewRows : Model -> Int -> Html msg
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
            [ Html.div [ HA.class "flex self-center" ] [ Html.text <| String.fromInt colNum ] ]
        )


viewColumns : Model -> Html msg
viewColumns model =
    Html.div
        [ HA.class "flex flex-col border border-black" ]
        (List.repeat number_of_columns (viewRows model)
            |> List.indexedMap (\i el -> el (i + 1))
        )


view : Model -> Html Msg
view model =
    Html.div
        []
        [ Html.h1 [ HA.class "text-4xl mb-20" ] [ Html.text "Welcome to match" ]
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
