module Main exposing (..)

import Commands exposing (startGame)
import Html exposing (programWithFlags)
import Models exposing (Model, Flags, initialModel)
import Msgs exposing (Msg)
import Subs exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        oldConfig =
            initialModel.config

        newConfig =
            { oldConfig | host = Just flags.host }
    in
        ( { initialModel | config = newConfig }, startGame flags.host )


main : Program Flags Model Msg
main =
    programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
