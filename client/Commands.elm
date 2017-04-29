module Commands exposing (..)

import Actions exposing (newPlayerAction)
import Config exposing (websocketUrl)
import Encoders exposing (encodeAction)
import Models exposing (Model, Action)
import Msgs exposing (Msg(..))
import WebSocket


-- Start Game


startGame : String -> Cmd Msg
startGame host =
    sendAction host newPlayerAction



-- Helpers


sendAction : String -> Action -> Cmd Msg
sendAction host action =
    WebSocket.send (websocketUrl host) (encodeAction action)
