module Models exposing (..)


type alias Model =
    { currentPlayer : Maybe Player
    , players : List Player
    , enemies : List Enemy
    , error : String
    }


initialModel : Model
initialModel =
    { currentPlayer = Nothing
    , players = []
    , enemies = []
    , error = ""
    }


type alias Action =
    { type_ : String
    , payload : String
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


type alias EnemyId =
    String


type alias Enemy =
    { id : EnemyId
    , position : Position
    }
