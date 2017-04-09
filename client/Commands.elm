module Commands exposing (..)

import Msgs exposing (Msg)
import WebSocket


joinRoom : Cmd Msg
joinRoom =
    WebSocket.send "ws://0.0.0.0:3000/room" "newPlayer"
