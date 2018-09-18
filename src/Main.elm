port module Main exposing (main)

import Browser
import Html exposing (Html, button, div, h2, input, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick)
import Json.Encode
import LocalStorage


port hello : String -> Cmd msg


port reply : (Int -> msg) -> Sub msg


type alias Model =
    { itemKey : String
    , itemValue : String
    , loadedItem : Maybe LocalStorage.LoadResult
    }


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { itemKey = "name"
      , itemValue = "Spock"
      , loadedItem = Nothing
      }
    , Cmd.none
    )


type Msg
    = LocalStorageLookup LocalStorage.LoadResult
    | StoreItem
    | LoadItem
    | ItemKeyInput String
    | ItemValueInput String


view : Model -> Browser.Document Msg
view model =
    { body =
        [ labeledInput model.itemKey ItemKeyInput "Key"
        , labeledInput model.itemValue ItemValueInput "Value"
        , button [ Html.Events.onClick StoreItem ] [ text "Store Item" ]
        , button [ Html.Events.onClick LoadItem ] [ text "Load Key" ]
        , loadedItemView model.loadedItem
        ]
    , title = "elm-typescript-interop demo"
    }


loadedItemView maybeLoadedItem =
    case maybeLoadedItem of
        Just loadedItem ->
            div []
                [ h2 [] [ text "Loaded Item" ]
                , loadedItem |> Debug.toString |> text
                ]

        Nothing ->
            div [] [ text "Nothing loaded yet..." ]


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
            ( { model | loadedItem = Just loadResult }, Cmd.none )

        LoadItem ->
            ( model, LocalStorage.lookItemUp model.itemKey )

        ItemKeyInput newItemKey ->
            ( { model | itemKey = newItemKey }, Cmd.none )

        ItemValueInput newItemValue ->
            ( { model | itemValue = newItemValue }, Cmd.none )

        StoreItem ->
            ( model
            , LocalStorage.storageStoreItem
                { key = model.itemKey
                , value = Json.Encode.string model.itemValue
                }
            )


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
