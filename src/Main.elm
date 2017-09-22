port module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    reply ReplyReceived


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, hello "World" )


type Msg
    = Increment
    | Decrement
    | ReplyReceived Int


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


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "---" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+++" ]
        ]


port hello : String -> Cmd msg


port reply : (Int -> msg) -> Sub msg
