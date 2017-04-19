module View exposing (..)

import AFrame exposing (scene, entity)
import AFrame.Animations exposing (animation, attribute_, direction, dur, to, repeat)
import AFrame.Primitives exposing (plane, box, sphere)
import AFrame.Primitives.Attributes exposing (..)
import AFrame.Primitives.Camera exposing (camera)
import AFrame.Primitives.Cursor exposing (cursor)
import Color exposing (rgb)
import Html exposing (Html, div, text, h2)
import Html.Attributes exposing (attribute, style)
import Models exposing (Model, Player, Enemy, Position)
import String exposing (isEmpty)


view : Model -> Html msg
view model =
    if isEmpty model.error then
        scene []
            [ renderCamera (Position 0 0 0)
            , renderFloor
            , renderPlayers model.players
            , renderEnemies model.enemies
            ]
    else
        renderErrorMsg model.error


renderErrorMsg : String -> Html msg
renderErrorMsg error =
    div
        [ style
            [ ( "background-color", "#C03546" )
            , ( "margin", "50px auto" )
            , ( "padding", "15px" )
            , ( "width", "960px" )
            , ( "font-family", "Helvetica, sans-serif" )
            , ( "color", "#FFF" )
            ]
        ]
        [ text error ]


renderCamera : Position -> Html msg
renderCamera cameraPos =
    entity [ position cameraPos.x cameraPos.y cameraPos.z ]
        [ camera []
            [ cursor [] []
            ]
        ]


renderFloor : Html msg
renderFloor =
    entity []
        [ plane
            [ rotation -90 0 0
            , width 30
            , height 30
            , color (rgb 92 171 125)
            ]
            []
        ]


renderPlayers : List Player -> Html msg
renderPlayers players =
    entity [] (List.map renderPlayer players)


renderPlayer : Player -> Html msg
renderPlayer player =
    box
        [ position player.position.x player.position.y player.position.z
        , width 1
        , height 1
        , color (rgb 240 173 0)
        ]
        []


renderEnemies : List Enemy -> Html msg
renderEnemies enemies =
    entity [] (List.map renderEnemy enemies)


renderEnemy : Enemy -> Html msg
renderEnemy enemy =
    sphere
        [ position enemy.position.x enemy.position.y enemy.position.z
        , radius 0.5
        , color (rgb 255 0 0)
        , attribute "enemy-hover-listener" "true"
        ]
        [ animation
            [ attribute_ "position"
            , dur 2000
            , direction "alternate"
            , [ enemy.position.x, enemy.position.y + 1, enemy.position.z ]
                |> List.map toString
                |> List.intersperse " "
                |> String.concat
                |> to
            , repeat "indefinite"
            ]
            []
        ]
