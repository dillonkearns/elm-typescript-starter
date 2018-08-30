port module Ports exposing
    ( localStorageSubscription
    , storeItem
    )

import Json.Decode
import Json.Encode
import PortTypes


storeItem : PortTypes.MsgToBrowserStorage -> Cmd msg
storeItem msgToBrowserStorage =
    msgToBrowserStorage
        |> convertToTsRecord
        |> localStorageFromElm


localStorageSubscription : (PortTypes.MsgFromBrowserStorage -> msg) -> Sub msg
localStorageSubscription customTypeConstructor =
    (Json.Decode.decodeValue fromLocalStorageInToCustomType
        >> Result.withDefault defaultThing
        >> customTypeConstructor
    )
        |> localStorageToElm


defaultThing : PortTypes.MsgFromBrowserStorage
defaultThing =
    -- TODO since TypeScript has escape hatches for its type system, maybe the user
    -- should handle errors? Or at least have a flag to choose to handle errors
    -- with their generated code in the CLI?
    PortTypes.LoadedItem
        { key = ""
        , item = Json.Encode.null
        }


type alias LoadedItemRecord =
    { key : String
    , item : Json.Encode.Value
    }


fromLocalStorageInToCustomType : Json.Decode.Decoder PortTypes.MsgFromBrowserStorage
fromLocalStorageInToCustomType =
    Json.Decode.map2 LoadedItemRecord
        (Json.Decode.field "key" Json.Decode.string)
        (Json.Decode.field "item" Json.Decode.value)
        |> Json.Decode.map PortTypes.LoadedItem


convertToTsRecord : PortTypes.MsgToBrowserStorage -> Json.Encode.Value
convertToTsRecord msgToBrowserStorage =
    case msgToBrowserStorage of
        PortTypes.StoreItem { key, item } ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "StoreItem" )
                , ( "key", Json.Encode.string key )
                , ( "item", item )
                ]

        PortTypes.LoadItem { key } ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "LoadItem" )
                , ( "key", Json.Encode.string key )
                ]

        PortTypes.ClearItem { key } ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "ClearItem" )
                , ( "key", Json.Encode.string key )
                ]


port localStorageFromElm : Json.Encode.Value -> Cmd msg


port localStorageToElm : (Json.Decode.Value -> msg) -> Sub msg
