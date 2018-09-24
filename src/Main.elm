port module Main exposing (main)

import Browser
import Locale exposing (Locale)
import View


setLocale : String -> Cmd msg
setLocale localeString =
    Cmd.none


timeChanged : (String -> msg) -> Sub msg
timeChanged msgConstructor =
    Sub.none


type alias Model =
    { localizedTime : String }


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { localizedTime = "I'm not sure what time it is!" }
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
