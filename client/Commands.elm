module Commands exposing (..)

import Actions exposing (newPlayerAction)
import Config exposing (websocketUrl)
import Encoders exposing (encodeAction)
import Models exposing (Action)
import Msgs exposing (Msg(..))
import WebSocket


-- Start Game


startGame : Cmd Msg
startGame =
    sendAction newPlayerAction



-- Helpers


sendAction : Action -> Cmd Msg
sendAction action =
    WebSocket.send websocketUrl (encodeAction action)
