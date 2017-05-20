module View exposing (..)

import AFrame exposing (scene, entity)
import AFrame.Primitives exposing (plane, box, sphere)
import AFrame.Primitives.Attributes exposing (..)
import AFrame.Primitives.Camera exposing (camera)
import AFrame.Primitives.Cursor exposing (cursor, timeout, fuse)
import Color exposing (rgb)
import Html exposing (Html, div, text, h2)
import Html.Attributes exposing (attribute, style)
import Models exposing (Model, Player, Enemy, Position)
import String exposing (isEmpty)


view : Model -> Html msg
view model =
    case model.error of
        Nothing ->
            case model.game.currentPlayer of
                Just player ->
                    scene [ attribute "embedded" "true" ]
                        [ renderCamera player.position
                        , renderFloor
                        , renderPlayers model.game.players
                        , renderEnemies model.game.enemies
                        ]

                Nothing ->
                    div [] []

        Just errorMsg ->
            renderErrorMsg errorMsg


renderErrorMsg : String -> Html msg
renderErrorMsg error =
    div
        [ style
            [ ( "background-color", "#C03546" )
            , ( "border-left", "5px solid #FF7761" )
            , ( "border-radius", "3px" )
            , ( "margin", "50px auto" )
            , ( "padding", "15px" )
            , ( "width", "600px" )
            , ( "line-height", "25px" )
            , ( "font-family", "Helvetica, sans-serif" )
            , ( "color", "#FFF" )
            ]
        ]
        [ text error ]


renderCamera : Position -> Html msg
renderCamera cameraPos =
    entity [ position cameraPos.x cameraPos.y cameraPos.z ]
        [ camera []
            [ renderCursor
            ]
        ]


renderCursor : Html msg
renderCursor =
    cursor
        [ timeout 2
        , fuse True
        , attribute "color" "#000"
        ]
        []


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
        [ attribute "data-id" player.id
        , position player.position.x player.position.y player.position.z
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
    let
        newPosition =
            [ enemy.position.x, enemy.position.y + 2, enemy.position.z ]
                |> List.map toString
                |> List.intersperse " "
                |> String.concat
    in
        sphere
            [ attribute "data-id" enemy.id
            , position enemy.position.x enemy.position.y enemy.position.z
            , radius 0.5
            , color (rgb 255 0 0)
            , attribute "enemy-hover-listener" "true"
            , attribute "visible" (String.toLower <| toString enemy.isVisible)
            , attribute "animation" ("property: position; dir: alternate; dur: 2000; easing: easeInOutSine; loop: true; to: " ++ newPosition)
            ]
            []
