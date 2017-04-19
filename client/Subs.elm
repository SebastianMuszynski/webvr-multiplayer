port module Subs exposing (..)

import Config exposing (websocketUrl)
import Models exposing (Model)
import Msgs exposing (Msg(..))
import WebSocket


port fromJs : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ WebSocket.listen websocketUrl OnSceneChanged
        , fromJs OnComponentRequest
        ]
