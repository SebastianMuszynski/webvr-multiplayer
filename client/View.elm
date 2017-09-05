module View exposing (..)

import AFrame exposing (entity, scene)
import AFrame.Primitives exposing (assetItem, assets, box, plane, sky, sphere, text)
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
        [ renderCountdown
        , entity []
            [ renderCamera player.player_settings.position player.points
            , renderFloor
            , renderPlayers game
            , renderEnemies game.enemies
            ]
        ]


renderCountdown : Html msg
renderCountdown =
    entity []
        [ entity []
            [ text
                [ attribute "value" "3"
                , height 5
                , color (rgb 0 0 0)
                , position -0.15 -2.6 -3
                , attribute "animation" "property: position; dur: 1000; dir: alternate; easing: easeInOutSine; to: -0.15 2.6 -3; delay: 500"
                ]
                []
            ]
        , entity []
            [ text
                [ attribute "value" "2"
                , height 5
                , color (rgb 0 0 0)
                , position -0.15 -2.6 -3
                , attribute "animation" "property: position; dur: 1000; dir: alternate; easing: easeInOutSine; to: -0.15 2.6 -3; delay: 1500"
                ]
                []
            ]
        , entity []
            [ text
                [ attribute "value" "1"
                , height 5
                , color (rgb 0 0 0)
                , position -0.15 -2.6 -3
                , attribute "animation" "property: position; dur: 1000; dir: alternate; easing: easeInOutSine; to: -0.15 2.6 -3; delay: 2500"
                ]
                []
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
            [ renderCursor
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
            , width 100
            , height 100
            , color (rgb 255 255 255)
            , attribute "animation" "property: color; dur: 1000; delay: 2500; easing: easeInOutSine; to: #8FA"
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
        [ sphere
            [ radius 0.5
            , color (rgb 255 0 125)
            , position player.player_settings.position.x 3.5 player.player_settings.position.z
            ]
            []
        , box
            [ depth 1
            , width 1
            , height 3
            , position player.player_settings.position.x 1.5 player.player_settings.position.z
            ]
            []
        ]


renderEnemies : List Enemy -> Html msg
renderEnemies enemies =
    entity
        [ position 0 -15 0
        , attribute "animation" "property: position; dur: 1000; easing: easeInOutSine; to: 0 0 0; delay: 4000"
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
            , color (rgb 255 0 125)
            , attribute "data-id" enemy.id
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
