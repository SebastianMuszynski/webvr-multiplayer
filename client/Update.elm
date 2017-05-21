module Update exposing (..)

import Commands exposing (startGame, sendAction)
import Decoders exposing (decodeAction, decodePlayers, decodePlayer, decodeEnemies)
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
                    handleActionOnComponentRequest action model


handleActionOnComponentRequest : Action -> Model -> ( Model, Cmd Msg )
handleActionOnComponentRequest action model =
    case model.config.host of
        Just host ->
            ( model, sendAction model action )

        Nothing ->
            handleError "No host provided!" model


handleError : String -> Model -> ( Model, Cmd Msg )
handleError errorMsg model =
    ( { model | error = Just errorMsg }, Cmd.none )


handleAction : Action -> Model -> ( Model, Cmd Msg )
handleAction action model =
    if action.type_ == "NEW_PLAYER_RESPONSE" then
        case (decodePlayer action.payload.data) of
            Err msg ->
                handleError msg model

            Ok player ->
                let
                    currentGame =
                        model.game

                    updatedGame =
                        { currentGame | currentPlayer = Just player }
                in
                    ( { model | game = updatedGame }, Cmd.none )
    else if action.type_ == "PLAYERS" then
        case (decodePlayers action.payload.data) of
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
        case (decodeEnemies action.payload.data) of
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
    else if action.type_ == "PLAYER" then
        let
            player =
                model.game.currentPlayer
        in
            case player of
                Just player ->
                    if action.payload.player_id == player.id then
                        case (decodePlayer action.payload.data) of
                            Err msg ->
                                handleError msg model

                            Ok player ->
                                let
                                    currentGame =
                                        model.game

                                    updatedGame =
                                        { currentGame | currentPlayer = Just player }
                                in
                                    ( { model | game = updatedGame }, Cmd.none )
                    else
                        ( model, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )
    else
        ( { model | error = Just ("Unrecognised action type: " ++ action.type_) }, Cmd.none )
