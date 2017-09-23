module Actions exposing (..)

import Models exposing (Action, ActionPayload)


-- New player


newPlayerAction : Action
newPlayerAction =
    Action "NEW_PLAYER" (ActionPayload "" "")
