module View.Game exposing (..)

import AFrame exposing (entity)
import AFrame.Primitives exposing (cone, cylinder, sky, sphere, text)
import AFrame.Primitives.Attributes exposing (color, height, position, radius, rotation, scale)
import AFrame.Primitives.Camera exposing (camera)
import AFrame.Primitives.Cursor exposing (cursor, fuse, timeout)
import Color exposing (rgb)
import Html exposing (Html)
import Html.Attributes exposing (attribute)
import Models exposing (Enemy, Game, Player, Position)


renderGame : Game -> Player -> Html msg
renderGame game player =
    entity []
        [ renderCamera player
        , renderSky
        , renderFloor
        , renderPlayers game
        , renderEnemies game.enemies
        , playBackgroundMusic
        ]


renderCamera : Player -> Html msg
renderCamera player =
    let
        pos =
            player.position
    in
    entity []
        [ camera
            [ position pos.x 3 pos.z
            , attribute "user-height" "0"
            , attribute "move-player" ""
            , attribute "rotate-player" ""
            ]
            [ renderCursor player.color 1000
            , renderPoints player.points
            ]
        ]


renderCursor : String -> Int -> Html msg
renderCursor playerColor fuseTimeout =
    cursor
        [ timeout fuseTimeout
        , fuse True
        , attribute "color" playerColor
        ]
        []


renderPoints : Int -> Html msg
renderPoints points =
    text
        [ attribute "value" (toString points ++ "/10")
        , color (rgb 0 0 0)
        , position 0 -1 -2
        , attribute "align" "center"
        , attribute "font" "exo2bold"
        ]
        []


renderSky : Html msg
renderSky =
    sky [ attribute "src" "#sky" ] []


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
    let
        pos =
            player.position

        rot =
            player.rotation
    in
    entity []
        [ -- HEAD
          sphere
            [ radius 0.5
            , attribute "color" player.color
            , position pos.x 3 pos.z
            , rotation rot.x rot.y rot.z
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
            , position pos.x 2 pos.z
            , rotation 0 rot.y 0
            ]
            []

        -- ARMS
        , entity
            [ rotation 0 rot.y 0
            , position pos.x 0 pos.z
            ]
            [ cylinder
                [ radius 0.2
                , height 0.8
                , scale 0.25 1 0.25
                , attribute "color" player.color
                , position -0.3 1.8 0
                , rotation 0 rot.y 0
                ]
                []
            , cylinder
                [ radius 0.2
                , height 0.8
                , scale 0.25 1 0.25
                , attribute "color" player.color
                , position 0.3 1.8 0
                , rotation 0 rot.y 0
                ]
                []
            ]

        -- LEGS
        , entity
            [ rotation 0 rot.y 0
            , position pos.x 0 pos.z
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
        , attribute "animation" enemiesAnimation
        ]
        (List.map renderEnemy enemies)


enemiesAnimation : String
enemiesAnimation =
    "property: position;"
        ++ "dur: 1000;"
        ++ "easing: easeInOutSine;"
        ++ "to: 0 0 0"


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
            , attribute "shoot-enemy" ""
            , attribute "visible" (String.toLower <| toString enemy.isAlive)
            , attribute "animation" (enemyAnimation newPosition)
            , attribute "sound" "src: #soundShoot"
            ]
            []
        ]


enemyAnimation : String -> String
enemyAnimation position =
    "property: position;"
        ++ "dir: alternate;"
        ++ "dur: 2000;"
        ++ "easing: easeInOutSine;"
        ++ "loop: true;"
        ++ ("to: " ++ position)


playBackgroundMusic : Html msg
playBackgroundMusic =
    entity
        [ attribute "sound" "src: #soundBackground; autoplay: true; loop: true"
        ]
        []
