module Models exposing (..)


type alias Model =
    { players : List Player }


initialModel : Model
initialModel =
    { players =
        [ Player "current_player" (Position 0 0.6 -3)
        ]
    }


type alias PlayerId =
    String


type alias Position =
    { x : Float
    , y : Float
    , z : Float
    }


type alias Player =
    { id : PlayerId
    , position : Position
    }
