module Encoders exposing (..)

import Config exposing (jsonIndentation)
import Json.Encode as Encode
import Models exposing (Player, Position, Action)


-- Action


encodeAction : Action -> String
encodeAction action =
    let
        attributes =
            [ ( "type_", Encode.string action.type_ )
            , ( "payload", Encode.string action.payload )
            ]
    in
        Encode.encode jsonIndentation (Encode.object attributes)



-- Player


encodePlayer : Player -> String
encodePlayer player =
    let
        attributes =
            [ ( "id", Encode.string player.id )
            , ( "position", encodePosition player.position )
            , ( "points", Encode.int player.points )
            ]
    in
        Encode.encode jsonIndentation (Encode.object attributes)



-- Position


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
