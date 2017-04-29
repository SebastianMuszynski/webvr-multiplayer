module Config exposing (..)


websocketUrl : String -> String
websocketUrl host =
    "ws://" ++ host ++ ":3000/room"


jsonIndentation : Int
jsonIndentation =
    2
