module Models exposing (..)


type alias Model =
    { players : List Player
    , enemies : List Enemy
    , newPlayer : Player
    , error : String
    }


initialModel : Model
initialModel =
    { players = []
    , enemies =
        [ Enemy (Position -5 1.6 -5)
        , Enemy (Position -3 1.6 -5)
        , Enemy (Position -1 1.6 -5)
        , Enemy (Position 1 1.6 -5)
        , Enemy (Position 3 1.6 -5)
        , Enemy (Position 5 1.6 -5)
        ]
    , newPlayer = Player "new_player" (Position 0 0 0)
    , error = ""
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


type alias Enemy =
    { position : Position
    }
