module Models exposing (..)


type alias Game =
    { currentPlayer : Maybe Player
    , players : List Player
    , enemies : List Enemy
    }


type alias Config =
    { host : Maybe String
    }


type alias Model =
    { game : Game
    , config : Config
    , error : Maybe String
    }


initialModel : Model
initialModel =
    { game = Game Nothing [] []
    , config = Config Nothing
    , error = Nothing
    }


type alias Flags =
    { host : String
    }


type alias Action =
    { type_ : String
    , payload : ActionPayload
    }


type alias ActionPayload =
    { data : String
    , player_id : String
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
    , points : Int
    }


type alias EnemyId =
    String


type alias Enemy =
    { id : EnemyId
    , position : Position
    , isVisible : Bool
    }
