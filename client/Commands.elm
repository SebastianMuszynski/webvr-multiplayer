module Commands exposing (..)

import Config exposing (websocketUrl, jsonIndentation)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Models exposing (Player, Position)
import Msgs exposing (Msg)
import WebSocket


joinRoom : Cmd Msg
joinRoom =
    let
        player =
            Player "player_1" (Position 0 0 -3)
    in
        let
            data =
                { type_ = "NEW_PLAYER", payload = player }
        in
            WebSocket.send websocketUrl (encodePlayer player)


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


playersDecoder : Decode.Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder


playerDecoder : Decode.Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> required "position" positionDecoder


positionDecoder : Decode.Decoder Position
positionDecoder =
    decode Position
        |> required "x" Decode.float
        |> required "y" Decode.float
        |> required "z" Decode.float
