module Main exposing (..)

import Html exposing (Html, div, text, program)
import Color exposing (rgb)
import AFrame exposing (..)
import AFrame.Primitives exposing (..)
import AFrame.Primitives.Attributes exposing (..)


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
        [ box
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
