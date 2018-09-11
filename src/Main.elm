port module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


port hello : String -> Cmd msg


port reply : (Int -> msg) -> Sub msg


type alias Model =
    Int


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( 0, hello "World" )


type Msg
    = Increment
    | Decrement
    | ReplyReceived Int


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "---" ]
        , div [] [ text (Debug.toString model) ]
        , button [ onClick Increment ] [ text "+++" ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none )

        ReplyReceived message ->
            let
                _ =
                    Debug.log "ReplyReceived" message
            in
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    reply ReplyReceived


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
