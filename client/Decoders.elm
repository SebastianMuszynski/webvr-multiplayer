module Decoders exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required, requiredAt)
import Models exposing (Action, ActionPayload, Player, Enemy, Position)


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
        |> requiredAt [ "position" ] positionDecoder
        |> requiredAt [ "points" ] Decode.int



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
        |> requiredAt [ "position" ] positionDecoder
        |> required "isVisible" Decode.bool



-- Position


positionDecoder : Decoder Position
positionDecoder =
    decode Position
        |> required "x" Decode.float
        |> required "y" Decode.float
        |> required "z" Decode.float
