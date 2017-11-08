module Models exposing (..)


initialModel : Model
initialModel =
    { game = Game "NEW_GAME" "" [] []
    , config = Config Nothing
    , error = Nothing
    }


type alias Model =
    { game : Game
    , config : Config
    , error : Maybe String
    }


type alias Game =
    { currentPlayerId : PlayerId
    , status : GameStatus
    , players : List Player
    , enemies : List Enemy
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
    , player_settings : PlayerSettings
    , points : Int
    , color : String
    , status : String
    , socket : String
    }


type alias PlayerId =
    String


type alias PlayerSettings =
    { position : Position
    , rotation : Rotation
    }


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
    , position : Position
    , isVisible : Bool
    , color : String
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
