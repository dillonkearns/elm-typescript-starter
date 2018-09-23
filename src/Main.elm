port module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, style, value)
import Html.Events exposing (onClick)
import Json.Encode
import Locale exposing (Locale)


port timeChanged : (String -> msg) -> Sub msg


type alias Model =
    { clockReading : String
    }


type alias Flags =
    String


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { clockReading = flags }
    , Cmd.none
    )


type Msg
    = NoOp
    | SetLocale Locale
    | TimeChanged String


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
        ([ Locale.English
         , Locale.Norwegian
         , Locale.Bengali
         , Locale.Farsi
         ]
            |> List.map (localeButton SetLocale)
        )


localeButton : (Locale -> msg) -> Locale -> Html msg
localeButton setLocaleMsg locale =
    button
        [ class "btn-lg btn-primary"
        , style "margin-top" "20px"
        , style "margin-bottom" "20px"
        , Html.Events.onClick (setLocaleMsg locale)
        ]
        [ locale |> Debug.toString |> text ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        SetLocale locale ->
            ( model, setLocaleCmd locale )

        TimeChanged newTime ->
            ( { model | clockReading = newTime }, Cmd.none )


setLocaleCmd : Locale -> Cmd msg
setLocaleCmd locale =
    locale |> Locale.toString |> setLocale


setLocale something =
    Cmd.none


subscriptions : Model -> Sub Msg
subscriptions model =
    timeChanged TimeChanged


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
