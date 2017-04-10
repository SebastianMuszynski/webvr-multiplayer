module View exposing (..)

import AFrame exposing (scene, entity)
import AFrame.Primitives exposing (plane, box, sphere)
import AFrame.Primitives.Attributes exposing (..)
import AFrame.Primitives.Camera exposing (camera)
import AFrame.Primitives.Cursor exposing (cursor)
import Color exposing (rgb)
import Html exposing (Html, div, text)
import Models exposing (Model, Player, Enemy)
import Msgs exposing (Msg)


view : Model -> Html Msg
view model =
    if model.error == "" then
        scene []
            [ camera [] [ cursor [] [] ]
            , plane
                [ rotation -90 0 0
                , width 30
                , height 30
                , color (rgb 92 171 125)
                ]
                []
            , renderPlayers model.players
            , renderEnemies model.enemies
            ]
    else
        div [] [ text model.error ]


renderPlayers : List Player -> Html Msg
renderPlayers players =
    entity [] (List.map renderPlayer players)


renderPlayer : Player -> Html Msg
renderPlayer player =
    box
        [ position player.position.x player.position.y player.position.z
        , width 1
        , height 1
        , color (rgb 240 173 0)
        ]
        []


renderEnemies : List Enemy -> Html Msg
renderEnemies enemies =
    entity [] (List.map renderEnemy enemies)


renderEnemy : Enemy -> Html Msg
renderEnemy enemy =
    sphere
        [ position enemy.position.x enemy.position.y enemy.position.z
        , radius 0.5
        , color (rgb 255 0 0)
        ]
        []
