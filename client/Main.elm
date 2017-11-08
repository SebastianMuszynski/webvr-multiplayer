module Main exposing (..)

import Commands exposing (startGame)
import Html exposing (programWithFlags)
import Models exposing (Flags, Model, initialModel)
import Msgs exposing (Msg)
import Subs exposing (subscriptions)
import Update exposing (update)
import View.Main exposing (view)


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        oldConfig =
            initialModel.config

        newConfig =
            { oldConfig | host = Just flags.host }

        model =
            { initialModel | config = newConfig }
    in
    ( model, startGame model )


main : Program Flags Model Msg
main =
    programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
