module Commands exposing (..)

import Actions exposing (newPlayerAction)
import Config exposing (websocketUrl)
import Encoders exposing (encodeAction)
import Models exposing (Model, Action)
import Msgs exposing (Msg(..))
import WebSocket


-- Start Game


startGame : Model -> Cmd Msg
startGame model =
    sendAction model newPlayerAction



-- Helpers


sendAction : Model -> Action -> Cmd Msg
sendAction model action =
    case model.config.host of
        Just host ->
            case model.game.currentPlayer of
                Just player ->
                    WebSocket.send (websocketUrl host) (encodeAction action)

                Nothing ->
                    WebSocket.send (websocketUrl host) (encodeAction action)

        Nothing ->
            Cmd.none
