module View.Scene exposing (..)

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
import View.Game exposing (renderCursor, renderGame)


renderScene : Game -> Player -> Html msg
renderScene game player =
    scene
        [ attribute "embedded" "true"
        , attribute "stats" "false"
        , attribute "data-player-id" player.id
        , attribute "data-player-color" player.color
        ]
        [ assets []
            [ assetItem
                [ attribute "id" "sky"
                , attribute "src" "images/aframe-sky.jpg"
                ]
                []
            , node "a-audio"
                [ id "soundClick"
                , attribute "src" "sounds/click.mp3"
                , attribute "preload" "auto"
                ]
                []
            , node "a-audio"
                [ id "soundShoot"
                , attribute "src" "sounds/shoot.mp3"
                , attribute "preload" "auto"
                ]
                []
            , node "a-audio"
                [ id "soundBackground"
                , attribute "src" "sounds/fantasyGame.wav"
                , attribute "preload" "auto"
                ]
                []
            ]
        , case game.status of
            "START_GAME" ->
                renderGame game player

            "WAIT_FOR_PLAYERS" ->
                renderText "Waiting for other players..."

            "GAME_OVER" ->
                renderText "Great game!"

            _ ->
                renderStartGameBtns
        ]


renderText : String -> Html msg
renderText msg =
    entity []
        [ sky [ color (rgb 82 97 106) ] []
        , text
            [ attribute "value" msg
            , color (rgb 254 200 201)
            , position 0 0 -5
            , attribute "align" "center"
            , attribute "anchor" "center"
            ]
            []
        ]


renderStartGameBtns : Html msg
renderStartGameBtns =
    entity []
        [ entity [ position -1 2.6 -3 ]
            [ box
                [ width 1
                , height 1
                , depth 1
                , scale 1 1 0.5
                , position 0 0 -0.25
                , color (rgb 223 64 90)
                , attribute "start-game" "playersNumber: 1"
                , attribute "animation" "property: scale; dur: 250; dir: alternate; easing: easeInSine; to: 1 1 0; startEvents: mouseenter"
                , attribute "sound" "src: #soundClick; on: mouseenter"
                ]
                []
            , text
                [ attribute "value" "1 player"
                , color (rgb 254 200 201)
                , attribute "align" "center"
                , attribute "anchor" "center"
                ]
                []
            ]
        , entity [ position 1 2.6 -3 ]
            [ box
                [ width 1
                , height 1
                , depth 1
                , scale 1 1 0.5
                , position 0 0 -0.25
                , color (rgb 135 49 78)
                , attribute "start-game" "playersNumber: 2"
                , attribute "animation" "property: scale; dur: 250; dir: alternate; easing: easeInSine; to: 1 1 0; startEvents: mouseenter"
                , attribute "sound" "src: #soundClick; on: mouseenter"
                ]
                []
            , text
                [ attribute "value" "2 players"
                , color (rgb 254 200 201)
                , attribute "align" "center"
                , attribute "anchor" "center"
                ]
                []
            ]
        , entity [ position -1 0.6 -3 ]
            [ box
                [ width 1
                , height 1
                , depth 1
                , scale 1 1 0.5
                , position 0 0 -0.25
                , color (rgb 81 38 69)
                , attribute "start-game" "playersNumber: 3"
                , attribute "animation" "property: scale; dur: 250; dir: alternate; easing: easeInSine; to: 1 1 0; startEvents: mouseenter"
                , attribute "sound" "src: #soundClick; on: mouseenter"
                ]
                []
            , text
                [ attribute "value" "3 players"
                , color (rgb 254 200 201)
                , attribute "align" "center"
                , attribute "anchor" "center"
                ]
                []
            ]
        , entity [ position 1 0.6 -3 ]
            [ box
                [ width 1
                , height 1
                , depth 1
                , scale 1 1 0.5
                , position 0 0 -0.25
                , color (rgb 49 30 62)
                , attribute "start-game" "playersNumber: 4"
                , attribute "animation" "property: scale; dur: 250; dir: alternate; easing: easeInSine; to: 1 1 0; startEvents: mouseenter"
                , attribute "sound" "src: #soundClick; on: mouseenter"
                ]
                []
            , text
                [ attribute "value" "4 players"
                , color (rgb 254 200 201)
                , attribute "align" "center"
                , attribute "anchor" "center"
                ]
                []
            ]
        , sky [ color (rgb 82 97 106) ] []
        , camera
            []
            [ renderCursor "#000" 250
            ]
        ]
