module Msgs exposing (..)

import Models exposing (Position)


type Msg
    = OnSceneChanged String
    | OnEnemiesChanged String
    | OnComponentRequest String
    | NewPlayer Position
