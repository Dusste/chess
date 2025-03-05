module Frontend exposing (app)

import BackwardCompatibility
import Browser
import Browser.Navigation as Nav
import Chess
import Dict exposing (Dict)
import Home
import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Lamdera
import Maybe.Extra
import OutMsg exposing (OutMsg)
import Random
import Task
import Types
import UUID exposing (UUID)
import Url exposing (Url)
import Url.Parser exposing ((</>), (<?>))
import Url.Parser.Query as Query
import Util


type alias Model =
    Types.FrontendModel


type Route
    = Chess String Types.FigureColor
    | Home
    | BackwardCompatibility (Maybe Types.Figure)
    | NotFound


matchRoute : Url.Parser.Parser (Route -> a) a
matchRoute =
    Url.Parser.oneOf
        [ Url.Parser.map Home Url.Parser.top
        , Url.Parser.map
            (\urlString maybeInvitee ->
                case Util.mapToFigureColor maybeInvitee of
                    Just figureColor ->
                        Chess urlString figureColor

                    Nothing ->
                        NotFound
            )
            (Url.Parser.s "room" </> (Url.Parser.string <?> Query.string "invite"))
        , Url.Parser.map (BackwardCompatibility Nothing) (Url.Parser.s "tests")
        , Url.Parser.map BackwardCompatibility (Url.Parser.s "tests" </> paramStringToFigure)
        ]


paramStringToFigure : Url.Parser.Parser (Maybe Types.Figure -> a) a
paramStringToFigure =
    Url.Parser.custom "FIGURE"
        (\figure ->
            case figure of
                "queen" ->
                    Just (Just Types.Queen)

                "king" ->
                    Just (Just Types.King)

                "rook" ->
                    Just (Just Types.Rook)

                "knight" ->
                    Just (Just Types.Knight)

                "bishop" ->
                    Just (Just Types.Bishop)

                "pawn" ->
                    Just (Just Types.Pawn)

                _ ->
                    Just Nothing
        )


urlToPage : Url -> Maybe UUID.UUID -> Nav.Key -> Types.Page
urlToPage url uuid key =
    case uuid of
        Just uuid_ ->
            case Url.Parser.parse matchRoute url of
                Just Home ->
                    -- case uuid of
                    --     Just uuid_ ->
                    Types.HomePage (Tuple.first <| Home.init (UUID.toString uuid_) key)

                -- Nothing ->
                --     Types.NotFoundPage
                Just (Chess uuidStr figureColor) ->
                    Types.ChessPage (Tuple.first <| Chess.init uuidStr (Url.toString url) figureColor)

                Just (BackwardCompatibility maybeFigure) ->
                    Types.BackwardCompatibilityPage (Tuple.first (BackwardCompatibility.init maybeFigure))

                _ ->
                    Types.NotFoundPage

        Nothing ->
            Types.Loading


initCurrentPage : Model -> ( Model, Cmd Types.FrontendMsg )
initCurrentPage model =
    case model.page of
        Types.HomePage _ ->
            case model.uuid of
                Just uuid_ ->
                    let
                        ( model_, cmds ) =
                            Home.init (UUID.toString uuid_) model.key
                    in
                    ( { model | page = Types.HomePage model_ }
                    , Cmd.map Types.GotHomePageMsg cmds
                    )

                Nothing ->
                    ( model, Cmd.none )

        Types.BackwardCompatibilityPage m ->
            let
                ( model_, cmds ) =
                    BackwardCompatibility.init m.figure
            in
            ( { model | page = Types.BackwardCompatibilityPage model_ }
            , Cmd.map Types.GotBackwardCompatibilityPageMsg cmds
            )

        Types.NotFoundPage ->
            ( { model | page = Types.NotFoundPage }, Cmd.none )

        _ ->
            ( model, Cmd.none )


init : Url -> Nav.Key -> ( Model, Cmd Types.FrontendMsg )
init url key =
    ( initialModel url key, Cmd.none )


initialModel : Url -> Nav.Key -> Model
initialModel url key =
    { url = url
    , key = key
    , uuid = Nothing
    , page = Types.Loading
    , game = Nothing
    }


