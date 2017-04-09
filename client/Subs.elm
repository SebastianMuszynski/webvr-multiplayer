module Subs exposing (..)

import Config exposing (websocketUrl)
import Models exposing (Model)
import Msgs exposing (Msg(..))
import WebSocket


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen websocketUrl OnSceneChanged
