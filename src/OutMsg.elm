module OutMsg exposing (..)

import Lamdera
import Types


type OutMsg
    = SendPositionsUpdate String Types.FigureColor ( List Types.FigureState, List Types.FigureState ) Bool
    | SendCaptureUpdate String Types.FigureColor ( Types.Figure, Types.Field )
    | IsGameOver String Types.FigureColor


map : List OutMsg -> List (Cmd frontendMsg)
map outMsgs =
    List.map
        (\outMsg ->
            case outMsg of
                SendPositionsUpdate roomId figureColor game isKingInChessPosition ->
                    Lamdera.sendToBackend (Types.ChessOutMsg_toBackend_SendPositionsUpdate roomId figureColor game isKingInChessPosition)

                SendCaptureUpdate roomId figureColor capture ->
                    Lamdera.sendToBackend (Types.ChessOutMsg_toBackend_SendCaptureUpdate roomId figureColor capture)

                IsGameOver roomId figureColorWhoWon ->
                    Lamdera.sendToBackend (Types.ChessOutMsg_toBackend_IsGameOver roomId figureColorWhoWon)
        )
        outMsgs
