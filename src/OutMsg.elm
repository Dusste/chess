module OutMsg exposing (..)

import Lamdera
import Task
import Types


type OutMsg
    = SendPositionsUpdate String Bool ( List Types.FigureState, List Types.FigureState )
    | SendCaptureUpdate String Bool ( Types.Figure, Types.Field )



-- msgToCmd : List msg -> Cmd msg
-- msgToCmd msgs =
--     msgs
--         |> List.map
--             (\m ->
--                 Task.perform (always m) (Task.succeed ())
--             )
--         |> Cmd.batch
-- map : List OutMsg.OutMsg -> List Types.ToBackend


map : List OutMsg -> List (Cmd frontendMsg)
map outMsgs =
    List.map
        (\outMsg ->
            case outMsg of
                SendPositionsUpdate roomId isInvitee game ->
                    Lamdera.sendToBackend (Types.ChessOutMsg_toBackend_SendPositionsUpdate roomId isInvitee game)

                SendCaptureUpdate roomId isInvitee capture ->
                    Lamdera.sendToBackend (Types.ChessOutMsg_toBackend_SendCaptureUpdate roomId isInvitee capture)
        )
        outMsgs
