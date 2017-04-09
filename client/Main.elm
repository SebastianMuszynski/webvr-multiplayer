module Main exposing (..)

import Html exposing (Html, div, text, program)
import Color exposing (rgb)
import AFrame exposing (..)
import AFrame.Primitives exposing (..)
import AFrame.Primitives.Attributes exposing (..)
import AFrame.Primitives.Camera exposing (..)
import AFrame.Primitives.Cursor exposing (..)


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello World!", Cmd.none )


type Msg
    = NoOp


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
