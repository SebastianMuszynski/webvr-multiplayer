module Decoders exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required, requiredAt)
import Models exposing (Action, ActionPayload, Enemy, Player, Position, Rotation)


-- Action


decodeAction : String -> Result String Action
decodeAction actionJSON =
    Decode.decodeString actionDecoder actionJSON


actionDecoder : Decoder Action
actionDecoder =
    decode Action
        |> required "type_" Decode.string
        |> requiredAt [ "payload" ] actionPayloadDecoder


actionPayloadDecoder : Decoder ActionPayload
actionPayloadDecoder =
    decode ActionPayload
        |> required "data" Decode.string
        |> required "player_id" Decode.string



-- Player


decodePlayer : String -> Result String Player
decodePlayer playerJSON =
    Decode.decodeString playerDecoder playerJSON


decodePlayers : String -> Result String (List Player)
decodePlayers playersJSON =
    Decode.decodeString playersDecoder playersJSON


playersDecoder : Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder


playerDecoder : Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> requiredAt [ "color" ] Decode.string
        |> requiredAt [ "points" ] Decode.int
        |> requiredAt [ "position" ] positionDecoder
        |> requiredAt [ "rotation" ] rotationDecoder
        |> requiredAt [ "socket" ] Decode.string
        |> requiredAt [ "status" ] Decode.string



-- Enemy


decodeEnemies : String -> Result String (List Enemy)
decodeEnemies enemiesJSON =
    Decode.decodeString enemiesDecoder enemiesJSON


enemiesDecoder : Decoder (List Enemy)
enemiesDecoder =
    Decode.list enemyDecoder


enemyDecoder : Decoder Enemy
enemyDecoder =
    decode Enemy
        |> required "id" Decode.string
        |> required "color" Decode.string
        |> required "is_alive" Decode.bool
        |> requiredAt [ "position" ] positionDecoder



-- Position


positionDecoder : Decoder Position
positionDecoder =
    decode Position
        |> required "x" Decode.float
        |> required "y" Decode.float
        |> required "z" Decode.float



-- Rotation


rotationDecoder : Decoder Rotation
rotationDecoder =
    decode Rotation
        |> required "x" Decode.int
        |> required "y" Decode.int
        |> required "z" Decode.int
