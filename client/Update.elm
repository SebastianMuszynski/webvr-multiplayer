module Update exposing (..)

import Commands exposing (playersDecoder)
import Json.Decode as Decode
import Models exposing (Model, Player)
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
                        ( model, Cmd.none )

                    Ok newPlayers ->
                        ( { model | players = newPlayers }, Cmd.none )


decodePlayers : String -> Result String (List Player)
decodePlayers jsonPlayers =
    Decode.decodeString playersDecoder jsonPlayers
