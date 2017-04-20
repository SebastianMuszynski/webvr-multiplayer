module Update exposing (..)

import Commands exposing (startGame, sendAction)
import Decoders exposing (decodeAction, decodePlayers, decodeEnemies)
import List exposing (filter)
import Models exposing (Model, Player, Enemy, Position, Action)
import Msgs exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnSceneChanged actionJSON ->
            case (decodeAction actionJSON) of
                Err msg ->
                    handleError msg model

                Ok action ->
                    handleAction action model

        OnComponentRequest actionJSON ->
            case (decodeAction actionJSON) of
                Err msg ->
                    handleError msg model

                Ok action ->
                    ( model, sendAction action )


handleError : String -> Model -> ( Model, Cmd Msg )
handleError msg model =
    ( { model | error = msg }, Cmd.none )


handleAction : Action -> Model -> ( Model, Cmd Msg )
handleAction action model =
    if action.type_ == "PLAYERS" then
        case (decodePlayers action.payload) of
            Err msg ->
                handleError msg model

            Ok newPlayers ->
                ( { model | players = newPlayers }, Cmd.none )
    else if action.type_ == "ENEMIES" then
        case (decodeEnemies action.payload) of
            Err msg ->
                handleError msg model

            Ok newEnemies ->
                ( { model | enemies = newEnemies }, Cmd.none )
    else if action.type_ == "REMOVE_ENEMY_REQUEST" then
        let
            enemyId =
                action.payload

            newEnemies =
                filter (\a -> a.id /= enemyId) model.enemies
        in
            ( { model | enemies = newEnemies }, Cmd.none )
    else
        ( { model | error = "Unrecognised action type: " ++ action.type_ }, Cmd.none )