update : Types.FrontendMsg -> Model -> ( Model, Cmd Types.FrontendMsg )
update msg model =
    case msg of
        Types.ClickedLink urlRequest ->
            case urlRequest of
                Browser.External href ->
                    ( model, Nav.load href )

                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

        Types.ChangedUrl url ->
            let
                newPage : Types.Page
                newPage =
                    urlToPage url model.uuid model.key
            in
            initCurrentPage { model | page = newPage }

        Types.GotChessPageMsg msg_ ->
            case model.page of
                Types.ChessPage mainModel ->
                    let
                        ( model_, outMsg, cmds_ ) =
                            Chess.update msg_ mainModel
                    in
                    ( { model | page = Types.ChessPage model_ }
                    , [ [ Cmd.map Types.GotChessPageMsg cmds_ ]
                      , OutMsg.map outMsg
                      ]
                        |> List.concat
                        |> Cmd.batch
                    )

                _ ->
                    ( model, Cmd.none )

        Types.GotHomePageMsg msg_ ->
            case model.page of
                Types.HomePage mainModel ->
                    let
                        ( model_, cmds_ ) =
                            Home.update msg_ mainModel
                    in
                    ( { model | page = Types.HomePage model_ }
                    , Cmd.map Types.GotHomePageMsg cmds_
                    )

                _ ->
                    ( model, Cmd.none )

        Types.GotBackwardCompatibilityPageMsg msg_ ->
            case model.page of
                Types.BackwardCompatibilityPage mainModel ->
                    let
                        ( model_, cmds_ ) =
                            BackwardCompatibility.update msg_ mainModel
                    in
                    ( { model | page = Types.BackwardCompatibilityPage model_ }
                    , Cmd.map Types.GotBackwardCompatibilityPageMsg cmds_
                    )

                _ ->
                    ( model, Cmd.none )

        Types.GotTimestamp timestamp ->
            let
                maybeRoomIdInvite : Maybe ( String, Bool )
                maybeRoomIdInvite =
                    -- We need to extract info if user was invited so we can dispatch BE msgs
                    Url.Parser.parse
                        (Url.Parser.map
                            (\urlString maybeInvitee ->
                                ( urlString, maybeInvitee |> Maybe.withDefault False )
                            )
                            (Url.Parser.s "room" </> (Url.Parser.string <?> Query.enum "invite" (Dict.fromList [ ( "true", True ), ( "false", False ) ])))
                        )
                        model.url

                randomUUID : Maybe UUID.UUID
                randomUUID =
                    Random.step UUID.generator (Random.initialSeed timestamp)
                        |> Tuple.first
                        |> UUID.toRepresentation UUID.Compact
                        |> UUID.fromString
                        |> Result.toMaybe
            in
            ( { model
                | uuid = randomUUID
                , page = urlToPage model.url randomUUID model.key
              }
            , maybeRoomIdInvite
                |> Maybe.map
                    (\( roomId, isInvited ) ->
                        if isInvited then
                            Lamdera.sendToBackend (Types.JoinGame roomId)

                        else
                            Lamdera.sendToBackend (Types.InitiateGame roomId)
                    )
                |> Maybe.withDefault Cmd.none
            )


updateFromBackend : Types.ToFrontend -> Model -> ( Model, Cmd Types.FrontendMsg )
updateFromBackend msg model =
    case msg of
        Types.NoOpToFrontend ->
            ( model, Cmd.none )

        Types.BeToChess toChessMsg ->
            case toChessMsg of
                Types.GameCurrentState game whoseMove ->
                    let
                        ( updatedPage, cmd ) =
                            -- TODO find better way to update Chess
                            -- (maybe with figures and positions as query params?)
                            case model.page of
                                Types.ChessPage mainModel ->
                                    let
                                        ( model_, _, cmds_ ) =
                                            Chess.update (Types.FeToChess_GotGameData game whoseMove) mainModel
                                    in
                                    ( Types.ChessPage model_
                                    , Cmd.map Types.GotChessPageMsg cmds_
                                    )

                                _ ->
                                    ( model.page, Cmd.none )
                    in
                    ( { model
                        | game = Just game
                        , page = updatedPage
                      }
                    , cmd
                    )

                Types.BeToChessResponse typeOfResponse ->
                    case typeOfResponse of
                        Types.Notification str ->
                            ( model, Cmd.none )

                        Types.Error str ->
                            ( model, Cmd.none )


view : Model -> Browser.Document Types.FrontendMsg
view model =
    { title = "Chess"
    , body = [ appView model ]
    }


appView : Model -> Html Types.FrontendMsg
appView model =
    Html.div
        []
        [ content model ]


content : Model -> Html Types.FrontendMsg
content model =
    case model.page of
        Types.ChessPage loginModel ->
            -- Html.div []
            --     [ Html.button
            --         [ HE.onClick Types.FeStartGame ]
            --         [ Html.text "start game" ]
            Chess.view loginModel
                |> Html.map Types.GotChessPageMsg

        -- ]
        Types.BackwardCompatibilityPage model_ ->
            BackwardCompatibility.view model_
                |> Html.map Types.GotBackwardCompatibilityPageMsg

        Types.NotFoundPage ->
            Html.div
                [ HA.class "h-[100vh] text-size text-4xl flex items-center justify-center flex-col" ]
                [ Html.h1 [] [ Html.text "Chess App" ]
                , Html.p [ HA.class "dark:text-white" ] [ Html.text "Page not found buddy ¯\\_(ツ)_/¯ sorry" ]
                ]

        Types.Loading ->
            Html.div
                [ HA.class "flex justify-center items-center h-full m-[300px]" ]
                [ Html.div
                    [ HA.class "relative h-[20px] w-[20px] flex" ]
                    [ Html.span
                        [ HA.class "animate-ping absolute inline-flex h-full w-full rounded-full bg-sky-400 opacity-75" ]
                        []
                    , Html.span
                        [ HA.class "relative inline-flex rounded-full h-[20px] w-[20px] bg-sky-500" ]
                        []
                    ]
                ]

        Types.HomePage model_ ->
            Home.view model_
                |> Html.map Types.GotHomePageMsg


subscriptions : Model -> Sub Types.FrontendMsg
subscriptions model =
    Util.subscribeOnTimestamp Types.GotTimestamp


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = Types.ClickedLink
        , onUrlChange = Types.ChangedUrl
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = subscriptions
        , view = view
        }
