port module LocalStorage exposing (LoadResult(..), itemLookup, lookItemUp, storageStoreItem)

import Json.Decode
import Json.Encode


port storageStoreItem : { key : String, value : Json.Encode.Value } -> Cmd msg


port lookItemUp : String -> Cmd msg


port storageItemFound : ({ key : String, value : Json.Decode.Value } -> msg) -> Sub msg


port storageItemNotFound : ({ key : String } -> msg) -> Sub msg


itemLookup : Sub LoadResult
itemLookup =
    Sub.batch
        [ storageItemFound Found
        , storageItemNotFound NotFound
        ]


type LoadResult
    = Found { key : String, value : Json.Decode.Value }
    | NotFound { key : String }
