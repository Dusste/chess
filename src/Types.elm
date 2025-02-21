module Types exposing (..)

import Browser
import Browser.Navigation as Nav
import Dict exposing (Dict)
import Lamdera
import UUID
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Nav.Key
    , page : Page
    , game : Maybe ( List FigureState, List FigureState )
    , uuid : Maybe UUID.UUID
    }


type alias FigureState =
    ( PlayerType
    , FigureMoves
    )


type alias Move =
    { potentialMove : Maybe Field
    , potentialCapture : Maybe Field
    }


type alias Position =
    { figure : Maybe Figure
    , x : Int
    , y : Int
    }


type
    PossibleNextMove
    -- Next Move - Current Field and Next Move fields and Capture figures
    = NextMove Field NextMoves
    | Idle


type Figure
    = King
    | Queen
    | Bishop
    | Knight
    | Rook
    | Pawn


type alias Field =
    { x : Int
    , y : Int
    }


type PlayerType
    = Opponent
    | Me


type alias FigureMoves =
    { figure : Figure
    , moves : List Field
    }


type alias NextMoves =
    { potentialMoves : List Field
    , potentialCaptures : List Field
    }


type alias ChessModel =
    { player1 : List FigureState
    , player2 : List FigureState
    , possibleNextMoves : PossibleNextMove
    , isInvited : Bool
    , error : Maybe String
    , player1Captures : List ( Figure, Field )
    , player2Captures : List ( Figure, Field )
    , urlString : String
    , roomId : String
    }


type alias BackwardCompatibilityModel =
    { figure : Maybe Figure
    }


type BackwardCompatibilityMsg
    = NoOpB


type HomeMsg
    = NoOpH
    | CreateRoom


type alias HomeModel =
    { roomId : String
    , key : Nav.Key
    }


type Page
    = ChessPage ChessModel
    | HomePage HomeModel
    | BackwardCompatibilityPage BackwardCompatibilityModel
    | NotFoundPage
    | Loading


type alias BackendModel =
    { -- game : Maybe ( List Chess.FigureState, List Chess.FigureState )
      players : Dict Lamdera.SessionId (List FigureState)

    --   games is dict of Owner and maybe  invitee
    , games :
        Dict
            String
            { owner : ( Lamdera.SessionId, List FigureState )
            , invitee : Maybe ( Lamdera.SessionId, List FigureState )
            }
    }


type ToFrontend
    = NoOpToFrontend
      -- | PositionsUrl String
    | BeToChess BeToChess


type BeToChess
    = GameCurrentState ( List FigureState, List FigureState )
    | ResponseError String


type ToBackend
    = NoOpToBackend
    | InitiateGame String
    | JoinGame String
    | ChessOutMsg_toBackend_SendPositionsUpdate String Bool ( List FigureState, List FigureState )


type BackendMsg
    = UserConnected Lamdera.SessionId Lamdera.ClientId
    | UserDisconnected Lamdera.SessionId Lamdera.ClientId
    | NoOpBackendMsg


type FrontendMsg
    = ClickedLink Browser.UrlRequest
    | ChangedUrl Url.Url
    | GotBackwardCompatibilityPageMsg BackwardCompatibilityMsg
    | GotChessPageMsg ChessMsg
    | GotHomePageMsg HomeMsg
    | GotTimestamp Int


type ChessMsg
    = NoOp
    | InitiateMove Position
    | InitiateCapture
        { figure : Figure
        , x : Int
        , y : Int
        }
    | CopyRoomUrl
    | FeToChess_GotGameData ( List FigureState, List FigureState )
