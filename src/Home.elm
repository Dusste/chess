module Home exposing (..)

import Browser.Navigation as Nav
import Components.Button
import Html exposing (Html)
import Html.Attributes as HA
import Types


type alias Msg =
    Types.HomeMsg


type alias Model =
    Types.HomeModel


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Types.NoOpH ->
            ( model, Cmd.none )

        Types.CreateRoom ->
            ( model, Nav.load <| "/room/" ++ model.roomId )


init : String -> Nav.Key -> ( Model, Cmd Msg )
init roomId key =
    ( { roomId = roomId, key = key }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div
        []
        [ Html.h1 [] [ Html.text "Welcome to chess game" ]
        , Html.p [] [ Html.text "Do you want to play a game ?" ]
        , Components.Button.view
            |> Components.Button.withText "Start game"
            -- |> Components.Button.withUrl ("/room/" ++ model.roomId)
            |> Components.Button.withMsg Types.CreateRoom
            |> Components.Button.withDisabled False
            |> Components.Button.withPrimaryStyle
            |> Components.Button.toHtml
        ]
