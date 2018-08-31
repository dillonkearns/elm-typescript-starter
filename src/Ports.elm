port module Ports exposing
    ( localStorageSubscription
    , sendGoogleAnalyticsFromElm
    , storeItem
    )

import Json.Decode
import Json.Encode
import Json.Encode.Extra
import Ports.GoogleAnalytics
import Ports.LocalStorage


storeItem : Ports.LocalStorage.FromElm -> Cmd msg
storeItem msgToBrowserStorage =
    msgToBrowserStorage
        |> convertToTsRecord
        |> localStorageFromElm


localStorageSubscription : (Ports.LocalStorage.ToElm -> msg) -> Sub msg
localStorageSubscription customTypeConstructor =
    (Json.Decode.decodeValue fromLocalStorageInToCustomType
        >> Result.withDefault defaultThing
        >> customTypeConstructor
    )
        |> localStorageToElm


defaultThing : Ports.LocalStorage.ToElm
defaultThing =
    -- TODO since TypeScript has escape hatches for its type system, maybe the user
    -- should handle errors? Or at least have a flag to choose to handle errors
    -- with their generated code in the CLI?
    Ports.LocalStorage.LoadedItem
        { key = ""
        , item = Json.Encode.null
        }


type alias LoadedItemRecord =
    { key : String
    , item : Json.Encode.Value
    }


fromLocalStorageInToCustomType : Json.Decode.Decoder Ports.LocalStorage.ToElm
fromLocalStorageInToCustomType =
    Json.Decode.map2 LoadedItemRecord
        (Json.Decode.field "key" Json.Decode.string)
        (Json.Decode.field "item" Json.Decode.value)
        |> Json.Decode.map Ports.LocalStorage.LoadedItem


convertToTsRecord : Ports.LocalStorage.FromElm -> Json.Encode.Value
convertToTsRecord msgToBrowserStorage =
    case msgToBrowserStorage of
        Ports.LocalStorage.StoreItem { key, item } ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "StoreItem" )
                , ( "key", Json.Encode.string key )
                , ( "item", item )
                ]

        Ports.LocalStorage.LoadItem { key } ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "LoadItem" )
                , ( "key", Json.Encode.string key )
                ]

        Ports.LocalStorage.ClearItem { key } ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "ClearItem" )
                , ( "key", Json.Encode.string key )
                ]


port localStorageFromElm : Json.Encode.Value -> Cmd msg


port localStorageToElm : (Json.Decode.Value -> msg) -> Sub msg


port googleAnalyticsFromElm : Json.Encode.Value -> Cmd msg


sendGoogleAnalyticsFromElm : Ports.GoogleAnalytics.FromElm -> Cmd msg
sendGoogleAnalyticsFromElm portData =
    portData
        |> convertUaToTsRecord
        |> googleAnalyticsFromElm


convertUaToTsRecord : Ports.GoogleAnalytics.FromElm -> Json.Encode.Value
convertUaToTsRecord portData =
    case portData of
        Ports.GoogleAnalytics.TrackEvent data ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "TrackEvent" )
                , ( "category", Json.Encode.string data.category )
                , ( "action", Json.Encode.string data.action )
                , ( "label", Json.Encode.Extra.maybe Json.Encode.string data.label )
                ]

        Ports.GoogleAnalytics.TrackPage data ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "TrackPage" )
                , ( "category", Json.Encode.string data.path )
                ]
