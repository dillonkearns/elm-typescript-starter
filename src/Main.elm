port module Main exposing (main)

import Html exposing (Html, button, div, text)
import Json.Encode
import PortTypes
import Ports


port hello : String -> Cmd msg


port reply : (Int -> msg) -> Sub msg


type alias Model =
    ()


init : ( Model, Cmd Msg )
init =
    ( ()
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
        , Ports.sendUniversalAnalyticsFromElm (PortTypes.TrackPage { path = "/" })
        ]
    )


type Msg
    = ReplyReceived Int
    | GotLocalStorage PortTypes.LocalStorageToElm


view : Model -> Html Msg
view model =
    div [] []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplyReceived message ->
            let
                _ =
                    Debug.log "ReplyReceived" message
            in
            ( model, Cmd.none )

        GotLocalStorage thing ->
            let
                _ =
                    Debug.log "GotLocalStorage" thing
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
