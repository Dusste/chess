module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes as HA



-- MODEL


type alias Model =
    { count : Int }


initialModel : Model
initialModel =
    { count = 0 }



-- MESSAGES


type Msg
    = Increment
    | Decrement



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    Html.div
        [ HA.class "text-red-500 flex" ]
        [ Html.text "This is Elm's Browser.Element" ]



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
