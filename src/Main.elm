port module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, style, value)
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
    = English
    | Es
    | Norwegian
    | Bengali
    | Farsee


localeToString : Locale -> String
localeToString locale =
    case locale of
        English ->
            "en-us"

        Es ->
            "es"

        Norwegian ->
            "nb"

        Bengali ->
            "bn"

        Farsee ->
            "fa"


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { daysUntil = flags
      , clockReading = ""
      }
    , setLocaleCmd English
    )


type Msg
    = NoOp
    | NewClockReading String
    | SetLocale Locale


view : Model -> Browser.Document Msg
view model =
    { body =
        [ div [ class "text-center" ]
            [ localeButtons
            , h1 [] [ text model.clockReading ]
            , h2 [] [ "elm-conf is " ++ model.daysUntil ++ "!!!" |> text ]
            ]
        ]
    , title = "elm-typescript-interop demo"
    }


localeButtons =
    div []
        ([ English
         , Norwegian
         , Bengali
         , Farsee
         ]
            |> List.map localeButton
        )


localeButton : Locale -> Html Msg
localeButton locale =
    button
        [ class "btn btn-primary"
        , style "margin-top" "20px"
        , style "margin-bottom" "20px"
        , Html.Events.onClick (SetLocale locale)
        ]
        [ locale |> Debug.toString |> text ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        NewClockReading clockReading ->
            ( { model | clockReading = clockReading }, Cmd.none )

        SetLocale locale ->
            ( model, setLocaleCmd locale )


setLocaleCmd : Locale -> Cmd msg
setLocaleCmd locale =
    locale |> localeToString |> setLocale


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
