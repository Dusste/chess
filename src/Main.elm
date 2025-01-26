module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Chess
import Html exposing (Html)
import Html.Attributes as HA
import Tests
import Url exposing (Url)
import Url.Parser exposing ((</>))


matchRoute : Url.Parser.Parser (Route -> a) a
matchRoute =
    Url.Parser.oneOf
        [ Url.Parser.map Chess Url.Parser.top
        , Url.Parser.map Tests (Url.Parser.s "tests")
        ]


urlToPage : Url -> Nav.Key -> Page
urlToPage url key =
    case Url.Parser.parse matchRoute url of
        Just Chess ->
            ChessPage (Tuple.first Chess.init)

        Just Tests ->
            TestPage (Tuple.first Tests.init)

        _ ->
            NotFoundPage


initCurrentPage : Model -> ( Model, Cmd Msg )
initCurrentPage model =
    case model.page of
        ChessPage _ ->
            let
                ( model_, cmds ) =
                    Chess.init

                -- Because Main doesn’t know anything about the page specific messages, it needs to map them to one of the data constructors from its own Msg type using the Cmd.map function
            in
            ( { model | page = ChessPage model_ }
            , Cmd.map GotChessPageMsg cmds
            )

        TestPage _ ->
            let
                ( model_, cmds ) =
                    Tests.init

                -- Because Main doesn’t know anything about the page specific messages, it needs to map them to one of the data constructors from its own Msg type using the Cmd.map function
            in
            ( { model | page = TestPage model_ }
            , Cmd.map GotTestPageMsg cmds
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
    , page = urlToPage url key
    }



-- MESSAGES


type Msg
    = ClickedLink Browser.UrlRequest
    | ChangedUrl Url
    | GotTestPageMsg Tests.Msg
    | GotChessPageMsg Chess.Msg


type Page
    = ChessPage Chess.Model
    | TestPage Tests.Model
    | NotFoundPage


type Route
    = Chess
    | Tests


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
                        ( loginModelFromLogin, loginMsgFromLogin ) =
                            Chess.update msg_ mainModel
                    in
                    ( { model | page = ChessPage loginModelFromLogin }
                    , Cmd.map GotChessPageMsg loginMsgFromLogin
                    )

                _ ->
                    ( model, Cmd.none )

        GotTestPageMsg msg_ ->
            case model.page of
                TestPage mainModel ->
                    let
                        ( loginModelFromLogin, loginMsgFromLogin ) =
                            Tests.update msg_ mainModel
                    in
                    ( { model | page = TestPage loginModelFromLogin }
                    , Cmd.map GotTestPageMsg loginMsgFromLogin
                    )

                _ ->
                    ( model, Cmd.none )

        ChangedUrl url ->
            let
                newPage : Page
                newPage =
                    urlToPage url model.key
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

        TestPage signupModel ->
            Tests.view signupModel
                |> Html.map GotTestPageMsg

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
