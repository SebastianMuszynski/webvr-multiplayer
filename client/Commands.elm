module Commands exposing (..)

import Config exposing (websocketUrl)
import Json.Encode
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
            [ ( "id", Json.Encode.string player.id )
            , ( "x", Json.Encode.float player.position.x )
            , ( "y", Json.Encode.float player.position.y )
            , ( "z", Json.Encode.float player.position.z )
            ]
    in
        let
            jsonIndent =
                4
        in
            Json.Encode.encode jsonIndent (Json.Encode.object attributes)
