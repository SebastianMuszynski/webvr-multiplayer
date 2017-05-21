module View exposing (..)

import AFrame exposing (scene, entity)
import AFrame.Primitives exposing (plane, box, sphere, text)
import AFrame.Primitives.Attributes exposing (..)
import AFrame.Primitives.Camera exposing (camera)
import AFrame.Primitives.Cursor exposing (cursor, timeout, fuse)
import Color exposing (rgb)
import Html exposing (Html, div, text, h2)
import Html.Attributes exposing (align, attribute, style, value)
import Models exposing (Model, Player, Enemy, Position, Game)
import String exposing (isEmpty)


view : Model -> Html msg
view model =
    case model.error of
        Nothing ->
            let
                currentPlayerId =
                    model.game.currentPlayerId

                currentPlayer =
                    List.head <| List.filter (\a -> a.id == currentPlayerId) model.game.players
            in
                case currentPlayer of
                    Just player ->
                        scene
                            [ attribute "embedded" "true"
                            , attribute "data-player-id" player.id
                            ]
                            [ renderCamera player.position player.points
                            , renderFloor
                            , renderPlayers model.game
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
        [ Html.text error ]


renderCamera : Position -> Int -> Html msg
renderCamera cameraPos points =
    entity
        []
        [ camera
            [ position cameraPos.x cameraPos.y cameraPos.z
            , attribute "player-position-listener" "true"
            ]
            [ renderCursor
            , renderPoints points
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


renderPlayers : Game -> Html msg
renderPlayers game =
    let
        players =
            List.filter (\a -> a.id /= game.currentPlayerId) game.players
    in
        entity [] (List.map renderPlayer players)


renderPlayer : Player -> Html msg
renderPlayer player =
    box
        [ attribute "data-id" player.id
        , position player.position.x 0.6 player.position.z
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


renderPoints : Int -> Html msg
renderPoints points =
    AFrame.Primitives.text
        [ attribute "value" (toString points)
        , color (rgb 0 0 0)
        , position 1 0 -2
        ]
        []
