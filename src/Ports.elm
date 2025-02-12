port module Ports exposing (..)

import Json.Decode


port onTimestamp : (Json.Decode.Value -> msg) -> Sub msg


port copyUrlToClipboard : String -> Cmd msg
