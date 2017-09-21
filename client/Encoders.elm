module Encoders exposing (..)

import Config exposing (jsonIndentation)
import Json.Encode as Encode
import Models exposing (Action, ActionPayload, Player, PlayerSettings, Position, Rotation)


-- Action


encodeAction : Action -> String
encodeAction action =
    let
        attributes =
            [ ( "type_", Encode.string action.type_ )
            , ( "payload", encodeActionPayload action.payload )
            ]
    in
    Encode.encode jsonIndentation (Encode.object attributes)



-- ActionPayload


encodeActionPayload : ActionPayload -> Encode.Value
encodeActionPayload actionPayload =
    let
        attributes =
            [ ( "data", Encode.string actionPayload.data )
            , ( "player_id", Encode.string actionPayload.player_id )
            ]
    in
    Encode.object attributes



-- Player


encodePlayer : Player -> String
encodePlayer player =
    let
        attributes =
            [ ( "id", Encode.string player.id )
            , ( "player_settings", encodePlayerSettings player.player_settings )
            , ( "points", Encode.int player.points )
            , ( "color", Encode.string player.color )
            , ( "status", Encode.int player.status )
            , ( "socket", Encode.string player.socket )
            ]
    in
    Encode.encode jsonIndentation (Encode.object attributes)



-- PlayerSettingse


encodePlayerSettings : PlayerSettings -> Encode.Value
encodePlayerSettings playerSettings =
    let
        attributes =
            [ ( "position", encodePosition playerSettings.position )
            , ( "rotation", encodeRotation playerSettings.rotation )
            ]
    in
    Encode.object attributes



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



-- Rotation


encodeRotation : Rotation -> Encode.Value
encodeRotation rotation =
    let
        attributes =
            [ ( "x", Encode.int rotation.x )
            , ( "y", Encode.int rotation.y )
            , ( "z", Encode.int rotation.z )
            ]
    in
    Encode.object attributes
