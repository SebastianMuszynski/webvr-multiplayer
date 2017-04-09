module View exposing (..)

import AFrame exposing (scene)
import AFrame.Primitives exposing (box, plane)
import AFrame.Primitives.Attributes exposing (..)
import AFrame.Primitives.Camera exposing (camera)
import AFrame.Primitives.Cursor exposing (cursor)
import Color exposing (rgb)
import Html exposing (Html, div)
import Models exposing (Model, Player)
import Msgs exposing (Msg)


view : Model -> Html Msg
view model =
    scene []
        [ camera [] [ cursor [] [] ]
        , plane
            [ rotation -90 0 0
            , width 30
            , height 30
            , color (rgb 92 171 125)
            ]
            []
        , showPlayers model.players
        ]


showPlayers : List Player -> Html Msg
showPlayers players =
    div [] (List.map showPlayer players)


showPlayer : Player -> Html Msg
showPlayer player =
    box
        [ position player.position.x player.position.y player.position.z
        , color (rgb 240 173 0)
        ]
        []
