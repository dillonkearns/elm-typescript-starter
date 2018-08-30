port module Main exposing (main)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Json.Encode
import PortTypes
import Ports


port hello : String -> Cmd msg


port reply : (Int -> msg) -> Sub msg


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0
    , Cmd.batch
        [ Ports.storeItem
            (PortTypes.StoreItem
                { key = "my-key"
                , item = Json.Encode.int 123456
                }
            )
        , Ports.storeItem
            (PortTypes.LoadItem
                { key = "my-key" }
            )
        ]
    )


type Msg
    = Increment
    | Decrement
    | ReplyReceived Int
    | GotLocalStorage PortTypes.LocalStorageToElm


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "---" ]
        , div [] [ text (toString model) ]
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

        GotLocalStorage thing ->
            let
                _ =
                    Debug.log "got local storage" thing
            in
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ reply ReplyReceived
        , Ports.localStorageSubscription GotLocalStorage
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
