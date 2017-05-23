module View exposing (..)

import AFrame exposing (scene, entity)
import AFrame.Primitives exposing (assets, assetItem, plane, box, sphere, text, objModel, image, sky)
import AFrame.Primitives.Attributes exposing (..)
import AFrame.Primitives.Camera exposing (camera)
import AFrame.Primitives.Cursor exposing (cursor, timeout, fuse)
import Color exposing (rgb)
import Html exposing (Html, div, text, h2)
import Html.Attributes exposing (id, align, attribute, style, value)
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
                            [ assets []
                                [ image [ id "sky", src "images/sky2.jpg" ] []
                                , assetItem
                                    [ id "mario-mtl"
                                    , src "models/mario/mario-sculpture.mtl"
                                    ]
                                    []
                                , assetItem
                                    [ id "mario-obj"
                                    , src "models/mario/mario-sculpture.obj"
                                    ]
                                    []
                                , assetItem
                                    [ id "draug-mtl"
                                    , src "models/draug/ur-draug.mtl"
                                    ]
                                    []
                                , assetItem
                                    [ id "draug-obj"
                                    , src "models/draug/ur-draug.obj"
                                    ]
                                    []
                                ]
                            , renderCamera (Position 0 0.6 0) player.points

                            -- , renderFloor
                            -- , renderPlayers model.game
                            -- , renderEnemies model.game.enemies
                            , renderSky
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

            -- , renderPoints points
            ]
        , renderPlayerLight cameraPos
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


renderSky : Html msg
renderSky =
    sky
        [ src "#sky"
        , attribute "animation" ("property: rotation; dir: alternate; dur: 2000; easing: easeInOutSine; loop: true; to: 0.5 0.5 0.1")
        ]
        []


renderPlayers : Game -> Html msg
renderPlayers game =
    let
        players =
            List.filter (\a -> a.id /= game.currentPlayerId) game.players
    in
        entity [] (List.map renderPlayer players)


renderPlayer : Player -> Html msg
renderPlayer player =
    objModel
        [ src "#mario-obj"
        , attribute "mtl" "#mario-mtl"
        , scale 0.025 0.025 0.025
        , attribute "data-id" player.id
        , position player.player_settings.position.x 1.5 player.player_settings.position.z
        , rotation 0 (player.player_settings.rotation.y + 180) 0
        ]
        []


renderEnemies : List Enemy -> Html msg
renderEnemies enemies =
    entity
        [ attribute "animation" ("property: rotation; dur: 10000; easing: easeInOutSine; loop: true; to: 0 360 0")
        ]
        (List.map renderEnemy enemies)


renderEnemy : Enemy -> Html msg
renderEnemy enemy =
    let
        newPosition =
            [ enemy.position.x, enemy.position.y + 4, enemy.position.z ]
                |> List.map toString
                |> List.intersperse " "
                |> String.concat
    in
        objModel
            [ src "#draug-obj"
            , attribute "mtl" "#draug-mtl"
            , scale 0.3 0.3 0.3
            , attribute "data-id" enemy.id
            , position enemy.position.x enemy.position.y enemy.position.z
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


renderPlayerLight : Position -> Html msg
renderPlayerLight playerPosition =
    entity
        [ attribute "light" "angle: 90; color: #fff; decay: 0; intensity: 1; penumbra: 1; type: spot"
        , position playerPosition.x 4 playerPosition.z
        , rotation -90 0 0
        ]
        []
