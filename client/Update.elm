module Update exposing (..)

import Commands exposing (sendAction, startGame)
import Decoders exposing (decodeAction, decodeEnemies, decodePlayer, decodePlayers)
import Models exposing (Action, Enemy, Model, Player, Position)
import Msgs exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnSceneChanged actionJSON ->
            case decodeAction actionJSON of
                Err msg ->
                    handleError msg model

                Ok action ->
                    handleAction action model

        OnComponentRequest actionJSON ->
            case decodeAction actionJSON of
                Err msg ->
                    handleError msg model

                Ok action ->
                    handleActionOnComponentRequest action model


handleError : String -> Model -> ( Model, Cmd Msg )
handleError errorMsg model =
    ( { model | error = Just errorMsg }, Cmd.none )


handleAction : Action -> Model -> ( Model, Cmd Msg )
handleAction action model =
    if action.type_ == "NEW_PLAYER" then
        let
            playerId =
                action.payload.player_id

            currentGame =
                model.game

            updatedGame =
                { currentGame | currentPlayerId = playerId }
        in
        ( { model | game = updatedGame }, Cmd.none )
    else if action.type_ == "WAIT_FOR_PLAYERS" then
        let
            currentGame =
                model.game

            updatedGame =
                { currentGame | status = "WAIT_FOR_PLAYERS" }
        in
        ( { model | game = updatedGame }, Cmd.none )
    else if action.type_ == "START_GAME" then
        let
            currentGame =
                model.game

            updatedGame =
                { currentGame | status = "START_GAME" }
        in
        ( { model | game = updatedGame }, Cmd.none )
    else if action.type_ == "PLAYERS" then
        case decodePlayers action.payload.data of
            Err msg ->
                handleError msg model

            Ok newPlayers ->
                let
                    currentGame =
                        model.game

                    updatedGame =
                        { currentGame | players = newPlayers }
                in
                ( { model | game = updatedGame }, Cmd.none )
    else if action.type_ == "ENEMIES" then
        case decodeEnemies action.payload.data of
            Err msg ->
                handleError msg model

            Ok newEnemies ->
                let
                    currentGame =
                        model.game

                    updatedGame =
                        { currentGame | enemies = newEnemies }
                in
                ( { model | game = updatedGame }, Cmd.none )
    else if action.type_ == "GAME_OVER" then
        let
            currentGame =
                model.game

            updatedGame =
                { currentGame | status = "GAME_OVER" }
        in
        ( { model | game = updatedGame }, Cmd.none )
    else
        ( { model | error = Just ("Unrecognised action type: " ++ action.type_) }, Cmd.none )


handleActionOnComponentRequest : Action -> Model -> ( Model, Cmd Msg )
handleActionOnComponentRequest action model =
    case model.config.host of
        Just host ->
            ( model, sendAction model action )

        Nothing ->
            handleError "No host provided!" model
