port module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, style, value)
import Html.Events exposing (onClick)
import Json.Encode


type alias Model =
    { clockReading : String
    }


type alias Flags =
    ()


type Locale
    = English
    | Es
    | Norwegian
    | Bengali
    | Farsi


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

        Farsi ->
            "fa"


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { clockReading = "I'm not sure what time it is!" }
    , Cmd.none
    )


type Msg
    = NoOp
    | SetLocale Locale


view : Model -> Browser.Document Msg
view model =
    { body =
        [ div [ class "text-center" ]
            [ localeButtons
            , h1 [] [ text model.clockReading ]
            ]
        ]
    , title = "elm-typescript-interop demo"
    }


localeButtons =
    div []
        ([ English
         , Norwegian
         , Bengali
         , Farsi
         ]
            |> List.map localeButton
        )


localeButton : Locale -> Html Msg
localeButton locale =
    button
        [ class "btn-lg btn-primary"
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

        SetLocale locale ->
            ( model, setLocaleCmd locale )


setLocaleCmd : Locale -> Cmd msg
setLocaleCmd locale =
    locale |> localeToString |> setLocale


setLocale something =
    Cmd.none


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
