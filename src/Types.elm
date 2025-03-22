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
    , game : Maybe GameFE -- TODO remove game from model since you are just passing it from BE to Chess
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


type WhoseMove
    = GameIdle
      -- | StartGame
    | PlayersMove FigureColor


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


type
    PlayerType
    -- `ME` is however initiated the game
    = Opponent
    | Me


type alias FigureMoves =
    { figure : Figure
    , moves : List Field
    }


type FigureColor
    = White
    | Black


type alias NextMoves =
    { potentialMoves : List Field
    , potentialCaptures : List Field
    }


type alias ChessModel =
    { player1 : ( List FigureState, PlayerStatus )
    , player2 : ( List FigureState, PlayerStatus )
    , possibleNextMoves : PossibleNextMove
    , figureColor : FigureColor
    , error : Maybe String
    , player1Captures : List ( Figure, Field )
    , player2Captures : List ( Figure, Field )
    , urlString : String
    , roomId : String
    , whoseMove : WhoseMove
    , isKingInChessPosition : Bool
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
    { --   games is dict of Owner and maybe Invitee, comprises of sessionId, figures and captures
      games : Dict String Game
    }


type alias Game =
    { owner : Player
    , invitee : Maybe Player
    , whoseMove : WhoseMove
    }


type alias GameFE =
    { player1 : PlayerFe
    , player2 : PlayerFe
    }


type alias PlayerFe =
    { figures : List FigureState
    , captures : List ( Figure, Field )
    , status : PlayerStatus
    }


type alias Player =
    { playersSessionId : Lamdera.SessionId
    , figures : List FigureState
    , captures : List ( Figure, Field )
    , status : PlayerStatus
    }


type PlayerStatus
    = Freezed -- opponent left the game
    | Active -- in the game
    | Inactive --left the game


type ToFrontend
    = NoOpToFrontend
      -- | PositionsUrl String
    | BeToChess BeToChess


type BeToChess
    = GameCurrentState GameFE WhoseMove Bool
    | BeToChessResponse TypeOfResponse


type TypeOfResponse
    = Notification String
    | Error String


type ToBackend
    = NoOpToBackend
    | InitiateGame String
    | JoinGame String
    | ChessOutMsg_toBackend_SendPositionsUpdate String FigureColor ( List FigureState, List FigureState ) Bool
    | ChessOutMsg_toBackend_SendCaptureUpdate String FigureColor ( Figure, Field )


type BackendMsg
    = UserConnected Lamdera.SessionId Lamdera.ClientId
    | UserDisconnected Lamdera.SessionId Lamdera.ClientId


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
    | FeToChess_GotGameData GameFE WhoseMove Bool
    | NotYourMove
    | AbsentOpponent
