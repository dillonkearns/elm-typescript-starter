port module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick)
import Json.Encode


port newClockReading : (String -> msg) -> Sub msg


port setLocale : String -> Cmd msg


type alias Model =
    { daysUntil : String
    , clockReading : String
    }


type alias Flags =
    String


type Locale
    = En
    | Es
    | No
    | Bn


localeToString : Locale -> String
localeToString locale =
    case locale of
        En ->
            "en-us"

        Es ->
            "es"

        No ->
            "no"

        Bn ->
            "bn"


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { daysUntil = flags
      , clockReading = ""
      }
    , Bn |> localeToString |> setLocale
    )


type Msg
    = NoOp
    | NewClockReading String


view : Model -> Browser.Document Msg
view model =
    { body =
        [ h1 [] [ text ("time: " ++ model.clockReading) ]
        , h2 [] [ "elm-conf is " ++ model.daysUntil ++ "!!!" |> text ]
        ]
    , title = "elm-typescript-interop demo"
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        NewClockReading clockReading ->
            ( { model | clockReading = clockReading }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    newClockReading NewClockReading


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
