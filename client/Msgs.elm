module Msgs exposing (..)

import Models exposing (Position)


type Msg
    = OnSceneChanged String
    | NewRandomPosition Position
