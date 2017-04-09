module Commands exposing (..)

import Config exposing (websocketUrl, jsonIndentation)
import Json.Encode as Encode
import Models exposing (Player, Position)
import Msgs exposing (Msg)
import WebSocket


joinRoom : Cmd Msg
joinRoom =
    let
        player =
            Player "player_1" (Position 0 0 0)
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
