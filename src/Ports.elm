port module Ports exposing
    ( MsgFromBrowserStorage(..)
    , MsgToBrowserStorage(..)
    , localStorageSubscription
    , storeItem
    )

import Json.Decode
import Json.Encode


storeItem : MsgToBrowserStorage -> Cmd msg
storeItem msgToBrowserStorage =
    msgToBrowserStorage
        |> convertToTsRecord
        |> localStorageFromElm


localStorageSubscription : (MsgFromBrowserStorage -> msg) -> Sub msg
localStorageSubscription customTypeConstructor =
    (Json.Decode.decodeValue fromLocalStorageInToCustomType
        >> Result.withDefault defaultThing
        >> customTypeConstructor
    )
        |> localStorageToElm


defaultThing : MsgFromBrowserStorage
defaultThing =
    -- TODO since TypeScript has escape hatches for its type system, maybe the user
    -- should handle errors? Or at least have a flag to choose to handle errors
    -- with their generated code in the CLI?
    LoadedItem
        { key = ""
        , item = Json.Encode.null
        }


type alias LoadedItemRecord =
    { key : String
    , item : Json.Encode.Value
    }


fromLocalStorageInToCustomType : Json.Decode.Decoder MsgFromBrowserStorage
fromLocalStorageInToCustomType =
    Json.Decode.map2 LoadedItemRecord
        (Json.Decode.field "key" Json.Decode.string)
        (Json.Decode.field "item" Json.Decode.value)
        |> Json.Decode.map LoadedItem


convertToTsRecord : MsgToBrowserStorage -> Json.Encode.Value
convertToTsRecord msgToBrowserStorage =
    case msgToBrowserStorage of
        StoreItem { key, item } ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "StoreItem" )
                , ( "key", Json.Encode.string key )
                , ( "item", item )
                ]

        LoadItem { key } ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "LoadItem" )
                , ( "key", Json.Encode.string key )
                ]

        ClearItem { key } ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "ClearItem" )
                , ( "key", Json.Encode.string key )
                ]


type MsgToBrowserStorage
    = StoreItem { key : String, item : Json.Encode.Value }
    | LoadItem { key : String }
    | ClearItem { key : String }


port localStorageFromElm : Json.Encode.Value -> Cmd msg


port localStorageToElm : (Json.Decode.Value -> msg) -> Sub msg


type MsgFromBrowserStorage
    = LoadedItem { key : String, item : Json.Encode.Value }
