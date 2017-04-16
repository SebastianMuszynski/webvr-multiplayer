module Msgs exposing (..)

import Models exposing (Position)


type Msg
    = OnSceneChanged String
    | OnEnemiesChanged String
    | NewRandomPosition Position
