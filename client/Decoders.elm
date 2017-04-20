module Decoders exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required, requiredAt)
import Models exposing (Player, Enemy, Position, Action)


-- Action


decodeAction : String -> Result String Action
decodeAction jsonAction =
    Decode.decodeString actionDecoder jsonAction


actionDecoder : Decoder Action
actionDecoder =
    decode Action
        |> required "type_" Decode.string
        |> required "payload" Decode.string



-- Player


decodePlayers : String -> Result String (List Player)
decodePlayers jsonPlayers =
    Decode.decodeString playersDecoder jsonPlayers


playersDecoder : Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder


playerDecoder : Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> requiredAt [ "position" ] positionDecoder



-- Enemy


decodeEnemies : String -> Result String (List Enemy)
decodeEnemies jsonEnemies =
    Decode.decodeString enemiesDecoder jsonEnemies


enemiesDecoder : Decoder (List Enemy)
enemiesDecoder =
    Decode.list enemyDecoder


enemyDecoder : Decoder Enemy
enemyDecoder =
    decode Enemy
        |> required "id" Decode.string
        |> requiredAt [ "position" ] positionDecoder



-- Position


positionDecoder : Decoder Position
positionDecoder =
    decode Position
        |> required "x" Decode.float
        |> required "y" Decode.float
        |> required "z" Decode.float
