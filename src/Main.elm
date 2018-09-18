port module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick)
import Json.Encode


type alias Model =
    ()


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( (), Cmd.none )


type Msg
    = NoOp


view : Model -> Browser.Document Msg
view model =
    { body =
        [ h1 [] [ text "Hello!" ]
        ]
    , title = "elm-typescript-interop demo"
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
