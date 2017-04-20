module Commands exposing (..)

import Config exposing (websocketUrl)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required, requiredAt)
import Models exposing (Player, Enemy, Position, Action)
import Msgs exposing (Msg(..))
import Random exposing (Generator, float)
import WebSocket
import Encoders exposing (encodeAction, encodePlayer)


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


actionsDecoder : Decoder Action
actionsDecoder =
    decode Action
        |> required "type_" Decode.string
        |> required "payload" Decode.string


playersDecoder : Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder


playerDecoder : Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> requiredAt [ "position" ] positionDecoder


enemiesDecoder : Decoder (List Enemy)
enemiesDecoder =
    Decode.list enemyDecoder


enemyDecoder : Decoder Enemy
enemyDecoder =
    decode Enemy
        |> required "id" Decode.string
        |> requiredAt [ "position" ] positionDecoder


positionDecoder : Decoder Position
positionDecoder =
    decode Position
        |> required "x" Decode.float
        |> required "y" Decode.float
        |> required "z" Decode.float
