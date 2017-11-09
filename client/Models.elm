module Models exposing (..)


initialModel : Model
initialModel =
    { config = Config Nothing
    , error = Nothing
    , game = Game "" [] [] "NEW_GAME"
    }


type alias Model =
    { config : Config
    , error : Maybe String
    , game : Game
    }


type alias Game =
    { currentPlayerId : PlayerId
    , enemies : List Enemy
    , players : List Player
    , status : GameStatus
    }


type alias GameStatus =
    String


type alias Config =
    { host : Maybe String
    }


type alias Flags =
    { host : String
    }


type alias Player =
    { id : PlayerId
    , color : String
    , points : Int
    , position : Position
    , rotation : Rotation
    , socket : String
    , status : String
    }


type alias PlayerId =
    String


type alias Position =
    { x : Float
    , y : Float
    , z : Float
    }


type alias Rotation =
    { x : Int
    , y : Int
    , z : Int
    }


type alias Enemy =
    { id : EnemyId
    , color : String
    , isAlive : Bool
    , position : Position
    }


type alias EnemyId =
    String


type alias Action =
    { type_ : String
    , payload : ActionPayload
    }


type alias ActionPayload =
    { data : String
    , player_id : String
    }
