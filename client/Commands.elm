module Commands exposing (..)

import Config exposing (websocketUrl)
import Encoders exposing (encodeAction, encodePlayer)
import Models exposing (Player, Enemy, Position, Action)
import Msgs exposing (Msg(..))
import Random exposing (Generator, float)
import WebSocket


generateNewPosition : Cmd Msg
generateNewPosition =
    Random.generate NewPlayer randomPosition


randomFloat : Generator Float
randomFloat =
    float 0 10


randomPosition : Generator Position
randomPosition =
    Random.map3 Position randomFloat randomFloat randomFloat


joinRoom : Player -> Cmd Msg
joinRoom player =
    let
        action =
            encodeAction (Action "NEW_PLAYER" (encodePlayer player))
    in
        WebSocket.send websocketUrl action


sendAction : Action -> Cmd Msg
sendAction action =
    WebSocket.send websocketUrl (encodeAction action)
