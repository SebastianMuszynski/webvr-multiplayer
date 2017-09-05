module Models exposing (..)


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


type alias Model =
    { game : Game
    , config : Config
    , error : Maybe String
    }


initialModel : Model
initialModel =
    { game = Game "NEW_GAME" "" [] []
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


type alias Rotation =
    { x : Int
    , y : Int
    , z : Int
    }


type alias PlayerSettings =
    { position : Position
    , rotation : Rotation
    }


type alias Player =
    { id : PlayerId
    , player_settings : PlayerSettings
    , points : Int
    , color : String
    }


type alias EnemyId =
    String


type alias Enemy =
    { id : EnemyId
    , position : Position
    , isVisible : Bool
    , color : String
    }
