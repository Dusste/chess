module Main exposing (main)

-- NOTE used until it was Browser.application app, keep it for now

import BackwardCompatibility
import Browser
import Browser.Navigation as Nav
import Chess
import Html exposing (Html)
import Html.Attributes as HA
import Url exposing (Url)
import Url.Parser exposing ((</>))


matchRoute : Url.Parser.Parser (Route -> a) a
matchRoute =
    Url.Parser.oneOf
        [ Url.Parser.map Chess Url.Parser.top
        , Url.Parser.map (BackwardCompatibility Nothing) (Url.Parser.s "tests")
        , Url.Parser.map BackwardCompatibility (Url.Parser.s "tests" </> paramStringToFigure)
        ]


paramStringToFigure : Url.Parser.Parser (Maybe Chess.Figure -> a) a
paramStringToFigure =
    Url.Parser.custom "FIGURE"
        (\figure ->
            case figure of
                "queen" ->
                    Just (Just Chess.Queen)

                "king" ->
                    Just (Just Chess.King)

                "rook" ->
                    Just (Just Chess.Rook)

                "knight" ->
                    Just (Just Chess.Knight)

                "bishop" ->
                    Just (Just Chess.Bishop)

                "pawn" ->
                    Just (Just Chess.Pawn)

                _ ->
                    Just Nothing
        )


urlToPage : Url -> Page
urlToPage url =
    case Url.Parser.parse matchRoute url of
        Just Chess ->
            ChessPage (Tuple.first Chess.init)

        Just (BackwardCompatibility maybeFigure) ->
            BackwardCompatibilityPage (Tuple.first (BackwardCompatibility.init maybeFigure))

        _ ->
            NotFoundPage


initCurrentPage : Model -> ( Model, Cmd Msg )
initCurrentPage model =
    case model.page of
        ChessPage _ ->
            let
                ( model_, cmds ) =
                    Chess.init
            in
            ( { model | page = ChessPage model_ }
            , Cmd.map GotChessPageMsg cmds
            )

        BackwardCompatibilityPage m ->
            let
                ( model_, cmds ) =
                    BackwardCompatibility.init m.figure
            in
            ( { model | page = BackwardCompatibilityPage model_ }
            , Cmd.map GotBackwardCompatibilityPageMsg cmds
            )

        NotFoundPage ->
            ( { model | page = NotFoundPage }, Cmd.none )


type alias Model =
    { url : Url.Url
    , key : Nav.Key
    , page : Page
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( initialModel url key, Cmd.none )


initialModel : Url.Url -> Nav.Key -> Model
initialModel url key =
    { url = url
    , key = key
    , page = urlToPage url
    }



-- MESSAGES


type Msg
    = ClickedLink Browser.UrlRequest
    | ChangedUrl Url
    | GotBackwardCompatibilityPageMsg BackwardCompatibility.Msg
    | GotChessPageMsg Chess.Msg


type Page
    = ChessPage Chess.Model
    | BackwardCompatibilityPage BackwardCompatibility.Model
    | NotFoundPage


type Route
    = Chess
    | BackwardCompatibility (Maybe Chess.Figure)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink urlRequest ->
            case urlRequest of
                Browser.External href ->
                    ( model, Nav.load href )

                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

        GotChessPageMsg msg_ ->
            case model.page of
                ChessPage mainModel ->
                    let
                        ( model_, cmds_ ) =
                            Chess.update msg_ mainModel
                    in
                    ( { model | page = ChessPage model_ }
                    , Cmd.map GotChessPageMsg cmds_
                    )

                _ ->
                    ( model, Cmd.none )

        GotBackwardCompatibilityPageMsg msg_ ->
            case model.page of
                BackwardCompatibilityPage mainModel ->
                    let
                        ( model_, cmds_ ) =
                            BackwardCompatibility.update msg_ mainModel
                    in
                    ( { model | page = BackwardCompatibilityPage model_ }
                    , Cmd.map GotBackwardCompatibilityPageMsg cmds_
                    )

                _ ->
                    ( model, Cmd.none )

        ChangedUrl url ->
            let
                newPage : Page
                newPage =
                    urlToPage url
            in
            initCurrentPage { model | page = newPage }


view : Model -> Browser.Document Msg
view model =
    { title = "Chess"
    , body =
        [ app model ]
    }


content : Model -> Html Msg
content model =
    case model.page of
        ChessPage loginModel ->
            Chess.view loginModel
                |> Html.map GotChessPageMsg

        BackwardCompatibilityPage model_ ->
            BackwardCompatibility.view model_
                |> Html.map GotBackwardCompatibilityPageMsg

        NotFoundPage ->
            Html.div
                [ HA.class "h-[100vh] text-size text-4xl flex items-center justify-center flex-col" ]
                [ Html.h1 [] [ Html.text "Chess App" ]
                , Html.p [ HA.class "dark:text-white" ] [ Html.text "Page not found buddy ¯\\_(ツ)_/¯ sorry" ]
                ]


app : Model -> Html Msg
app model =
    Html.div
        [ HA.class "" ]
        [ content model ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = ChangedUrl
        }
