module View.Main exposing (..)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (src, style)
import Models exposing (Model)
import View.Scene exposing (renderScene)


view : Model -> Html msg
view model =
    case model.error of
        Just errorMsg ->
            renderErrorMsg errorMsg

        Nothing ->
            let
                game =
                    model.game

                playerId =
                    game.currentPlayerId

                currentPlayer =
                    List.head <| List.filter (\a -> a.id == playerId) game.players
            in
            case currentPlayer of
                Just player ->
                    renderScene game player

                Nothing ->
                    div [] [ text "Loading..." ]


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
