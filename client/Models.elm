module Models exposing (..)


type alias Model =
    { players : List Player }


initialModel : Model
initialModel =
    { players = [] }


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
