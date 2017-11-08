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
                renderChoosePlayersBtns
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


renderChoosePlayersBtns : Html msg
renderChoosePlayersBtns =
    entity []
        [ renderChoosePlayerBtn -1 2.6 (rgb 223 64 90) "1" "1 player"
        , renderChoosePlayerBtn 1 2.6 (rgb 135 49 78) "2" "2 players"
        , renderChoosePlayerBtn -1 0.6 (rgb 81 38 69) "3" "3 players"
        , renderChoosePlayerBtn 1 0.6 (rgb 49 30 62) "4" "4 players"
        , sky [ color (rgb 82 97 106) ] []
        , camera
            []
            [ renderCursor "#000" 250
            ]
        ]


renderChoosePlayerBtn : Float -> Float -> Color.Color -> String -> String -> Html msg
renderChoosePlayerBtn posX posY rgbColor playersNumber displayTxt =
    entity [ position posX posY -3 ]
        [ box
            [ width 1
            , height 1
            , depth 1
            , scale 1 1 0.5
            , position 0 0 -0.25
            , color rgbColor
            , attribute "start-game" ("playersNumber: " ++ playersNumber)
            , attribute "animation" "property: scale; dur: 250; dir: alternate; easing: easeInSine; to: 1 1 0; startEvents: mouseenter"
            , attribute "sound" "src: #soundClick; on: mouseenter"
            ]
            []
        , text
            [ attribute "value" displayTxt
            , color (rgb 254 200 201)
            , attribute "align" "center"
            , attribute "anchor" "center"
            ]
            []
        ]
