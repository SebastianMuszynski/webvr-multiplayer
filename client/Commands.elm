module Commands exposing (..)

import Config exposing (websocketUrl)
import Msgs exposing (Msg)
import WebSocket


joinRoom : Cmd Msg
joinRoom =
    let
        data =
            "newPlayer"
    in
        WebSocket.send websocketUrl data
