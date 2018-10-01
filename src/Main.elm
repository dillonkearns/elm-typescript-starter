port module Main exposing (main)

import Browser
import Locale exposing (Locale)
import View


port setLocale : String -> Cmd msg


port timeChanged : (String -> msg) -> Sub msg


type alias Model =
    { localizedTime : String }


type alias Flags =
    { startTime : String }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { localizedTime = flags.startTime }
    , Cmd.none
    )


type Msg
    = NoOp
    | SetLocale Locale
    | TimeChanged String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        SetLocale locale ->
            ( model, setLocaleCmd locale )

        TimeChanged newTime ->
            ( { model | localizedTime = newTime }, Cmd.none )


setLocaleCmd : Locale -> Cmd msg
setLocaleCmd locale =
    locale |> Locale.toString |> setLocale


subscriptions : Model -> Sub Msg
subscriptions model =
    timeChanged TimeChanged


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = View.view SetLocale
        , update = update
        , subscriptions = subscriptions
        }
