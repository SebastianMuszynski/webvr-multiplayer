module Update exposing (..)

import Commands exposing (playersDecoder, enemiesDecoder, joinRoom)
import Json.Decode as Decode
import Models exposing (Model, Player, Enemy, Position)
import Msgs exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnSceneChanged jsonPlayers ->
            let
                decodedPlayers =
                    decodePlayers jsonPlayers
            in
                case decodedPlayers of
                    Err msg ->
                        ( { model | error = msg }, Cmd.none )

                    Ok newPlayers ->
                        ( { model | players = newPlayers }, Cmd.none )

        OnEnemiesChanged jsonEnemies ->
            let
                decodedEnemies =
                    decodeEnemies jsonEnemies
            in
                case decodedEnemies of
                    Err msg ->
                        ( { model | error = msg }, Cmd.none )

                    Ok newEnemies ->
                        ( { model | enemies = newEnemies }, Cmd.none )

        NewPlayer position ->
            let
                newPlayer =
                    Player model.newPlayer.id position
            in
                ( { model | newPlayer = newPlayer }, joinRoom newPlayer )


decodePlayers : String -> Result String (List Player)
decodePlayers jsonPlayers =
    Decode.decodeString playersDecoder jsonPlayers


decodeEnemies : String -> Result String (List Enemy)
decodeEnemies jsonEnemies =
    Decode.decodeString enemiesDecoder jsonEnemies
