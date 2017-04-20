module Main exposing (..)

import Commands exposing (startGame)
import Html exposing (program)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Subs exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( initialModel, startGame )


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
