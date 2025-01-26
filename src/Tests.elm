module Tests exposing (Model, Msg, init, update, view)

import Html exposing (Html)


type Msg
    = NoOp


type alias Model =
    { count : Int
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( { count = 1 }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div [] [ Html.text "TESTS !!" ]
