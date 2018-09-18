port module Main exposing (main)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick)
import LocalStorage


port hello : String -> Cmd msg


port reply : (Int -> msg) -> Sub msg


type alias Model =
    { itemKey : String
    , itemValue : String
    }


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { itemKey = "name"
      , itemValue = "Spock"
      }
    , LocalStorage.lookItemUp "foo"
    )


type Msg
    = LocalStorageLookup LocalStorage.LoadResult
    | ItemKeyInput String
    | ItemValueInput String


view : Model -> Browser.Document Msg
view model =
    { body =
        [ labeledInput model.itemKey ItemKeyInput "Key"
        , labeledInput model.itemValue ItemValueInput "Value"
        ]
    , title = "elm-typescript-interop demo"
    }


labeledInput inputValue msgConstructor label =
    div []
        [ text label
        , input [ value inputValue, Html.Events.onInput msgConstructor ] []
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LocalStorageLookup loadResult ->
            let
                _ =
                    case loadResult |> Debug.log "loadResult" of
                        LocalStorage.Found { key, value } ->
                            value |> Debug.toString |> Debug.log "found item"

                        LocalStorage.NotFound { key } ->
                            key |> Debug.log "Couldn't find item"
            in
            ( model, Cmd.none )

        ItemKeyInput newItemKey ->
            ( { model | itemKey = newItemKey }, Cmd.none )

        ItemValueInput newItemValue ->
            ( { model | itemValue = newItemValue }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    LocalStorage.itemLookup |> Sub.map LocalStorageLookup


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
