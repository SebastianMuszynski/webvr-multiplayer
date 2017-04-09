module View exposing (..)

import AFrame exposing (scene)
import AFrame.Primitives exposing (box, plane)
import AFrame.Primitives.Attributes exposing (..)
import AFrame.Primitives.Camera exposing (camera)
import AFrame.Primitives.Cursor exposing (cursor)
import Color exposing (rgb)
import Html exposing (Html)
import Models exposing (Model)
import Msgs exposing (Msg)


view : Model -> Html Msg
view model =
    scene []
        [ camera [] [ cursor [] [] ]
        , plane
            [ rotation -90 0 0
            , width 30
            , height 30
            , color (rgb 92 171 125)
            ]
            []
        , box
            [ position 0 0.6 -3
            , color (rgb 240 173 0)
            ]
            []
        ]
