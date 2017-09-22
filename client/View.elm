module View exposing (..)

import AFrame exposing (entity, scene)
import AFrame.Primitives exposing (assetItem, assets, box, cone, cylinder, plane, sky, sphere, text)
import AFrame.Primitives.Attributes exposing (..)
import AFrame.Primitives.Camera exposing (camera)
import AFrame.Primitives.Cursor exposing (cursor, fuse, timeout)
import Color exposing (rgb)
import Html exposing (Html, div, h2, node)
import Html.Attributes exposing (align, attribute, id, style, value)
import Models exposing (Enemy, Game, GameStatus, Model, Player, Position)
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
                        , attribute "data-player-color" player.color
                        ]
                        [ case model.game.status of
                            "WAIT_FOR_PLAYERS" ->
                                renderAwaitingText

                            "START_GAME" ->
                                renderGame model.game player

                            "GAME_OVER" ->
                                renderGameOverText

                            _ ->
                                renderStartGameBtn
                        ]

                Nothing ->
                    div [] []

        Just errorMsg ->
            renderErrorMsg errorMsg


renderGame : Game -> Player -> Html msg
renderGame game player =
    entity []
        -- [ renderCountdown
        [ entity []
            [ renderCamera player.player_settings.position player.points player.color
            , renderFloor
            , renderPlayers game
            , renderEnemies game.enemies
            , renderSky
            ]
        ]


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


renderStartGameBtn : Html msg
renderStartGameBtn =
    entity []
        [ plane
            [ width 2
            , height 1
            , position 0 2.6 -3
            , color (rgb 255 171 125)
            , attribute "start-game-listener" "true"
            ]
            []
        , text
            [ attribute "value" "Start game"
            , color (rgb 0 0 0)
            , position -0.55 2.6 -3
            ]
            []
        , camera
            []
            [ renderCursor "#000"
            ]
        ]


renderAwaitingText : Html msg
renderAwaitingText =
    entity []
        [ text
            [ attribute "value" "Waiting for other players to start..."
            , color (rgb 0 0 0)
            , position -1.5 1.6 -3
            ]
            []
        ]


renderGameOverText : Html msg
renderGameOverText =
    entity []
        [ text
            [ attribute "value" "Game over! :)"
            , color (rgb 0 0 0)
            , position -1.5 1.6 -3
            ]
            []
        ]


renderCamera : Position -> Int -> String -> Html msg
renderCamera cameraPos points playerColor =
    entity
        []
        [ camera
            [ position cameraPos.x 3 cameraPos.z
            , attribute "player-position-listener" "true"
            ]
            [ renderCursor playerColor
            , renderPoints points
            ]
        ]


renderCursor : String -> Html msg
renderCursor playerColor =
    cursor
        [ timeout 1
        , fuse True
        , attribute "color" playerColor
        ]
        []


renderFloor : Html msg
renderFloor =
    entity []
        [ cylinder
            [ radius 20
            , height 1
            , attribute "color" "#A8CD1B"
            ]
            []
        , entity [ position -6 0 8 ] [ renderTree ]
        , entity [ position 5 0 -8 ] [ renderTree ]
        , entity [ position 6 0 -3 ] [ renderTree ]
        ]


renderTree : Html msg
renderTree =
    entity []
        [ cylinder
            [ position 0 1.5 0
            , radius 0.3
            , height 3
            , attribute "color" "#5D2800"
            ]
            []
        , cone
            [ position 0 4 0
            , height 3
            , attribute "radius-bottom" "1"
            , attribute "radius-top" "0"
            , attribute "color" "#43916e"
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
    entity []
        [ -- HEAD
          sphere
            [ radius 0.5
            , attribute "color" player.color
            , position player.player_settings.position.x 3 player.player_settings.position.z
            , rotation player.player_settings.rotation.x player.player_settings.rotation.y player.player_settings.rotation.z
            ]
            [ -- EYES
              sphere
                [ radius 0.2
                , attribute "color" "#FFF"
                , position -0.1 0.2 -0.3
                ]
                []
            , sphere
                [ radius 0.2
                , attribute "color" "#FFF"
                , position 0.1 0.2 -0.3
                ]
                []

            -- PUPILS
            , sphere
                [ radius 0.1
                , attribute "color" "#000"
                , position -0.12 0.26 -0.42
                ]
                []
            , sphere
                [ radius 0.1
                , attribute "color" "#000"
                , position 0.12 0.26 -0.42
                ]
                []
            ]

        -- BODY
        , cylinder
            [ radius 0.18
            , height 1.7
            , attribute "color" player.color
            , position player.player_settings.position.x 2 player.player_settings.position.z
            , rotation 0 player.player_settings.rotation.y 0
            ]
            []

        -- ARMS
        , entity
            [ rotation 0 player.player_settings.rotation.y 0
            , position player.player_settings.position.x 0 player.player_settings.position.z
            ]
            [ cylinder
                [ radius 0.2
                , height 0.8
                , scale 0.25 1 0.25
                , attribute "color" player.color
                , position -0.3 1.8 0
                , rotation 0 player.player_settings.rotation.y 0
                ]
                []
            , cylinder
                [ radius 0.2
                , height 0.8
                , scale 0.25 1 0.25
                , attribute "color" player.color
                , position 0.3 1.8 0
                , rotation 0 player.player_settings.rotation.y 0
                ]
                []
            ]

        -- LEGS
        , entity
            [ rotation 0 player.player_settings.rotation.y 0
            , position player.player_settings.position.x 0 player.player_settings.position.z
            ]
            [ cylinder
                [ radius 0.2
                , height 1.2
                , scale 0.25 1 0.25
                , attribute "color" player.color
                , position -0.13 0.6 0
                ]
                []
            , cylinder
                [ radius 0.2
                , height 1.2
                , scale 0.25 1 0.25
                , attribute "color" player.color
                , position 0.13 0.6 0
                ]
                []
            ]
        ]


renderEnemies : List Enemy -> Html msg
renderEnemies enemies =
    entity
        [ position 0 -15 0
        , attribute "animation" "property: position; dur: 1000; easing: easeInOutSine; to: 0 0 0"
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
    entity []
        [ sphere
            [ radius 1
            , attribute "color" enemy.color
            , attribute "data-id" enemy.id
            , attribute "data-color" enemy.color
            , position enemy.position.x enemy.position.y enemy.position.z
            , attribute "enemy-hover-listener" "true"
            , attribute "visible" (String.toLower <| toString enemy.isVisible)
            , attribute "animation" ("property: position; dir: alternate; dur: 2000; easing: easeInOutSine; loop: true; to: " ++ newPosition)
            ]
            []
        ]


renderPoints : Int -> Html msg
renderPoints points =
    AFrame.Primitives.text
        [ attribute "value" (toString points)
        , color (rgb 0 0 0)
        , position 1 0 -2
        ]
        []


renderSky : Html msg
renderSky =
    sky [ attribute "src" "img/aframe-sky.png" ] []
