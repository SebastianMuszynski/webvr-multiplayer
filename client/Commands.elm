module Commands exposing (..)

import Config exposing (websocketUrl, jsonIndentation)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required, requiredAt)
import Json.Encode as Encode
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


encodeAction : Action -> String
encodeAction action =
    let
        attributes =
            [ ( "type_", Encode.string action.type_ )
            , ( "payload", Encode.string action.payload )
            ]
    in
        Encode.encode jsonIndentation (Encode.object attributes)


encodePlayer : Player -> String
encodePlayer player =
    let
        attributes =
            [ ( "id", Encode.string player.id )
            , ( "position", encodePosition player.position )
            ]
    in
        Encode.encode jsonIndentation (Encode.object attributes)


encodePosition : Position -> Encode.Value
encodePosition position =
    let
        attributes =
            [ ( "x", Encode.float position.x )
            , ( "y", Encode.float position.y )
            , ( "z", Encode.float position.z )
            ]
    in
        Encode.object attributes


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
