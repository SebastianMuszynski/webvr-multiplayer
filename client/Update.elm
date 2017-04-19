module Update exposing (..)

import Commands exposing (playersDecoder, enemiesDecoder, joinRoom, actionsDecoder)
import Json.Decode as Decode
import Models exposing (Model, Player, Enemy, Position, Action)
import Msgs exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnSceneChanged jsonAction ->
            let
                decodedAction =
                    decodeAction jsonAction
            in
                case decodedAction of
                    Err msg ->
                        ( { model | error = msg }, Cmd.none )

                    Ok action ->
                        handleAction action model

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


handleAction : Action -> Model -> ( Model, Cmd Msg )
handleAction action model =
    if action.type_ == "PLAYERS" then
        let
            decodedPlayers =
                decodePlayers action.payload
        in
            case decodedPlayers of
                Err msg ->
                    ( { model | error = msg }, Cmd.none )

                Ok newPlayers ->
                    ( { model | players = newPlayers }, Cmd.none )
    else if action.type_ == "ENEMIES" then
        let
            decodedEnemies =
                decodeEnemies action.payload
        in
            case decodedEnemies of
                Err msg ->
                    ( { model | error = msg }, Cmd.none )

                Ok newEnemies ->
                    ( { model | enemies = newEnemies }, Cmd.none )
    else
        ( model, Cmd.none )


decodeAction : String -> Result String Action
decodeAction jsonAction =
    Decode.decodeString actionsDecoder jsonAction


decodePlayers : String -> Result String (List Player)
decodePlayers jsonPlayers =
    Decode.decodeString playersDecoder jsonPlayers


decodeEnemies : String -> Result String (List Enemy)
decodeEnemies jsonEnemies =
    Decode.decodeString enemiesDecoder jsonEnemies
